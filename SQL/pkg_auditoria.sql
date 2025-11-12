--------------------------------------------------------------------------------
--                                  spec
--------------------------------------------------------------------------------

create or replace PACKAGE pkg_auditoria AS
  -- Procedure para inserir log manualmente
  PROCEDURE registrar_log(
    p_tabela      VARCHAR2,
    p_operacao    VARCHAR2,
    p_usuario     VARCHAR2,
    p_descricao   VARCHAR2
  );

  -- Procedure para exibir logs (para debug ou consulta)
  PROCEDURE listar_logs;

END pkg_auditoria;


--------------------------------------------------------------------------------
--                                  Body
--------------------------------------------------------------------------------

create or replace PACKAGE BODY pkg_auditoria AS

  PROCEDURE registrar_log(
    p_tabela      VARCHAR2,
    p_operacao    VARCHAR2,
    p_usuario     VARCHAR2,
    p_descricao   VARCHAR2
  ) AS
  BEGIN
    INSERT INTO auditoria (
      id_auditoria,
      nome_tabela,
      operacao,
      usuario_execucao,
      data_execucao,
      descricao
    )
    VALUES (
      auditoria_seq.NEXTVAL,
      p_tabela,
      p_operacao,
      p_usuario,
      SYSDATE,
      p_descricao
    );
  END registrar_log;

  PROCEDURE listar_logs AS
  BEGIN
    FOR r IN (SELECT * FROM auditoria ORDER BY data_execucao DESC) LOOP
      DBMS_OUTPUT.PUT_LINE('[' || r.data_execucao || '] ' || r.usuario_execucao || ' -> ' || r.operacao || ' em ' || r.nome_tabela);
    END LOOP;
  END listar_logs;

END pkg_auditoria;