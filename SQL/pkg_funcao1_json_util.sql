--------------------------------------------------------------------------------
--                                  spec
--------------------------------------------------------------------------------

create or replace PACKAGE pkg_funcao1_json_util AS
  FUNCTION gerar_json_perfil(p_cpf_usuario IN usuario.cpf%TYPE) RETURN CLOB;
END pkg_funcao1_json_util;


--------------------------------------------------------------------------------
--                                  Body
--------------------------------------------------------------------------------

create or replace PACKAGE BODY pkg_funcao1_json_util AS

  ----------------------------------------------------------------------------
  -- Função auxiliar: escapa aspas e barras básicas para inclusão em JSON
  ----------------------------------------------------------------------------
  FUNCTION escape_json(p_str IN VARCHAR2) RETURN VARCHAR2 IS
    v_tmp VARCHAR2(32767);
  BEGIN
    IF p_str IS NULL THEN
      RETURN '';
    END IF;
    v_tmp := p_str;
    -- escapar backslash primeiro
    v_tmp := REPLACE(v_tmp, '\', '\\');
    -- escapar aspas duplas
    v_tmp := REPLACE(v_tmp, '"', '\"');
    -- substituir nova linha por \n para ficar em uma linha JSON
    v_tmp := REPLACE(v_tmp, CHR(10), '\n');
    v_tmp := REPLACE(v_tmp, CHR(13), '\r');
    RETURN v_tmp;
  EXCEPTION
    WHEN VALUE_ERROR THEN
      RETURN '';
    WHEN OTHERS THEN
      RETURN '';
  END escape_json;


  ----------------------------------------------------------------------------
  -- Função principal
  ----------------------------------------------------------------------------
  FUNCTION gerar_json_perfil(p_cpf_usuario IN usuario.cpf%TYPE) RETURN CLOB IS
    v_json           CLOB := EMPTY_CLOB();
    v_nome           usuario.nome%TYPE;
    v_email          usuario.email%TYPE;
    v_telefone       usuario.telefone%TYPE;
    v_cpf            usuario.cpf%TYPE;
    CUR_STARTUP      SYS_REFCURSOR;
    CUR_HAB          SYS_REFCURSOR;

    -- colunas da startup
    v_start_cnpj         startup.cnpj%TYPE;
    v_start_video        startup.video%TYPE;
    v_start_nome         startup.nome_startup%TYPE;
    v_start_site         startup.site%TYPE;
    v_start_descricao    startup.descricao%TYPE;
    v_start_responsavel  startup.nome_responsavel%TYPE;
    v_start_email        startup.email_startup%TYPE;
    v_start_cpf          startup.cpf%TYPE;

    -- colunas da habilidade
    v_h_id        habilidade.id_habilidade%TYPE;
    v_h_nome      habilidade.nome_habilidade%TYPE;
    v_first_startup BOOLEAN := TRUE;
    v_first_hab     BOOLEAN;
  BEGIN
    -- validação simples do CPF: apenas dígitos (11)
    IF p_cpf_usuario IS NULL OR NOT REGEXP_LIKE(p_cpf_usuario, '^\d{11}$') THEN
      DBMS_OUTPUT.PUT_LINE('CPF inválido/formato incorreto: ' || NVL(p_cpf_usuario,'NULL'));
      BEGIN
        pkg_auditoria.registrar_log('FUNC_JSON','VALIDACAO_CPF',USER,'CPF inválido: ' || NVL(p_cpf_usuario,'NULL'));
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
      RETURN '{"erro":"CPF inválido"}';
    END IF;

    -- 1) obter dados do usuário (lança NO_DATA_FOUND se não existir)
    SELECT cpf, nome, email, telefone INTO v_cpf, v_nome, v_email, v_telefone
      FROM usuario
     WHERE cpf = p_cpf_usuario;

    -- valida e-mail do usuário (apenas aviso; não aborta)
    IF v_email IS NOT NULL AND NOT REGEXP_LIKE(v_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
      DBMS_OUTPUT.PUT_LINE('Aviso: e-mail do usuário com formato inválido: ' || v_email);
      BEGIN
        pkg_auditoria.registrar_log('FUNC_JSON','VALIDACAO_EMAIL',USER,'Email usuario invalido: ' || v_email || ' (CPF:' || v_cpf || ')');
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
    END IF;

    -- inicia JSON (usando CLOB)
    v_json := '{' ||
              '"cpf":"' || escape_json(v_cpf) || '",' ||
              '"nome":"' || escape_json(v_nome) || '",' ||
              '"email":"' || escape_json(NVL(v_email,'')) || '",' ||
              '"telefone":"' || NVL(TO_CHAR(v_telefone),'') || '",' ||
              '"startups":[';

    -- 2) cursor para startups do usuário (inclui todas as colunas da tabela startup)
    OPEN CUR_STARTUP FOR
      SELECT cnpj, video, nome_startup, site, descricao, nome_responsavel, email_startup, cpf
        FROM startup
       WHERE cpf = p_cpf_usuario
       ORDER BY nome_startup;

    LOOP
      FETCH CUR_STARTUP INTO v_start_cnpj, v_start_video, v_start_nome, v_start_site,
                             v_start_descricao, v_start_responsavel, v_start_email, v_start_cpf;
      EXIT WHEN CUR_STARTUP%NOTFOUND;

      IF v_first_startup THEN
        v_first_startup := FALSE;
      ELSE
        v_json := v_json || ',';
      END IF;

      -- valida email da startup (apenas log/aviso)
      IF v_start_email IS NOT NULL AND NOT REGEXP_LIKE(v_start_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
        DBMS_OUTPUT.PUT_LINE('Aviso: e-mail da startup inválido: ' || v_start_email || ' (CNPJ:' || v_start_cnpj || ')');
        BEGIN
          pkg_auditoria.registrar_log('FUNC_JSON','VALIDACAO_EMAIL_STARTUP',USER,'Email startup invalido: ' || v_start_email || ' (CNPJ:' || v_start_cnpj || ')');
        EXCEPTION WHEN OTHERS THEN NULL;
        END;
      END IF;

      -- montar objeto startup (inclui todas as colunas)
      v_json := v_json || '{' ||
                '"cnpj":"' || escape_json(NVL(v_start_cnpj,'')) || '",' ||
                '"video":"' || escape_json(NVL(v_start_video,'')) || '",' ||
                '"nome_startup":"' || escape_json(NVL(v_start_nome,'')) || '",' ||
                '"site":"' || escape_json(NVL(v_start_site,'')) || '",' ||
                '"descricao":"' || escape_json(NVL(v_start_descricao,'')) || '",' ||
                '"nome_responsavel":"' || escape_json(NVL(v_start_responsavel,'')) || '",' ||
                '"email_startup":"' || escape_json(NVL(v_start_email,'')) || '",' ||
                '"cpf_responsavel":"' || escape_json(NVL(v_start_cpf,'')) || '",' ||
                '"habilidades":[';

      -- 3) cursor para habilidades desta startup (via possui)
      v_first_hab := TRUE;
      OPEN CUR_HAB FOR
        SELECT h.id_habilidade, h.nome_habilidade
          FROM possui p JOIN habilidade h ON p.id_habilidade = h.id_habilidade
         WHERE p.cnpj = v_start_cnpj
         ORDER BY h.nome_habilidade;

      LOOP
        FETCH CUR_HAB INTO v_h_id, v_h_nome;
        EXIT WHEN CUR_HAB%NOTFOUND;

        IF v_first_hab THEN
          v_first_hab := FALSE;
        ELSE
          v_json := v_json || ',';
        END IF;

        v_json := v_json || '{"id":' || NVL(TO_CHAR(v_h_id),'0') || ',"nome":"' || escape_json(NVL(v_h_nome,'')) || '"}';
      END LOOP; -- CUR_HAB
      CLOSE CUR_HAB;

      v_json := v_json || ']}' ; -- fecha habilidades e objeto startup
    END LOOP; -- CUR_STARTUP
    CLOSE CUR_STARTUP;

    v_json := v_json || ']}'; -- fecha array startups e objeto principal

    RETURN v_json;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- usuário não encontrado
      DBMS_OUTPUT.PUT_LINE('Nenhum usuário encontrado para CPF: ' || NVL(p_cpf_usuario,'NULL'));
      BEGIN
        pkg_auditoria.registrar_log('FUNC_JSON','NO_DATA_FOUND',USER,'CPF não encontrado: ' || NVL(p_cpf_usuario,'NULL'));
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
      RETURN '{"erro":"usuario nao encontrado"}';

    WHEN VALUE_ERROR THEN
      -- erro de conversão, p.ex. tamanho de string
      DBMS_OUTPUT.PUT_LINE('Erro de valor ao gerar JSON para CPF: ' || NVL(p_cpf_usuario,'NULL') || ' -> ' || SQLERRM);
      BEGIN
        pkg_auditoria.registrar_log('FUNC_JSON','VALUE_ERROR',USER,'Erro VALUE para CPF ' || NVL(p_cpf_usuario,'NULL') || ': ' || SQLERRM);
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
      RETURN '{"erro":"value_error"}';

    WHEN OTHERS THEN
      -- qualquer outro erro
      DBMS_OUTPUT.PUT_LINE('Erro inesperado ao gerar JSON: ' || SQLERRM);
      BEGIN
        pkg_auditoria.registrar_log('FUNC_JSON','OTHERS',USER,'Erro inesperado gerar_json_perfil CPF:'||NVL(p_cpf_usuario,'NULL')||' - '||SQLERRM);
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
      RETURN '{"erro":"erro inesperado"}';
  END gerar_json_perfil;

END pkg_funcao1_json_util;