DROP TABLE usuario CASCADE CONSTRAINT;
DROP TABLE habilidade CASCADE CONSTRAINT;
DROP TABLE startup CASCADE CONSTRAINT;
DROP TABLE avaliacao CASCADE CONSTRAINT;
DROP TABLE possui CASCADE CONSTRAINT;

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
    CNPJ    VARCHAR2(15) CONSTRAINT CNPJ_PK PRIMARY KEY,
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

----------------------------------------------------------------------------------------------
--                                      INSERTS
----------------------------------------------------------------------------------------------


-- TABELA: USUARIO

INSERT INTO usuario VALUES ('12345678901', 'Mariana Oliveira', 'mariana.oliveira@innovahub.com', 'SenhaSegura01', 'USER', 11992837461);
INSERT INTO usuario VALUES ('23456789012', 'Rafael Costa', 'rafael.costa@greenwave.com', 'RafaC@2025', 'ADMIN', 21984736251);
INSERT INTO usuario VALUES ('34567890123', 'Camila Fernandes', 'camila.fernandes@brighttech.com', 'Camila#123', 'USER', 31997531824);
INSERT INTO usuario VALUES ('45678901234', 'Lucas Almeida', 'lucas.almeida@eduplus.com', 'SenhaForte456', 'USER', 11984376512);
INSERT INTO usuario VALUES ('56789012345', 'Beatriz Nogueira', 'beatriz.nogueira@fitmind.com', 'Bea@2024', 'USER', 41993762518);
INSERT INTO usuario VALUES ('67890123456', 'Pedro Ramos', 'pedro.ramos@voltenergy.com', 'PedroPower88', 'ADMIN', 21991547823);
INSERT INTO usuario VALUES ('78901234567', 'Larissa Souza', 'larissa.souza@urbanfarm.com', 'Lari$567', 'USER', 11997124587);
INSERT INTO usuario VALUES ('89012345678', 'Thiago Martins', 'thiago.martins@petbond.com', 'ThiagoM!2025', 'USER', 11984571236);
INSERT INTO usuario VALUES ('90123456789', 'Juliana Lima', 'juliana.lima@neurodata.com', 'Juli@Brain99', 'USER', 31999874513);
INSERT INTO usuario VALUES ('01234567890', 'Diego Rocha', 'diego.rocha@aqualink.com', 'Diego!2024', 'USER', 11998754312);


-- TABELA: HABILIDADE

INSERT INTO habilidade VALUES (1, 'Desenvolvimento Full Stack', 'Tecnologia');
INSERT INTO habilidade VALUES (2, 'Gestão Financeira', 'Administração');
INSERT INTO habilidade VALUES (3, 'Design de Experiência (UX/UI)', 'Design');
INSERT INTO habilidade VALUES (4, 'Análise de Dados', 'Tecnologia');
INSERT INTO habilidade VALUES (5, 'Marketing Digital', 'Comercial');
INSERT INTO habilidade VALUES (6, 'Prototipagem e Inovação', 'Design');
INSERT INTO habilidade VALUES (7, 'Vendas Estratégicas', 'Comercial');
INSERT INTO habilidade VALUES (8, 'Gestão de Pessoas', 'Administração');
INSERT INTO habilidade VALUES (9, 'Sustentabilidade Corporativa', 'Ambiental');
INSERT INTO habilidade VALUES (10, 'Machine Learning', 'Tecnologia');


-- TABELA: STARTUP

