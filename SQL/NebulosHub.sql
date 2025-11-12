DROP TABLE usuario CASCADE CONSTRAINT;
DROP TABLE habilidade CASCADE CONSTRAINT;
DROP TABLE startup CASCADE CONSTRAINT;
DROP TABLE avaliacao CASCADE CONSTRAINT;
DROP TABLE possui CASCADE CONSTRAINT;

DROP TABLE auditoria CASCADE CONSTRAINT;

CREATE TABLE usuario (
    CPF     VARCHAR2(11) CONSTRAINT CPF_PK PRIMARY KEY,
    Nome    VARCHAR2(150) CONSTRAINT Nome_NN NOT NULL,
    Email   VARCHAR2(150) CONSTRAINT Email_NN NOT NULL,
    Senha   VARCHAR2(150) CONSTRAINT Senha_NN NOT NULL,
    Role    VARCHAR2(10) CONSTRAINT Role_NN NOT NULL,
    Telefone    NUMBER(13)
);

CREATE TABLE habilidade (
    Id_habilidade   NUMBER(6) CONSTRAINT Id_habilidade_PK PRIMARY KEY,
    Nome_habilidade VARCHAR2(250) CONSTRAINT Nome_habilidade_NN NOT NULL,
    Tipo_habilidade VARCHAR2(100) CONSTRAINT Tipo_habilidade_NN NOT NULL
);

CREATE TABLE startup (
    CNPJ    VARCHAR2(14) CONSTRAINT CNPJ_PK PRIMARY KEY,
    Video   VARCHAR2(250),
    Nome_startup VARCHAR2(150) CONSTRAINT Nome_startup_NN NOT NULL,
    Site    VARCHAR2(250),
    Descricao   CLOB CONSTRAINT Descricao_NN NOT NULL,
    Nome_responsavel VARCHAR2(150),
    Email_startup   VARCHAR2(150) CONSTRAINT Email_startup_NN NOT NULL,
    CPF VARCHAR2(11) CONSTRAINT CPF_startup_fk REFERENCES usuario
);

CREATE TABLE avaliacao(
    Id_avaliacao  NUMBER(6) CONSTRAINT Id_PK PRIMARY KEY,
    Nota   NUMBER(2),
    Comentario   CLOB,
    CPF VARCHAR2(11) CONSTRAINT CPF_avaliacao_fk REFERENCES usuario,
    CNPJ VARCHAR2(15) CONSTRAINT CNPJ_avaliacao_fk REFERENCES startup
);

CREATE TABLE possui(
    Id_possui  NUMBER(6) CONSTRAINT Id_possui_PK PRIMARY KEY,
    CNPJ VARCHAR2(15) CONSTRAINT CNPJ_possui_fk REFERENCES startup,
    Id_habilidade   NUMBER(6) CONSTRAINT Id_habilidade_possui_fk REFERENCES habilidade
);


CREATE TABLE auditoria (
  id_auditoria     NUMBER PRIMARY KEY,
  nome_tabela      VARCHAR2(100),
  operacao         VARCHAR2(20),
  usuario_execucao VARCHAR2(100),
  data_execucao    DATE,
  descricao        VARCHAR2(4000)
);



----------------------------------------------------------------------------------------------
--                                      Sequence
----------------------------------------------------------------------------------------------


DROP SEQUENCE habilidade_seq;
DROP SEQUENCE avaliacao_seq;
DROP SEQUENCE possui_seq;
DROP SEQUENCE auditoria_seq;


CREATE SEQUENCE habilidade_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE avaliacao_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE possui_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE auditoria_seq START WITH 1 INCREMENT BY 1;


ALTER TABLE habilidade MODIFY Id_habilidade DEFAULT habilidade_seq.NEXTVAL;
ALTER TABLE avaliacao MODIFY Id_avaliacao DEFAULT avaliacao_seq.NEXTVAL;
ALTER TABLE possui MODIFY Id_possui DEFAULT possui_seq.NEXTVAL;
ALTER TABLE auditoria MODIFY id_auditoria DEFAULT auditoria_seq.NEXTVAL;


----------------------------------------------------------------------------------------------
--                                      INSERTS
----------------------------------------------------------------------------------------------

