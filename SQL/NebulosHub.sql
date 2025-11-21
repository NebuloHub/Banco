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
    CNPJ VARCHAR2(14) CONSTRAINT CNPJ_avaliacao_fk REFERENCES startup
);

CREATE TABLE possui(
    Id_possui  NUMBER(6) CONSTRAINT Id_possui_PK PRIMARY KEY,
    CNPJ VARCHAR2(14) CONSTRAINT CNPJ_possui_fk REFERENCES startup,
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
    
    pkg_insercoes.inserir_usuario('11122233344', 'Fernando Ribeiro', 'fernando.ribeiro@smartflow.com', 'Flow@2025', 'USER', 11987654321);
    pkg_insercoes.inserir_usuario('22233344455', 'Patrícia Mendes', 'patricia.mendes@ecocharge.com', 'Paty#Eco55', 'ADMIN', 21988442211);
    pkg_insercoes.inserir_usuario('33344455566', 'Gustavo Araújo', 'gustavo.araujo@devspark.io', 'GusDev!2024', 'USER', 31999887766);
    pkg_insercoes.inserir_usuario('44455566677', 'Renata Farias', 'renata.farias@mindstudy.com', 'R3nata*2024', 'USER', 11991234567);
    pkg_insercoes.inserir_usuario('55566677788', 'Daniel Moreira', 'daniel.moreira@citymob.com', 'DanMob@55', 'USER', 21995566778);
    pkg_insercoes.inserir_usuario('66677788899', 'Ana Paula Dias', 'ana.dias@biofuture.com', 'AnaBio#2024', 'ADMIN', 41997665544);
    pkg_insercoes.inserir_usuario('77788899900', 'Ricardo Lima', 'ricardo.lima@codevision.dev', 'RicVision!77', 'USER', 11993456712);
    pkg_insercoes.inserir_usuario('88899900011', 'Helena Duarte', 'helena.duarte@farmwise.io', 'HelenaF@44', 'USER', 31994561234);
    pkg_insercoes.inserir_usuario('99900011122', 'Marcelo Tavares', 'marcelo.tavares@cyberlane.ai', 'MarcAI2025', 'USER', 21990011223);
    pkg_insercoes.inserir_usuario('10101010101', 'Simone Prado', 'simone.prado@eventify.app', 'SimPr@2025', 'USER', 11999887755);

    pkg_insercoes.inserir_usuario('12121212121', 'João Silveira', 'joao.silveira@moveon.com', 'JoaoMove@12', 'USER', 21988776655);
    pkg_insercoes.inserir_usuario('13131313131', 'Letícia Moura', 'leticia.moura@healthtrack.io', 'Leti#Track33', 'USER', 31992334455);
    pkg_insercoes.inserir_usuario('14141414141', 'Diego Fagundes', 'diego.fagundes@smartbudget.com', 'D!ego2024', 'ADMIN', 11988776644);
    pkg_insercoes.inserir_usuario('15151515151', 'Carolina Silva', 'carolina.silva@agromap.io', 'CarolA#2025', 'USER', 21998877661);
    pkg_insercoes.inserir_usuario('16161616161', 'Vinicius Lopes', 'vinicius.lopes@connectx.app', 'Vinix@88', 'USER', 41995544332);
    pkg_insercoes.inserir_usuario('17171717171', 'Amanda Rocha', 'amanda.rocha@nanosoft.ai', 'Amand@Nano2025', 'USER', 31994432211);
    pkg_insercoes.inserir_usuario('18181818181', 'Thiago Barreto', 'thiago.barreto@freshhome.io', 'Th1ago#2025', 'USER', 11996655443);
    pkg_insercoes.inserir_usuario('19191919191', 'Sara Monteiro', 'sara.monteiro@airbot.ai', 'Sar@Air91', 'USER', 21997766554);
    pkg_insercoes.inserir_usuario('20202020202', 'Eduardo Martins', 'eduardo.martins@finflow.io', 'EduFin@44', 'USER', 11993112233);
    pkg_insercoes.inserir_usuario('30303030303', 'Julio Carvalho', 'julio.carvalho@terrascan.com', 'JCarv@2025', 'USER', 31988771234);
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
    
    pkg_insercoes.inserir_habilidade(11, 'Arquitetura de Software', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(12, 'Gestão de Projetos Ágeis', 'Administração');
    pkg_insercoes.inserir_habilidade(13, 'Branding Estratégico', 'Marketing');
    pkg_insercoes.inserir_habilidade(14, 'Segurança da Informação', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(15, 'Economia Circular', 'Ambiental');
    pkg_insercoes.inserir_habilidade(16, 'E-commerce Performance', 'Comercial');
    pkg_insercoes.inserir_habilidade(17, 'Desenvolvimento Mobile', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(18, 'Pesquisa de Mercado', 'Administração');
    pkg_insercoes.inserir_habilidade(19, 'Motion Design', 'Design');
    pkg_insercoes.inserir_habilidade(20, 'Deep Learning', 'Tecnologia');

    pkg_insercoes.inserir_habilidade(21, 'Automação de Processos', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(22, 'Gestão de Riscos', 'Administração');
    pkg_insercoes.inserir_habilidade(23, 'Copywriting', 'Marketing');
    pkg_insercoes.inserir_habilidade(24, 'Modelagem de Negócios', 'Administração');
    pkg_insercoes.inserir_habilidade(25, 'Design Thinking', 'Design');
    pkg_insercoes.inserir_habilidade(26, 'Sistemas IoT', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(27, 'Sustentabilidade Energética', 'Ambiental');
    pkg_insercoes.inserir_habilidade(28, 'Data Engineering', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(29, 'Social Media Strategy', 'Marketing');
    pkg_insercoes.inserir_habilidade(30, 'Criação de Prototipagem 3D', 'Design');
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
    
    pkg_insercoes.inserir_startup('20223344000111', 'https://youtu.be/WlXQgnRJZt8?si=PqFA5sBhdelnWXLY', 'SmartFlow', 'https://www.smartflow.com', 'Automação inteligente para empresas.', 'Fernando Ribeiro', 'contato@smartflow.com', '11122233344');
    pkg_insercoes.inserir_startup('21334455000122', 'https://youtu.be/NYdrAIPLhIw?si=Jj-kdV61DcHbP5Fo', 'EcoCharge', 'https://www.ecocharge.io', 'Estações de recarga ecológica.', 'Patrícia Mendes', 'hello@ecocharge.io', '22233344455');
    pkg_insercoes.inserir_startup('22445566000133', 'https://youtu.be/AD0FbOR4Zj8?si=0ju9Mhi6vRP7WPPE', 'DevSpark', 'https://www.devspark.dev', 'Comunidade e recursos para desenvolvedores.', 'Gustavo Araújo', 'contato@devspark.dev', '33344455566');
    pkg_insercoes.inserir_startup('23556677000144', 'https://youtu.be/Bi0nVMm4dGc?si=zG-2Zszpvn6A9xk5', 'MindStudy', 'https://www.mindstudy.com', 'Plataforma de estudos cognitivos.', 'Renata Farias', 'info@mindstudy.com', '44455566677');
    pkg_insercoes.inserir_startup('24667788000155', 'https://youtu.be/1QZR5De4f9E?si=0VW8c0oPTTr3MNFA', 'CityMob', 'https://www.citymob.app', 'Mobilidade urbana inteligente.', 'Daniel Moreira', 'mob@citymob.app', '55566677788');
    pkg_insercoes.inserir_startup('25778899000166', 'https://youtu.be/7RDpXB6Hkf8?si=1LtoJRc2pzZDShL1', 'BioFuture', 'https://www.biofuture.bio', 'Biotecnologia aplicada ao bem-estar.', 'Ana Paula Dias', 'contato@biofuture.bio', '66677788899');
    pkg_insercoes.inserir_startup('26889900000177', 'https://youtu.be/7RDpXB6Hkf8?si=1LtoJRc2pzZDShL1', 'CodeVision', 'https://www.codevision.ai', 'Ferramentas inteligentes para desenvolvedores.', 'Ricardo Lima', 'dev@codevision.ai', '77788899900');
    pkg_insercoes.inserir_startup('27990011000188', 'https://youtu.be/Bi0nVMm4dGc?si=zG-2Zszpvn6A9xk5', 'FarmWise', 'https://www.farmwise.io', 'Gestão agrícola inteligente.', 'Helena Duarte', 'hello@farmwise.io', '88899900011');
    pkg_insercoes.inserir_startup('28001122000199', 'https://youtu.be/8PsimpprLS0?si=rgCknCKmJYerkBY_', 'CyberLane', 'https://www.cyberlane.ai', 'Segurança digital para pequenas empresas.', 'Marcelo Tavares', 'security@cyberlane.ai', '99900011122');
    pkg_insercoes.inserir_startup('29012233000100', 'https://youtu.be/Q3wa-tWIlUc?si=jWnGQ8kSpTP2aUsC', 'Eventify', 'https://www.eventify.app', 'Gestão de eventos com IA.', 'Simone Prado', 'contato@eventify.app', '10101010101');

    pkg_insercoes.inserir_startup('30123344000111', 'https://youtu.be/K3ucIhcVmpk?si=B97TQ5DhXtRweBuv', 'MoveOn', 'https://www.moveon.com', 'Logística urbana automatizada.', 'João Silveira', 'hello@moveon.com', '12121212121');
    pkg_insercoes.inserir_startup('31234455000122', 'https://youtu.be/pg6Kjxn_rA0?si=ioHBRZFWRFyxexoF', 'HealthTrack', 'https://www.healthtrack.io', 'Monitoramento de saúde por IA.', 'Letícia Moura', 'saude@healthtrack.io', '13131313131');
    pkg_insercoes.inserir_startup('32345566000133', 'https://youtu.be/l360n_E3-k0?si=OMGrjjqQwPFeSXMB', 'SmartBudget', 'https://www.smartbudget.com', 'Plataforma de controle financeiro.', 'Diego Fagundes', 'finance@smartbudget.com', '14141414141');
    pkg_insercoes.inserir_startup('33456677000144', 'https://youtu.be/hVTE0K8db6k?si=rvy8aPalpfkkqo1O', 'AgroMap', 'https://www.agromap.io', 'Mapeamento rural com drones.', 'Carolina Silva', 'agro@agromap.io', '15151515151');
    pkg_insercoes.inserir_startup('34567788000155', 'https://youtu.be/7RDpXB6Hkf8?si=1LtoJRc2pzZDShL1', 'ConnectX', 'https://www.connectx.app', 'Conexão de redes profissionais.', 'Vinicius Lopes', 'contato@connectx.app', '16161616161');
    pkg_insercoes.inserir_startup('35678899000166', 'https://youtu.be/AD0FbOR4Zj8?si=0ju9Mhi6vRP7WPPE', 'NanoSoft', 'https://www.nanosoft.ai', 'Microprocessadores inteligentes.', 'Amanda Rocha', 'info@nanosoft.ai', '17171717171');
    pkg_insercoes.inserir_startup('36789900000177', 'https://youtu.be/6EEJBaH_f7Y?si=HIU66sWevhJTyzUZ', 'FreshHome', 'https://www.freshhome.io', 'Automação residencial sustentável.', 'Thiago Barreto', 'suporte@freshhome.io', '18181818181');
    pkg_insercoes.inserir_startup('37890011000188', 'https://youtu.be/98I-3SiHPtg?si=izuc-PiCl2Pn1dUb', 'AirBot', 'https://www.airbot.ai', 'Drones autônomos para entrega.', 'Sara Monteiro', 'contato@airbot.ai', '19191919191');
    pkg_insercoes.inserir_startup('38901122000199', 'https://youtu.be/AD0FbOR4Zj8?si=0ju9Mhi6vRP7WPPE', 'FinFlow', 'https://www.finflow.io', 'Gestão financeira automatizada.', 'Eduardo Martins', 'finance@finflow.io', '20202020202');
    pkg_insercoes.inserir_startup('39012233000100', 'https://youtu.be/K3ucIhcVmpk?si=B97TQ5DhXtRweBuv', 'TerraScan', 'https://www.terrascan.com', 'Monitoramento geoespacial.', 'Julio Carvalho', 'contato@terrascan.com', '30303030303');
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

    pkg_insercoes.inserir_avaliacao(11, 8, 'Ferramenta útil e fácil de navegar.', '11122233344', '20223344000111');
    pkg_insercoes.inserir_avaliacao(12, 9, 'Excelente desempenho e suporte.', '22233344455', '21334455000122');
    pkg_insercoes.inserir_avaliacao(13, 7, 'Bom potencial, mas precisa evoluir.', '33344455566', '22445566000133');
    pkg_insercoes.inserir_avaliacao(14, 10, 'Inovadora e extremamente eficiente!', '44455566677', '23556677000144');
    pkg_insercoes.inserir_avaliacao(15, 8, 'Plataforma muito intuitiva.', '55566677788', '24667788000155');
    pkg_insercoes.inserir_avaliacao(16, 9, 'Excelente solução para o mercado.', '66677788899', '25778899000166');
    pkg_insercoes.inserir_avaliacao(17, 8, 'Boa performance e ótima ergonomia.', '77788899900', '26889900000177');
    pkg_insercoes.inserir_avaliacao(18, 7, 'Requer melhorias na interface.', '88899900011', '27990011000188');
    pkg_insercoes.inserir_avaliacao(19, 10, 'O melhor produto que já utilizei.', '99900011122', '28001122000199');
    pkg_insercoes.inserir_avaliacao(20, 9, 'Muito prática e funcional.', '10101010101', '29012233000100');

    pkg_insercoes.inserir_avaliacao(21, 8, 'Boa experiência de uso.', '12121212121', '30123344000111');
    pkg_insercoes.inserir_avaliacao(22, 7, 'Alguns bugs, mas nada grave.', '13131313131', '31234455000122');
    pkg_insercoes.inserir_avaliacao(23, 9, 'Excelente proposta de valor.', '14141414141', '32345566000133');
    pkg_insercoes.inserir_avaliacao(24, 8, 'Ótimo custo-benefício.', '15151515151', '33456677000144');
    pkg_insercoes.inserir_avaliacao(25, 10, 'Simplesmente fantástica.', '16161616161', '34567788000155');
    pkg_insercoes.inserir_avaliacao(26, 6, 'Pode melhorar a estabilidade.', '17171717171', '35678899000166');
    pkg_insercoes.inserir_avaliacao(27, 9, 'Muito inovadora e eficiente.', '18181818181', '36789900000177');
    pkg_insercoes.inserir_avaliacao(28, 8, 'Interface moderna e fluida.', '19191919191', '37890011000188');
    pkg_insercoes.inserir_avaliacao(29, 9, 'Entrega tudo que promete.', '20202020202', '38901122000199');
    pkg_insercoes.inserir_avaliacao(30, 7, 'Boa, mas ainda em amadurecimento.', '30303030303', '39012233000100');
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
    
   pkg_insercoes.inserir_possui(11, '20223344000111', 21);
    pkg_insercoes.inserir_possui(12, '21334455000122', 27);
    pkg_insercoes.inserir_possui(13, '22445566000133', 11);
    pkg_insercoes.inserir_possui(14, '23556677000144', 19);
    pkg_insercoes.inserir_possui(15, '24667788000155', 16);
    pkg_insercoes.inserir_possui(16, '25778899000166', 22);
    pkg_insercoes.inserir_possui(17, '26889900000177', 14);
    pkg_insercoes.inserir_possui(18, '27990011000188', 18);
    pkg_insercoes.inserir_possui(19, '28001122000199', 23);
    pkg_insercoes.inserir_possui(20, '29012233000100', 24);

    pkg_insercoes.inserir_possui(21, '30123344000111', 12);
    pkg_insercoes.inserir_possui(22, '31234455000122', 28);
    pkg_insercoes.inserir_possui(23, '32345566000133', 30);
    pkg_insercoes.inserir_possui(24, '33456677000144', 25);
    pkg_insercoes.inserir_possui(25, '34567788000155', 29);
    pkg_insercoes.inserir_possui(26, '35678899000166', 13);
    pkg_insercoes.inserir_possui(27, '36789900000177', 20);
    pkg_insercoes.inserir_possui(28, '37890011000188', 26);
    pkg_insercoes.inserir_possui(29, '38901122000199', 17);
    pkg_insercoes.inserir_possui(30, '39012233000100', 15);
END;
/

COMMIT;



----------------------------------------------------------------------------------------------
--                                      Sequence
----------------------------------------------------------------------------------------------


DROP SEQUENCE habilidade_seq;
DROP SEQUENCE avaliacao_seq;
DROP SEQUENCE possui_seq;
DROP SEQUENCE auditoria_seq;


CREATE SEQUENCE habilidade_seq START WITH 31 INCREMENT BY 1;
CREATE SEQUENCE avaliacao_seq START WITH 31 INCREMENT BY 1;
CREATE SEQUENCE possui_seq START WITH 31 INCREMENT BY 1;
CREATE SEQUENCE auditoria_seq START WITH 31 INCREMENT BY 1;


ALTER TABLE habilidade MODIFY Id_habilidade DEFAULT habilidade_seq.NEXTVAL;
ALTER TABLE avaliacao MODIFY Id_avaliacao DEFAULT avaliacao_seq.NEXTVAL;
ALTER TABLE possui MODIFY Id_possui DEFAULT possui_seq.NEXTVAL;
ALTER TABLE auditoria MODIFY id_auditoria DEFAULT auditoria_seq.NEXTVAL;





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
    pkg_insercoes.inserir_habilidade(31, 'Desenvolvimento Frontend', 'Tecnologia');
    pkg_atualizacoes.atualizar_habilidade(
        p_id_habilidade   => 31,
        p_nome_habilidade => 'Desenvolvimento Frontend Avançado',
        p_tipo_habilidade => 'Tecnologia'
    );

    pkg_exclusoes.deletar_habilidade(31);
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

