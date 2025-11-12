--------------------------------------------------------------------------------
--                                  spec
--------------------------------------------------------------------------------

create or replace PACKAGE pkg_insercoes AS
    -- Procedure para inserir na tabela USUARIO
    PROCEDURE inserir_usuario(
        p_cpf       IN VARCHAR2,
        p_nome      IN VARCHAR2,
        p_email     IN VARCHAR2,
        p_senha     IN VARCHAR2,
        p_role      IN VARCHAR2,
        p_telefone  IN NUMBER
    );

    -- Procedure para inserir na tabela HABILIDADE
    PROCEDURE inserir_habilidade(
        p_id_habilidade   IN NUMBER,
        p_nome_habilidade IN VARCHAR2,
        p_tipo_habilidade IN VARCHAR2
    );

    -- Procedure para inserir na tabela STARTUP
    PROCEDURE inserir_startup(
        p_cnpj             IN VARCHAR2,
        p_video            IN VARCHAR2,
        p_nome_startup     IN VARCHAR2,
        p_site             IN VARCHAR2,
        p_descricao        IN CLOB,
        p_nome_responsavel IN VARCHAR2,
        p_email_startup    IN VARCHAR2,
        p_cpf              IN VARCHAR2
    );

    -- Procedure para inserir na tabela AVALIACAO
    PROCEDURE inserir_avaliacao(
        p_id_avaliacao IN NUMBER,
        p_nota         IN NUMBER,
        p_comentario   IN CLOB,
        p_cpf          IN VARCHAR2,
        p_cnpj         IN VARCHAR2
    );

    -- Procedure para inserir na tabela POSSUI
    PROCEDURE inserir_possui(
        p_id_possui      IN NUMBER,
        p_cnpj           IN VARCHAR2,
        p_id_habilidade  IN NUMBER
    );
END pkg_insercoes;


--------------------------------------------------------------------------------
--                                  Body
--------------------------------------------------------------------------------

create or replace PACKAGE BODY pkg_insercoes AS

    PROCEDURE inserir_usuario(
        p_cpf       IN VARCHAR2,
        p_nome      IN VARCHAR2,
        p_email     IN VARCHAR2,
        p_senha     IN VARCHAR2,
        p_role      IN VARCHAR2,
        p_telefone  IN NUMBER
    ) AS
    BEGIN
        INSERT INTO usuario (cpf, nome, email, senha, role, telefone)
        VALUES (p_cpf, p_nome, p_email, p_senha, p_role, p_telefone);

        DBMS_OUTPUT.PUT_LINE('Usuário inserido com sucesso: ' || p_nome);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: CPF já existente - ' || p_cpf);
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Tipo de dado inválido para o usuário ' || p_nome);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro inesperado ao inserir usuário: ' || SQLERRM);
    END inserir_usuario;

    ------------------------------------------------------

    PROCEDURE inserir_habilidade(
        p_id_habilidade   IN NUMBER,
        p_nome_habilidade IN VARCHAR2,
        p_tipo_habilidade IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO habilidade VALUES (p_id_habilidade, p_nome_habilidade, p_tipo_habilidade);
        DBMS_OUTPUT.PUT_LINE('Habilidade inserida com sucesso: ' || p_nome_habilidade);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: ID de habilidade já existente - ' || p_id_habilidade);
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Tipo de dado inválido em habilidade ' || p_nome_habilidade);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro inesperado ao inserir habilidade: ' || SQLERRM);
    END inserir_habilidade;

    ------------------------------------------------------

    PROCEDURE inserir_startup(
        p_cnpj             IN VARCHAR2,
        p_video            IN VARCHAR2,
        p_nome_startup     IN VARCHAR2,
        p_site             IN VARCHAR2,
        p_descricao        IN CLOB,
        p_nome_responsavel IN VARCHAR2,
        p_email_startup    IN VARCHAR2,
        p_cpf              IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO startup (cnpj, video, nome_startup, site, descricao, nome_responsavel, email_startup, cpf)
        VALUES (p_cnpj, p_video, p_nome_startup, p_site, p_descricao, p_nome_responsavel, p_email_startup, p_cpf);

        DBMS_OUTPUT.PUT_LINE('Startup inserida com sucesso: ' || p_nome_startup);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: CNPJ já existente - ' || p_cnpj);
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Tipo de dado inválido para startup ' || p_nome_startup);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro inesperado ao inserir startup: ' || SQLERRM);
    END inserir_startup;

    ------------------------------------------------------

    PROCEDURE inserir_avaliacao(
        p_id_avaliacao IN NUMBER,
        p_nota         IN NUMBER,
        p_comentario   IN CLOB,
        p_cpf          IN VARCHAR2,
        p_cnpj         IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO avaliacao VALUES (p_id_avaliacao, p_nota, p_comentario, p_cpf, p_cnpj);
        DBMS_OUTPUT.PUT_LINE('Avaliação inserida com sucesso: ' || p_id_avaliacao);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: ID de avaliação já existente - ' || p_id_avaliacao);
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Tipo de dado inválido para avaliação ' || p_id_avaliacao);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro inesperado ao inserir avaliação: ' || SQLERRM);
    END inserir_avaliacao;

    ------------------------------------------------------

    PROCEDURE inserir_possui(
        p_id_possui      IN NUMBER,
        p_cnpj           IN VARCHAR2,
        p_id_habilidade  IN NUMBER
    ) AS
    BEGIN
        INSERT INTO possui VALUES (p_id_possui, p_cnpj, p_id_habilidade);
        DBMS_OUTPUT.PUT_LINE('Relação startup-habilidade inserida: ' || p_cnpj || ' → ' || p_id_habilidade);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: ID de relação já existente - ' || p_id_possui);
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Tipo de dado inválido em relação startup-habilidade.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro inesperado ao inserir relação: ' || SQLERRM);
    END inserir_possui;

END pkg_insercoes;

