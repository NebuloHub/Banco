--------------------------------------------------------------------------------
--                                  spec
--------------------------------------------------------------------------------

create or replace PACKAGE pkg_atualizacoes AS
  PROCEDURE atualizar_usuario(
    p_cpf       IN usuario.cpf%TYPE,
    p_nome      IN usuario.nome%TYPE,
    p_email     IN usuario.email%TYPE,
    p_senha     IN usuario.senha%TYPE,
    p_role      IN usuario.role%TYPE,
    p_telefone  IN usuario.telefone%TYPE
  );

  PROCEDURE atualizar_habilidade(
    p_id_habilidade   IN habilidade.id_habilidade%TYPE,
    p_nome_habilidade IN habilidade.nome_habilidade%TYPE,
    p_tipo_habilidade IN habilidade.tipo_habilidade%TYPE
  );

  PROCEDURE atualizar_startup(
    p_cnpj             IN startup.cnpj%TYPE,
    p_video            IN startup.video%TYPE,
    p_nome_startup     IN startup.nome_startup%TYPE,
    p_site             IN startup.site%TYPE,
    p_descricao        IN startup.descricao%TYPE,
    p_nome_responsavel IN startup.nome_responsavel%TYPE,
    p_email_startup    IN startup.email_startup%TYPE,
    p_cpf              IN startup.cpf%TYPE
  );

  PROCEDURE atualizar_avaliacao(
    p_id_avaliacao IN avaliacao.id_avaliacao%TYPE,
    p_nota         IN avaliacao.nota%TYPE,
    p_comentario   IN avaliacao.comentario%TYPE,
    p_cpf          IN avaliacao.cpf%TYPE,
    p_cnpj         IN avaliacao.cnpj%TYPE
  );

  PROCEDURE atualizar_possui(
    p_id_possui     IN possui.id_possui%TYPE,
    p_cnpj          IN possui.cnpj%TYPE,
    p_id_habilidade IN possui.id_habilidade%TYPE
  );
END pkg_atualizacoes;


--------------------------------------------------------------------------------
--                                  Body
--------------------------------------------------------------------------------


