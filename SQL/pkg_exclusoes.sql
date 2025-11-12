--------------------------------------------------------------------------------
--                                  spec
--------------------------------------------------------------------------------

create or replace PACKAGE pkg_exclusoes AS
  PROCEDURE deletar_usuario(p_cpf IN VARCHAR2);
  PROCEDURE deletar_habilidade(p_id_habilidade IN NUMBER);
  PROCEDURE deletar_startup(p_cnpj IN VARCHAR2);
  PROCEDURE deletar_avaliacao(p_id_avaliacao IN NUMBER);
  PROCEDURE deletar_possui(p_id_possui IN NUMBER);
END pkg_exclusoes;

--------------------------------------------------------------------------------
--                                  Body
--------------------------------------------------------------------------------

create or replace PACKAGE BODY pkg_exclusoes AS

  ------------------------------------------------------
  -- Deletar Usuário
  ------------------------------------------------------
  PROCEDURE deletar_usuario(p_cpf IN VARCHAR2) AS
  v_nome usuario.nome%TYPE;
  BEGIN
      SELECT nome INTO v_nome FROM usuario WHERE cpf = p_cpf;

      DELETE FROM usuario WHERE cpf = p_cpf;

      IF SQL%ROWCOUNT > 0 THEN
          pkg_auditoria.registrar_log('USUARIO', 'DELETE', USER, 'Usuário excluído: ' || v_nome);
          DBMS_OUTPUT.PUT_LINE('Usuário deletado com sucesso: ' || v_nome);
      ELSE
          DBMS_OUTPUT.PUT_LINE('Nenhum usuário encontrado com CPF ' || p_cpf);
      END IF;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
          DBMS_OUTPUT.PUT_LINE('Erro: Usuário não encontrado para exclusão.');
      WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Erro inesperado ao excluir usuário: ' || SQLERRM);
  END deletar_usuario;


  ------------------------------------------------------
  -- Deletar Habilidade
  ------------------------------------------------------
  PROCEDURE deletar_habilidade(p_id_habilidade IN NUMBER) AS
  v_nome habilidade.nome_habilidade%TYPE;
  BEGIN
      SELECT nome_habilidade INTO v_nome FROM habilidade WHERE id_habilidade = p_id_habilidade;

      DELETE FROM habilidade WHERE id_habilidade = p_id_habilidade;

      IF SQL%ROWCOUNT > 0 THEN
          pkg_auditoria.registrar_log('HABILIDADE', 'DELETE', USER, 'Habilidade excluída: ' || v_nome);
          DBMS_OUTPUT.PUT_LINE('Habilidade deletada com sucesso: ' || v_nome);
      ELSE
          DBMS_OUTPUT.PUT_LINE('Nenhuma habilidade encontrada com ID ' || p_id_habilidade);
      END IF;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
          DBMS_OUTPUT.PUT_LINE('Erro: Habilidade não encontrada para exclusão.');
      WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Erro inesperado ao excluir habilidade: ' || SQLERRM);
  END deletar_habilidade;


  ------------------------------------------------------
  -- Deletar Startup
  ------------------------------------------------------
  PROCEDURE deletar_startup(p_cnpj IN VARCHAR2) AS
  v_nome startup.nome_startup%TYPE;
  BEGIN
      SELECT nome_startup INTO v_nome FROM startup WHERE cnpj = p_cnpj;

      DELETE FROM startup WHERE cnpj = p_cnpj;

      IF SQL%ROWCOUNT > 0 THEN
          pkg_auditoria.registrar_log('STARTUP', 'DELETE', USER, 'Startup excluída: ' || v_nome);
          DBMS_OUTPUT.PUT_LINE('Startup deletada com sucesso: ' || v_nome);
      ELSE
          DBMS_OUTPUT.PUT_LINE('Nenhuma startup encontrada com CNPJ ' || p_cnpj);
      END IF;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
          DBMS_OUTPUT.PUT_LINE('Erro: Startup não encontrada para exclusão.');
      WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Erro inesperado ao excluir startup: ' || SQLERRM);
  END deletar_startup;


  ------------------------------------------------------
  -- Deletar Avaliação
  ------------------------------------------------------
  PROCEDURE deletar_avaliacao(p_id_avaliacao IN NUMBER) AS
  BEGIN
      DELETE FROM avaliacao WHERE id_avaliacao = p_id_avaliacao;

      IF SQL%ROWCOUNT > 0 THEN
          pkg_auditoria.registrar_log('AVALIACAO', 'DELETE', USER, 'Avaliação excluída, ID: ' || p_id_avaliacao);
          DBMS_OUTPUT.PUT_LINE('Avaliação deletada com sucesso: ID ' || p_id_avaliacao);
      ELSE
          DBMS_OUTPUT.PUT_LINE('Nenhuma avaliação encontrada com ID ' || p_id_avaliacao);
      END IF;
  EXCEPTION
      WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Erro ao excluir avaliação: ' || SQLERRM);
  END deletar_avaliacao;


  ------------------------------------------------------
  -- Deletar Relação POSSUI
  ------------------------------------------------------
  PROCEDURE deletar_possui(p_id_possui IN NUMBER) AS
  BEGIN
      DELETE FROM possui WHERE id_possui = p_id_possui;

      IF SQL%ROWCOUNT > 0 THEN
          pkg_auditoria.registrar_log('POSSUI', 'DELETE', USER, 'Relação startup-habilidade excluída, ID: ' || p_id_possui);
          DBMS_OUTPUT.PUT_LINE('Relação deletada com sucesso: ID ' || p_id_possui);
      ELSE
          DBMS_OUTPUT.PUT_LINE('Nenhuma relação encontrada com ID ' || p_id_possui);
      END IF;
  EXCEPTION
      WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Erro ao excluir relação: ' || SQLERRM);
  END deletar_possui;

END pkg_exclusoes;