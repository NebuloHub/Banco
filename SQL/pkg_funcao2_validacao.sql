--------------------------------------------------------------------------------
--                                  spec
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pkg_funcao2_validacao AS
  FUNCTION analisar_startup(p_cnpj VARCHAR2)
    RETURN CLOB;
END pkg_funcao2_validacao;


--------------------------------------------------------------------------------
--                                  Body
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pkg_funcao2_validacao AS

  FUNCTION analisar_startup(p_cnpj VARCHAR2)
    RETURN CLOB
  IS
    v_json_resultado     CLOB;
    v_nome               startup.nome_startup%TYPE;
    v_email              startup.email_startup%TYPE;
    v_site               startup.site%TYPE;
    v_total_hab_startup  NUMBER;
    v_total_hab_geral    NUMBER;
    v_percentual_sucesso NUMBER;

    v_validacoes_ok      BOOLEAN := TRUE;
    v_msg_erro           VARCHAR2(4000) := '';
  BEGIN

    ------------------------------------------------
    -- BUSCA DADOS DA STARTUP 
    ------------------------------------------------
    BEGIN
      SELECT nome_startup, email_startup, site
        INTO v_nome, v_email, v_site
        FROM startup
       WHERE cnpj = p_cnpj;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN '{"erro":"Startup não encontrada para o CNPJ informado."}';
      WHEN OTHERS THEN
        RETURN '{"erro":"Erro ao consultar a startup: ' || REPLACE(SQLERRM,'"','''') || '"}';
    END;

    -- Sanitização
    v_site := NVL(TRIM(REPLACE(REPLACE(v_site,'"',''),'''','')), '');

    ------------------------------------------------
    -- VALIDAÇÃO DO CNPJ 
    ------------------------------------------------
    BEGIN
      IF NOT REGEXP_LIKE(p_cnpj, '^[0-9]{14}$') THEN
        v_validacoes_ok := FALSE;
        RAISE_APPLICATION_ERROR(-20001, 'CNPJ inválido');
      END IF;

    EXCEPTION
      WHEN OTHERS THEN
        v_validacoes_ok := FALSE;
        v_msg_erro := v_msg_erro || 'Erro no CNPJ: ' ||
          REPLACE(SQLERRM,'"','''') || ' | ';
    END;

    ------------------------------------------------
    -- VALIDAÇÃO DO EMAIL
    ------------------------------------------------
    BEGIN
      IF NOT REGEXP_LIKE(v_email,
        '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
        v_validacoes_ok := FALSE;
        RAISE_APPLICATION_ERROR(-20002, 'E-mail inválido');
      END IF;

    EXCEPTION
      WHEN OTHERS THEN
        v_validacoes_ok := FALSE;
        v_msg_erro := v_msg_erro || 'Erro no E-mail: ' ||
          REPLACE(SQLERRM,'"','''') || ' | ';
    END;

    ------------------------------------------------
    -- VALIDAÇÃO DO SITE
    ------------------------------------------------
    BEGIN
      IF NOT REGEXP_LIKE(v_site,
        '^(https?://)([A-Za-z0-9-]+\.)+[A-Za-z]{2,}(\/.*)?$') THEN
        v_validacoes_ok := FALSE;
        RAISE_APPLICATION_ERROR(-20003, 'Site inválido');
      END IF;

    EXCEPTION
      WHEN OTHERS THEN
        v_validacoes_ok := FALSE;
        v_msg_erro := v_msg_erro || 'Erro no Site: ' ||
          REPLACE(SQLERRM,'"','''') || ' | ';
    END;

    ------------------------------------------------
    -- CÁLCULO DO PERCENTUAL
    ------------------------------------------------
    BEGIN
      SELECT COUNT(*) INTO v_total_hab_startup
        FROM possui
       WHERE cnpj = p_cnpj;

      SELECT COUNT(DISTINCT id_habilidade)
        INTO v_total_hab_geral
        FROM possui;

      IF v_total_hab_geral > 0 THEN
        v_percentual_sucesso :=
          ROUND((v_total_hab_startup / v_total_hab_geral) * 100, 2);
      ELSE
        v_percentual_sucesso := 0;
      END IF;

    EXCEPTION
      WHEN OTHERS THEN
        RETURN '{"erro":"Erro ao calcular percentual: ' ||
               REPLACE(SQLERRM,'"','''') || '"}';
    END;


    ------------------------------------------------
    -- MONTAGEM MANUAL DO JSON
    ------------------------------------------------
    IF v_validacoes_ok THEN
      v_msg_erro := 'Startup validada com sucesso. Potencial de ' ||
                     v_percentual_sucesso || '%.';
    ELSE
      v_msg_erro := RTRIM(v_msg_erro, ' | ');
    END IF;

    v_json_resultado :=
        '{' ||
        '"cnpj":"' || p_cnpj || '",' ||
        '"nome_startup":"' || REPLACE(v_nome,'"','''') || '",' ||
        '"site":"' || REPLACE(v_site,'"','''') || '",' ||
        '"qtd_habilidades":' || v_total_hab_startup || ',' ||
        '"percentual_sucesso":' || v_percentual_sucesso || ',' ||
        '"validacoes":"' || CASE WHEN v_validacoes_ok THEN 'OK' ELSE 'Falhou' END || '",' ||
        '"mensagem":"' || REPLACE(v_msg_erro,'"','''') || '"' ||
        '}';

    RETURN v_json_resultado;


  EXCEPTION
    WHEN OTHERS THEN
      RETURN '{"erro":"Erro inesperado: ' ||
              REPLACE(SQLERRM,'"','''') || '"}';
  END analisar_startup;

END pkg_funcao2_validacao;