create or replace PACKAGE BODY pkg_atualizacoes AS

  PROCEDURE atualizar_usuario(
    p_cpf       IN usuario.cpf%TYPE,
    p_nome      IN usuario.nome%TYPE,
    p_email     IN usuario.email%TYPE,
    p_senha     IN usuario.senha%TYPE,
    p_role      IN usuario.role%TYPE,
    p_telefone  IN usuario.telefone%TYPE
  ) AS
  BEGIN
    UPDATE usuario
      SET nome = p_nome,
          email = p_email,
          senha = p_senha,
          role = p_role,
          telefone = p_telefone
    WHERE cpf = p_cpf;

    IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Nenhum usuário encontrado para CPF ' || p_cpf);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Usuário atualizado: ' || p_cpf || ' / ' || p_nome);
      -- registra auditoria (se pkg_auditoria existir)
      BEGIN
        pkg_auditoria.registrar_log('USUARIO','UPDATE',USER,'Usuário atualizado: '||p_cpf||' / '||p_nome);
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
    END IF;
  EXCEPTION
    WHEN VALUE_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('VALUE_ERROR ao atualizar usuario: ' || SQLERRM);
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro inesperado ao atualizar usuario: ' || SQLERRM);
  END atualizar_usuario;


  PROCEDURE atualizar_habilidade(
    p_id_habilidade   IN habilidade.id_habilidade%TYPE,
    p_nome_habilidade IN habilidade.nome_habilidade%TYPE,
    p_tipo_habilidade IN habilidade.tipo_habilidade%TYPE
  ) AS
  BEGIN
    UPDATE habilidade
      SET nome_habilidade = p_nome_habilidade,
          tipo_habilidade = p_tipo_habilidade
    WHERE id_habilidade = p_id_habilidade;

    IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Nenhuma habilidade com id ' || p_id_habilidade);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Habilidade atualizada: ' || p_id_habilidade);
      BEGIN
        pkg_auditoria.registrar_log('HABILIDADE','UPDATE',USER,'Habilidade atualizada: '||p_id_habilidade||' / '||p_nome_habilidade);
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
    END IF;
  EXCEPTION
    WHEN VALUE_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('VALUE_ERROR ao atualizar habilidade: ' || SQLERRM);
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro inesperado ao atualizar habilidade: ' || SQLERRM);
  END atualizar_habilidade;


  PROCEDURE atualizar_startup(
    p_cnpj             IN startup.cnpj%TYPE,
    p_video            IN startup.video%TYPE,
    p_nome_startup     IN startup.nome_startup%TYPE,
    p_site             IN startup.site%TYPE,
    p_descricao        IN startup.descricao%TYPE,
    p_nome_responsavel IN startup.nome_responsavel%TYPE,
    p_email_startup    IN startup.email_startup%TYPE,
    p_cpf              IN startup.cpf%TYPE
  ) AS
  BEGIN
    UPDATE startup
      SET video = p_video,
          nome_startup = p_nome_startup,
          site = p_site,
          descricao = p_descricao,
          nome_responsavel = p_nome_responsavel,
          email_startup = p_email_startup,
          cpf = p_cpf
    WHERE cnpj = p_cnpj;

    IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Nenhuma startup com CNPJ ' || p_cnpj);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Startup atualizada: ' || p_cnpj);
      BEGIN
        pkg_auditoria.registrar_log('STARTUP','UPDATE',USER,'Startup atualizada: '||p_cnpj||' / '||p_nome_startup);
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
    END IF;
  EXCEPTION
    WHEN VALUE_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('VALUE_ERROR ao atualizar startup: ' || SQLERRM);
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro inesperado ao atualizar startup: ' || SQLERRM);
  END atualizar_startup;


  PROCEDURE atualizar_avaliacao(
    p_id_avaliacao IN avaliacao.id_avaliacao%TYPE,
    p_nota         IN avaliacao.nota%TYPE,
    p_comentario   IN avaliacao.comentario%TYPE,
    p_cpf          IN avaliacao.cpf%TYPE,
    p_cnpj         IN avaliacao.cnpj%TYPE
  ) AS
  BEGIN
    UPDATE avaliacao
      SET nota = p_nota,
          comentario = p_comentario,
          cpf = p_cpf,
          cnpj = p_cnpj
    WHERE id_avaliacao = p_id_avaliacao;

    IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Nenhuma avaliação com ID ' || p_id_avaliacao);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Avaliação atualizada: ' || p_id_avaliacao);
      BEGIN
        pkg_auditoria.registrar_log('AVALIACAO','UPDATE',USER,'Avaliação atualizada: '||p_id_avaliacao);
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
    END IF;
  EXCEPTION
    WHEN VALUE_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('VALUE_ERROR ao atualizar avaliacao: ' || SQLERRM);
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro inesperado ao atualizar avaliacao: ' || SQLERRM);
  END atualizar_avaliacao;


  PROCEDURE atualizar_possui(
    p_id_possui     IN possui.id_possui%TYPE,
    p_cnpj          IN possui.cnpj%TYPE,
    p_id_habilidade IN possui.id_habilidade%TYPE
  ) AS
  BEGIN
    UPDATE possui
      SET cnpj = p_cnpj,
          id_habilidade = p_id_habilidade
    WHERE id_possui = p_id_possui;

    IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Nenhuma relação possui com id ' || p_id_possui);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Relação possui atualizada: ' || p_id_possui);
      BEGIN
        pkg_auditoria.registrar_log('POSSUI','UPDATE',USER,'Relação atualizada: '||p_id_possui);
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
    END IF;
  EXCEPTION
    WHEN VALUE_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('VALUE_ERROR ao atualizar possui: ' || SQLERRM);
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro inesperado ao atualizar possui: ' || SQLERRM);
  END atualizar_possui;

END pkg_atualizacoes;