SET SERVEROUTPUT ON;

-- Usuario
BEGIN
    pkg_insercoes.inserir_usuario('12345678901', 'Mariana Oliveira', 'mariana.oliveira@innovahub.com', 'SenhaSegura01', 'USER', 11992837461);
    pkg_insercoes.inserir_usuario('23456789012', 'Rafael Costa', 'rafael.costa@greenwave.com', 'RafaC@2025', 'ADMIN', 21984736251);
    pkg_insercoes.inserir_usuario('34567890123', 'Camila Fernandes', 'camila.fernandes@brighttech.com', 'Camila#123', 'USER', 31997531824);
    pkg_insercoes.inserir_usuario('45678901234', 'Lucas Almeida', 'lucas.almeida@eduplus.com', 'SenhaForte456', 'USER', 11984376512);
    pkg_insercoes.inserir_usuario('56789012345', 'Beatriz Nogueira', 'beatriz.nogueira@fitmind.com', 'Bea@2024', 'USER', 41993762518);
    pkg_insercoes.inserir_usuario('67890123456', 'Pedro Ramos', 'pedro.ramos@voltenergy.com', 'PedroPower88', 'ADMIN', 21991547823);
    pkg_insercoes.inserir_usuario('78901234567', 'Larissa Souza', 'larissa.souza@urbanfarm.com', 'Lari$567', 'USER', 11997124587);
    pkg_insercoes.inserir_usuario('89012345678', 'Thiago Martins', 'thiago.martins@petbond.com', 'ThiagoM!2025', 'USER', 11984571236);
    pkg_insercoes.inserir_usuario('90123456789', 'Juliana Lima', 'juliana.lima@neurodata.com', 'Juli@Brain99', 'USER', 31999874513);
    pkg_insercoes.inserir_usuario('01234567890', 'Diego Rocha', 'diego.rocha@aqualink.com', 'Diego!2024', 'USER', 11998754312);
    pkg_insercoes.inserir_usuario('46881761804', 'Luiz Henrique Neri', 'luizhneri20@gmail.com', 'Carrinhos@1234', 'ADMIN', 11973076694);
END;
/