INSERT INTO startup VALUES ('11222333000191', 'https://youtu.be/Q3wa-tWIlUc?si=jWnGQ8kSpTP2aUsC', 'TechTide', 'https://www.techtide.com', 'Plataforma que conecta desenvolvedores a startups emergentes.', 'Mariana Oliveira', 'contato@techtide.com', '12345678901');
INSERT INTO startup VALUES ('22333444000182', 'https://youtu.be/greenwave', 'GreenWave', 'https://www.greenwave.com', 'Startup de soluções ecológicas para empresas.', 'Rafael Costa', 'hello@greenwave.com', '23456789012');
INSERT INTO startup VALUES ('33444555000173', 'https://youtu.be/brighttech', 'BrightTech', 'https://www.brighttech.io', 'Empresa especializada em softwares de gestão educacional.', 'Camila Fernandes', 'contato@brighttech.io', '34567890123');
INSERT INTO startup VALUES ('44555666000164', 'https://youtu.be/eduplus', 'EduPlus', 'https://www.eduplus.com.br', 'Plataforma de ensino online personalizada.', 'Lucas Almeida', 'info@eduplus.com.br', '45678901234');
INSERT INTO startup VALUES ('55666777000155', 'https://youtu.be/fitmind', 'FitMind', 'https://www.fitmind.app', 'Aplicativo de meditação e bem-estar mental.', 'Beatriz Nogueira', 'contato@fitmind.app', '56789012345');
INSERT INTO startup VALUES ('66777888000146', 'https://youtu.be/voltenergy', 'VoltEnergy', 'https://www.voltenergy.com', 'Soluções de energia renovável para indústrias.', 'Pedro Ramos', 'suporte@voltenergy.com', '67890123456');
INSERT INTO startup VALUES ('77888999000137', 'https://youtu.be/urbanfarm', 'UrbanFarm', 'https://www.urbanfarm.io', 'Agricultura urbana inteligente com sensores IoT.', 'Larissa Souza', 'contato@urbanfarm.io', '78901234567');
INSERT INTO startup VALUES ('88999000000128', 'https://youtu.be/petbond', 'PetBond', 'https://www.petbond.com', 'Marketplace para produtos e serviços pet.', 'Thiago Martins', 'atendimento@petbond.com', '89012345678');
INSERT INTO startup VALUES ('99000111000119', 'https://youtu.be/neurodata', 'NeuroData', 'https://www.neurodata.ai', 'Análise preditiva de comportamento de consumo.', 'Juliana Lima', 'contato@neurodata.ai', '90123456789');
INSERT INTO startup VALUES ('10111222000100', 'https://youtu.be/aqualink', 'AquaLink', 'https://www.aqualink.tech', 'Gestão inteligente de recursos hídricos.', 'Diego Rocha', 'contato@aqualink.tech', '01234567890');


-- TABELA: AVALIACAO

INSERT INTO avaliacao VALUES (1, 9, 'Excelente plataforma, suporte muito rápido!', '12345678901', '22333444000182');
INSERT INTO avaliacao VALUES (2, 8, 'Boa usabilidade, mas o design pode melhorar.', '23456789012', '33444555000173');
INSERT INTO avaliacao VALUES (3, 10, 'Ferramenta revolucionária no setor!', '34567890123', '66777888000146');
INSERT INTO avaliacao VALUES (4, 7, 'Poderia ter mais integrações com APIs externas.', '45678901234', '44555666000164');
INSERT INTO avaliacao VALUES (5, 9, 'Adorei o conceito da startup, muito promissor.', '56789012345', '55666777000155');
INSERT INTO avaliacao VALUES (6, 6, 'Sistema um pouco instável em horários de pico.', '67890123456', '77888999000137');
INSERT INTO avaliacao VALUES (7, 10, 'Excelente atendimento e produto inovador!', '78901234567', '99000111000119');
INSERT INTO avaliacao VALUES (8, 8, 'Ótimo custo-benefício e suporte técnico.', '89012345678', '88999000000128');
INSERT INTO avaliacao VALUES (9, 7, 'Funciona bem, mas precisa de mais documentação.', '90123456789', '10111222000100');
INSERT INTO avaliacao VALUES (10, 9, 'Uma das melhores experiências que já tive.', '01234567890', '11222333000191');


-- TABELA: POSSUI

INSERT INTO possui VALUES (1, '11222333000191', 1);
INSERT INTO possui VALUES (2, '22333444000182', 9);
INSERT INTO possui VALUES (3, '33444555000173', 4); 
INSERT INTO possui VALUES (4, '44555666000164', 3);
INSERT INTO possui VALUES (5, '55666777000155', 6);
INSERT INTO possui VALUES (6, '66777888000146', 10);
INSERT INTO possui VALUES (7, '77888999000137', 8);
INSERT INTO possui VALUES (8, '88999000000128', 5);
INSERT INTO possui VALUES (9, '99000111000119', 7);
INSERT INTO possui VALUES (10, '10111222000100', 2);
