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
    v_json_resultado   CLOB;
    v_nome             startup.nome_startup%TYPE;
    v_email            startup.email_startup%TYPE;
    v_site             startup.site%TYPE;
    v_total_hab_startup NUMBER;
    v_total_hab_geral   NUMBER;
    v_percentual_sucesso NUMBER;
    v_validacoes_ok BOOLEAN := TRUE;
  BEGIN
    -- Busca dados da startup
    SELECT nome_startup, email_startup, site
      INTO v_nome, v_email, v_site
      FROM startup
     WHERE cnpj = p_cnpj;

    -- ==========================
    -- Validações com REGEXP
    -- ==========================

    IF NOT REGEXP_LIKE(p_cnpj, '^[0-9]{14}$') THEN
      v_validacoes_ok := FALSE;
      RAISE_APPLICATION_ERROR(-20001, 'CNPJ inválido. Deve conter apenas 14 dígitos numéricos.');
    END IF;

    IF NOT REGEXP_LIKE(v_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
      v_validacoes_ok := FALSE;
      RAISE_APPLICATION_ERROR(-20002, 'E-mail da startup inválido. Verifique o formato.');
    END IF;

    IF NOT REGEXP_LIKE(v_site, '^(https?:\/\/)[\w\-\.]+\.\w{2,}') THEN
      v_validacoes_ok := FALSE;
      RAISE_APPLICATION_ERROR(-20003, 'Site inválido. Deve começar com http:// ou https://');
    END IF;

    -- ==========================
    -- Cálculo de sucesso
    -- ==========================

    SELECT COUNT(*) INTO v_total_hab_startup
      FROM possui
     WHERE cnpj = p_cnpj;

    SELECT COUNT(DISTINCT id_habilidade) INTO v_total_hab_geral
      FROM possui;

    IF v_total_hab_geral > 0 THEN
      v_percentual_sucesso := ROUND((v_total_hab_startup / v_total_hab_geral) * 100, 2);
    ELSE
      v_percentual_sucesso := 0;
    END IF;

    -- ==========================
    -- Retorno JSON
    -- ==========================

    v_json_resultado := JSON_OBJECT(
      'cnpj' VALUE p_cnpj,
      'nome_startup' VALUE v_nome,
      'validacoes' VALUE CASE WHEN v_validacoes_ok THEN 'OK' ELSE 'Falhou' END,
      'qtd_habilidades' VALUE v_total_hab_startup,
      'percentual_sucesso' VALUE v_percentual_sucesso,
      'mensagem' VALUE CASE
        WHEN v_validacoes_ok THEN
          'Startup validada com sucesso. Potencial estimado de ' || v_percentual_sucesso || '%.'
        ELSE
          'Erro na validação dos dados.'
      END
    );

    RETURN v_json_resultado;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN JSON_OBJECT(
        'erro' VALUE 'Startup não encontrada para o CNPJ informado.'
      );
    WHEN OTHERS THEN
      RETURN JSON_OBJECT(
        'erro' VALUE 'Erro ao processar análise: ' || SQLERRM
      );
  END analisar_startup;

END pkg_funcao2_validacao;