-- habilidade
BEGIN
    pkg_insercoes.inserir_habilidade(1, 'Desenvolvimento Full Stack', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(2, 'Gestão Financeira', 'Administração');
    pkg_insercoes.inserir_habilidade(3, 'Design de Experiência (UX/UI)', 'Design');
    pkg_insercoes.inserir_habilidade(4, 'Análise de Dados', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(5, 'Marketing Digital', 'Comercial');
    pkg_insercoes.inserir_habilidade(6, 'Prototipagem e Inovação', 'Design');
    pkg_insercoes.inserir_habilidade(7, 'Vendas Estratégicas', 'Comercial');
    pkg_insercoes.inserir_habilidade(8, 'Gestão de Pessoas', 'Administração');
    pkg_insercoes.inserir_habilidade(9, 'Sustentabilidade Corporativa', 'Ambiental');
    pkg_insercoes.inserir_habilidade(10, 'Machine Learning', 'Tecnologia');
END;
/



-- startup
BEGIN
    pkg_insercoes.inserir_startup('11222333000191', 'https://youtu.be/Q3wa-tWIlUc?si=jWnGQ8kSpTP2aUsC', 'TechTide', 'https://www.techtide.com', 'Plataforma que conecta desenvolvedores a startups emergentes.', 'Mariana Oliveira', 'contato@techtide.com', '12345678901');
    pkg_insercoes.inserir_startup('22333444000182', 'https://youtu.be/6EEJBaH_f7Y?si=HIU66sWevhJTyzUZ', 'GreenWave', 'https://www.greenwave.com', 'Startup de soluções ecológicas para empresas.', 'Rafael Costa', 'hello@greenwave.com', '23456789012');
    pkg_insercoes.inserir_startup('33444555000173', 'https://youtu.be/8FV0e0M9YVs?si=Oiupq9NLUytd_iUj', 'BrightTech', 'https://www.brighttech.io', 'Empresa especializada em softwares de gestão educacional.', 'Camila Fernandes', 'contato@brighttech.io', '34567890123');
    pkg_insercoes.inserir_startup('44555666000164', 'https://youtu.be/7nKMUkcSC2s?si=oRaIe6iuitUVJ3D8', 'EduPlus', 'https://www.eduplus.com.br', 'Plataforma de ensino online personalizada.', 'Lucas Almeida', 'info@eduplus.com.br', '45678901234');
    pkg_insercoes.inserir_startup('55666777000155', 'https://youtu.be/8PsimpprLS0?si=rgCknCKmJYerkBY_', 'FitMind', 'https://www.fitmind.app', 'Aplicativo de meditação e bem-estar mental.', 'Beatriz Nogueira', 'contato@fitmind.app', '56789012345');
    pkg_insercoes.inserir_startup('66777888000146', 'https://youtu.be/2RAw3QdwbH4?si=em5HUr-mVHjb2-nP', 'VoltEnergy', 'https://www.voltenergy.com', 'Soluções de energia renovável para indústrias.', 'Pedro Ramos', 'suporte@voltenergy.com', '67890123456');
    pkg_insercoes.inserir_startup('77888999000137', 'https://youtu.be/98I-3SiHPtg?si=izuc-PiCl2Pn1dUb', 'UrbanFarm', 'https://www.urbanfarm.io', 'Agricultura urbana inteligente com sensores IoT.', 'Larissa Souza', 'contato@urbanfarm.io', '78901234567');
    pkg_insercoes.inserir_startup('88999000000128', 'https://youtu.be/UNDnHZaAI3w?si=fFY3iX1CnXSEv2la', 'PetBond', 'https://www.petbond.com', 'Marketplace para produtos e serviços pet.', 'Thiago Martins', 'atendimento@petbond.com', '89012345678');
    pkg_insercoes.inserir_startup('99000111000119', 'https://youtu.be/luHTpyfPHmU?si=tPfuFyb3Cr7I9-Hn', 'NeuroData', 'https://www.neurodata.ai', 'Análise preditiva de comportamento de consumo.', 'Juliana Lima', 'contato@neurodata.ai', '90123456789');
    pkg_insercoes.inserir_startup('10111222000100', 'https://youtu.be/WIS3PzNJEdU?si=0LpWfG8h6GOA6vQw', 'AquaLink', 'https://www.aqualink.tech', 'Gestão inteligente de recursos hídricos.', 'Diego Rocha', 'contato@aqualink.tech', '01234567890');
END;
/


-- avaliacao
BEGIN
    pkg_insercoes.inserir_avaliacao(1, 9, 'Excelente plataforma, suporte muito rápido!', '12345678901', '22333444000182');
    pkg_insercoes.inserir_avaliacao(2, 8, 'Boa usabilidade, mas o design pode melhorar.', '23456789012', '33444555000173');
    pkg_insercoes.inserir_avaliacao(3, 10, 'Ferramenta revolucionária no setor!', '34567890123', '66777888000146');
    pkg_insercoes.inserir_avaliacao(4, 7, 'Poderia ter mais integrações com APIs externas.', '45678901234', '44555666000164');
    pkg_insercoes.inserir_avaliacao(5, 9, 'Adorei o conceito da startup, muito promissor.', '56789012345', '55666777000155');
    pkg_insercoes.inserir_avaliacao(6, 6, 'Sistema um pouco instável em horários de pico.', '67890123456', '77888999000137');
    pkg_insercoes.inserir_avaliacao(7, 10, 'Excelente atendimento e produto inovador!', '78901234567', '99000111000119');
    pkg_insercoes.inserir_avaliacao(8, 8, 'Ótimo custo-benefício e suporte técnico.', '89012345678', '88999000000128');
    pkg_insercoes.inserir_avaliacao(9, 7, 'Funciona bem, mas precisa de mais documentação.', '90123456789', '10111222000100');
    pkg_insercoes.inserir_avaliacao(10, 9, 'Uma das melhores experiências que já tive.', '01234567890', '11222333000191');
END;
/



-- possui
BEGIN
    pkg_insercoes.inserir_possui(1, '11222333000191', 1);
    pkg_insercoes.inserir_possui(2, '22333444000182', 9);
    pkg_insercoes.inserir_possui(3, '33444555000173', 4);
    pkg_insercoes.inserir_possui(4, '44555666000164', 3);
    pkg_insercoes.inserir_possui(5, '55666777000155', 6);
    pkg_insercoes.inserir_possui(6, '66777888000146', 10);
    pkg_insercoes.inserir_possui(7, '77888999000137', 8);
    pkg_insercoes.inserir_possui(8, '88999000000128', 5);
    pkg_insercoes.inserir_possui(9, '99000111000119', 7);
    pkg_insercoes.inserir_possui(10, '10111222000100', 2);
END;
/

COMMIT;





----------------------------------------------------------------------------------------------
--                                      Auditoria
----------------------------------------------------------------------------------------------

--- usuario

CREATE OR REPLACE TRIGGER trg_usuario_auditoria
AFTER INSERT OR UPDATE OR DELETE ON usuario
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    pkg_auditoria.registrar_log('USUARIO', 'INSERT', USER, 'Novo usuário inserido: ' || :NEW.nome);
  ELSIF UPDATING THEN
    pkg_auditoria.registrar_log('USUARIO', 'UPDATE', USER, 'Usuário atualizado: ' || :NEW.nome);
  ELSIF DELETING THEN
    pkg_auditoria.registrar_log('USUARIO', 'DELETE', USER, 'Usuário removido: ' || :OLD.nome);
  END IF;
END;
/


--- habilidade

CREATE OR REPLACE TRIGGER trg_habilidade_auditoria
AFTER INSERT OR UPDATE OR DELETE ON habilidade
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    pkg_auditoria.registrar_log('HABILIDADE', 'INSERT', USER, 'Nova habilidade inserida: ' || :NEW.nome_habilidade);
  ELSIF UPDATING THEN
    pkg_auditoria.registrar_log('HABILIDADE', 'UPDATE', USER, 'Habilidade atualizada: ' || :NEW.nome_habilidade);
  ELSIF DELETING THEN
    pkg_auditoria.registrar_log('HABILIDADE', 'DELETE', USER, 'Habilidade removida: ' || :OLD.nome_habilidade);
  END IF;
END;
/


---- Teste Auditoria
BEGIN
    pkg_insercoes.inserir_habilidade(11, 'Desenvolvimento Frontend', 'Tecnologia');
    pkg_atualizacoes.atualizar_habilidade(
        p_id_habilidade   => 11,
        p_nome_habilidade => 'Desenvolvimento Frontend Avançado',
        p_tipo_habilidade => 'Tecnologia'
    );

    pkg_exclusoes.deletar_habilidade(11);
END;
/

SELECT * FROM auditoria ORDER BY data_execucao DESC;




----------------------------------------------------------------------------------------------
--                                      Funcao 1
----------------------------------------------------------------------------------------------

-- Teste função 1

SET LONG 1000000
DECLARE
  v_json CLOB;
BEGIN
  v_json := pkg_funcao1_json_util.gerar_json_perfil('12345678901'); -- coloque um CPF válido do seu DB
  DBMS_OUTPUT.PUT_LINE(SUBSTR(v_json,1,32000)); -- mostra começo do CLOB
END;
/





----------------------------------------------------------------------------------------------
--                                      Funcao 2
----------------------------------------------------------------------------------------------

-- Teste função 2

DECLARE
  v_resultado CLOB;
BEGIN
  v_resultado := pkg_funcao2_validacao.analisar_startup('22333444000182'); -- GreenWave
  DBMS_OUTPUT.PUT_LINE(v_resultado);
END;
/





----------------------------------------------------------------------------------------------
--                                Exportacao do JSON
----------------------------------------------------------------------------------------------


SET SERVEROUTPUT ON SIZE UNLIMITED;
SET LONG 1000000;
SET LINESIZE 32767;
SET FEEDBACK OFF;
SET TERMOUT OFF;
SPOOL startups_exportadas.json;

DECLARE
  v_json CLOB;
BEGIN
  PKG_EXPORTACOES_STARTUP.PRC_EXPORTAR_TODAS_STARTUPS_JSON(v_json);
  DBMS_OUTPUT.PUT_LINE(v_json);
END;
/

SPOOL OFF;

SET FEEDBACK ON;
SET TERMOUT ON;

