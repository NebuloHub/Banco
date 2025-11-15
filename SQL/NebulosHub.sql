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
    
    pkg_insercoes.inserir_usuario('11111111111', 'Fernando Ribeiro', 'fernando.ribeiro@techinova.com', 'SenhaF1!', 'USER', 11987651234);
    pkg_insercoes.inserir_usuario('22222222222', 'Patricia Gomes', 'patricia.gomes@creativesoft.com', 'Paty2025$', 'USER', 21976541234);
    pkg_insercoes.inserir_usuario('33333333333', 'Hugo Martins', 'hugo.martins@falconai.com', 'Hugo@Ai33', 'ADMIN', 31975468912);
    pkg_insercoes.inserir_usuario('44444444444', 'Simone Araujo', 'simone.araujo@bluewave.com', 'Simone#44', 'USER', 41988887766);
    pkg_insercoes.inserir_usuario('55555555555', 'Eduardo Batista', 'eduardo.batista@softmind.com', 'Edu555', 'USER', 11976543211);
    pkg_insercoes.inserir_usuario('66666666666', 'Renata Xavier', 'renata.xavier@futuretech.com', 'Renata!66', 'ADMIN', 21987654322);
    pkg_insercoes.inserir_usuario('77777777777', 'João Paulo Medeiros', 'jp.medeiros@syscloud.com', 'JoaoP77', 'USER', 31923456789);
    pkg_insercoes.inserir_usuario('88888888888', 'Aline Castro', 'aline.castro@ecoenergy.com', 'Aline88$', 'USER', 11955667788);
    pkg_insercoes.inserir_usuario('99999999999', 'Gabriela Mendes', 'gabi.mendes@flowdata.com', 'Gabi#2024', 'USER', 11944332211);
    pkg_insercoes.inserir_usuario('10101010101', 'Marcelo Santos', 'marcelo.santos@infinity.com', 'Marce1010', 'USER', 21966554422);

    pkg_insercoes.inserir_usuario('20202020202', 'Elisa Fernandes', 'elisa.fernandes@auton.tech', 'Elisa@2020', 'USER', 31988442211);
    pkg_insercoes.inserir_usuario('30303030303', 'Rodrigo Lima', 'rodrigo.lima@digitalhub.com', 'Rod3003', 'ADMIN', 11999887744);
    pkg_insercoes.inserir_usuario('40404040404', 'Daniel Costa', 'daniel.costa@rocketdev.com', 'Dan#4040', 'USER', 11956781234);
    pkg_insercoes.inserir_usuario('50505050505', 'Vanessa Duarte', 'vanessa.duarte@microgreen.com', 'Vane5050', 'USER', 21976558899);
    pkg_insercoes.inserir_usuario('60606060606', 'Thiago Moreira', 'thiago.moreira@aiworks.com', 'Thiago6060!', 'USER', 31999881122);
    pkg_insercoes.inserir_usuario('70707070707', 'Clara Mendes', 'clara.mendes@nextwave.com', 'Clara$7070', 'USER', 11988552233);
    pkg_insercoes.inserir_usuario('80808080808', 'André Carvalho', 'andre.carvalho@shiptech.com', 'Andre8080', 'USER', 41999884455);
    pkg_insercoes.inserir_usuario('90909090909', 'Luana Barros', 'luana.barros@cosmosdata.com', 'Luana9090', 'ADMIN', 21977441122);
    pkg_insercoes.inserir_usuario('12121212121', 'Isadora Pinto', 'isadora.pinto@devpoint.com', 'Isa1212!', 'USER', 31955554433);
    pkg_insercoes.inserir_usuario('13131313131', 'Mateus Rocha', 'mateus.rocha@cloudone.com', 'Mateus1313$', 'USER', 11944556677);
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
    
    pkg_insercoes.inserir_habilidade(11, 'Cybersegurança', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(12, 'Gestão de Projetos Ágeis', 'Administração');
    pkg_insercoes.inserir_habilidade(13, 'Arquitetura de Software', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(14, 'Edição de Vídeo', 'Design');
    pkg_insercoes.inserir_habilidade(15, 'Copywriting', 'Comercial');
    pkg_insercoes.inserir_habilidade(16, 'Growth Hacking', 'Marketing');
    pkg_insercoes.inserir_habilidade(17, 'Engenharia de Prompt', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(18, 'Pesquisa de Mercado', 'Comercial');
    pkg_insercoes.inserir_habilidade(19, 'Contabilidade Avançada', 'Administração');
    pkg_insercoes.inserir_habilidade(20, 'Sistemas Embarcados', 'Tecnologia');

    pkg_insercoes.inserir_habilidade(21, 'Ilustração Digital', 'Design');
    pkg_insercoes.inserir_habilidade(22, 'Negociação Comercial', 'Comercial');
    pkg_insercoes.inserir_habilidade(23, 'Cloud Computing', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(24, 'DevOps', 'Tecnologia');
    pkg_insercoes.inserir_habilidade(25, 'Produção de Conteúdo', 'Marketing');
    pkg_insercoes.inserir_habilidade(26, 'Fundraising para Startups', 'Administração');
    pkg_insercoes.inserir_habilidade(27, 'Lean Startup', 'Administração');
    pkg_insercoes.inserir_habilidade(28, 'Animação 3D', 'Design');
    pkg_insercoes.inserir_habilidade(29, 'E-commerce Estratégico', 'Comercial');
    pkg_insercoes.inserir_habilidade(30, 'Automação com IA', 'Tecnologia');
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
    
    pkg_insercoes.inserir_startup('11111222000111', NULL, 'SkyConnect', 'https://skyconnect.io','Rede de APIs para integração rápida.', 'Fernando Ribeiro','contato@skyconnect.io', '11111111111');
    pkg_insercoes.inserir_startup('22222333000122', NULL, 'BioTrack', 'https://biotrack.health','Monitoramento biométrico inteligente.', 'Patricia Gomes','hello@biotrack.health', '22222222222');
    pkg_insercoes.inserir_startup('33333444000133', NULL, 'AutoBrain', 'https://autobrain.ai','Sistemas autônomos para logística.', 'Hugo Martins','contato@autobrain.ai', '33333333333');
    pkg_insercoes.inserir_startup('44444555000144', NULL, 'WaveCast', 'https://wavecast.com','Plataforma de streaming corporativo.', 'Simone Araujo','info@wavecast.com', '44444444444');
    pkg_insercoes.inserir_startup('55555666000155', NULL, 'EcoBalance', 'https://ecobalance.io','Gestão sustentável e compensação ambiental.', 'Eduardo Batista','suporte@ecobalance.io', '55555555555');
    pkg_insercoes.inserir_startup('66666777000166', NULL, 'MindVision', 'https://mindvision.ai','IA aplicada à saúde mental.', 'Renata Xavier','contato@mindvision.ai', '66666666666');
    pkg_insercoes.inserir_startup('77777888000177', NULL, 'ShipFlow', 'https://shipflow.com','Gestão de frotas marítimas com IoT.', 'João Paulo Medeiros','suporte@shipflow.com', '77777777777');
    pkg_insercoes.inserir_startup('88888999000188', NULL, 'DataFlux', 'https://dataflux.dev','Big Data em tempo real.', 'Aline Castro','info@dataflux.dev', '88888888888');
    pkg_insercoes.inserir_startup('99999000000199', NULL, 'AutoGreen', 'https://autogreen.eco','Automação inteligente para agricultura.', 'Gabriela Mendes','contato@autogreen.eco', '99999999999');
    pkg_insercoes.inserir_startup('10101033000101', NULL, 'Infinidata', 'https://infinidata.com','Gestão inteligente de dados.', 'Marcelo Santos','hello@infinidata.com', '10101010101');
    pkg_insercoes.inserir_startup('20202033000120', NULL, 'SustainaTech', 'https://sustainatech.com', 'Tecnologias verdes aplicadas ao setor industrial.', 'Elisa Fernandes', 'contato@sustainatech.com', '20202020202');
    pkg_insercoes.inserir_startup('30303044000130', NULL, 'OmegaSoft', 'https://omegasoft.io', 'Plataforma de desenvolvimento low-code.', 'Rodrigo Lima', 'hello@omegasoft.io', '30303030303');
    pkg_insercoes.inserir_startup('40404055000140', NULL, 'VisionFood', 'https://visionfood.ai', 'IA para análise nutricional de alimentos.', 'Daniel Costa', 'info@visionfood.ai', '40404040404');
    pkg_insercoes.inserir_startup('50505066000150', NULL, 'SmartPay', 'https://smartpay.tech', 'Pagamentos instantâneos com blockchain.', 'Vanessa Duarte', 'suporte@smartpay.tech', '50505050505');
    pkg_insercoes.inserir_startup('60606077000160', NULL, 'DeepLink', 'https://deeplink.ai', 'Identificação inteligente de padrões.', 'Thiago Moreira', 'contato@deeplink.ai', '60606060606');
    pkg_insercoes.inserir_startup('70707088000170', NULL, 'NextFarm', 'https://nextfarm.io', 'Precision farming com drones.', 'Clara Mendes', 'contato@nextfarm.io', '70707070707');
    pkg_insercoes.inserir_startup('80808099000180', NULL, 'MoonTech', 'https://moontech.space', 'Soluções aeroespaciais acessíveis.', 'André Carvalho', 'hello@moontech.space', '80808080808');
    pkg_insercoes.inserir_startup('90909000000290', NULL, 'NeuroLink', 'https://neurolink.ai', 'Interfaces cérebro-máquina.', 'Luana Barros', 'suporte@neurolink.ai', '90909090909');
    pkg_insercoes.inserir_startup('12121233000112', NULL, 'SmartSales', 'https://smartsales.com', 'Plataforma inteligente de vendas.', 'Isadora Pinto', 'info@smartsales.com', '12121212121');
    pkg_insercoes.inserir_startup('13131344000113', NULL, 'LogicOne', 'https://logicone.dev', 'Otimização logística com IA.', 'Mateus Rocha', 'contato@logicone.dev', '13131313131');
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
    
    pkg_insercoes.inserir_avaliacao(11, 9, 'Muito eficiente e fácil de usar.', '11111111111', '11111222000111');
    pkg_insercoes.inserir_avaliacao(12, 8, 'A ideia é ótima, mas pode melhorar.', '22222222222', '22222333000122');
    pkg_insercoes.inserir_avaliacao(13, 10, 'Simplesmente incrível!', '33333333333', '33333444000133');
    pkg_insercoes.inserir_avaliacao(14, 7, 'Bom, mas precisa de melhorias.', '44444444444', '44444555000144');
    pkg_insercoes.inserir_avaliacao(15, 9, 'Ferramenta extremamente útil.', '55555555555', '55555666000155');
    pkg_insercoes.inserir_avaliacao(16, 6, 'Os relatórios são lentos às vezes.', '66666666666', '66666777000166');
    pkg_insercoes.inserir_avaliacao(17, 10, 'Revolucionário!', '77777777777', '77777888000177');
    pkg_insercoes.inserir_avaliacao(18, 8, 'Muito bom no geral.', '88888888888', '88888999000188');
    pkg_insercoes.inserir_avaliacao(19, 7, 'Boa plataforma, mas interface confusa.', '99999999999', '99999000000199');
    pkg_insercoes.inserir_avaliacao(20, 9, 'Excelente performance.', '10101010101', '10101033000101');

    pkg_insercoes.inserir_avaliacao(21, 8, 'Atendeu às expectativas.', '20202020202', '20202033000120');
    pkg_insercoes.inserir_avaliacao(22, 9, 'Plataforma bem estável.', '30303030303', '30303044000130');
    pkg_insercoes.inserir_avaliacao(23, 7, 'Boa, mas falta integração.', '40404040404', '40404055000140');
    pkg_insercoes.inserir_avaliacao(24, 10, 'Perfeita para meu negócio!', '50505050505', '50505066000150');
    pkg_insercoes.inserir_avaliacao(25, 6, 'O app trava às vezes.', '60606060606', '60606077000160');
    pkg_insercoes.inserir_avaliacao(26, 8, 'Gostei bastante da inovação.', '70707070707', '70707088000170');
    pkg_insercoes.inserir_avaliacao(27, 9, 'Layout muito bem trabalhado.', '80808080808', '80808099000180');
    pkg_insercoes.inserir_avaliacao(28, 10, 'Superou minhas expectativas.', '90909090909', '90909000000290');
    pkg_insercoes.inserir_avaliacao(29, 8, 'Plataforma organizada.', '12121212121', '12121233000112');
    pkg_insercoes.inserir_avaliacao(30, 9, 'Muito útil no dia a dia.', '13131313131', '13131344000113');
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
    
    pkg_insercoes.inserir_possui(11, '11111222000111', 11);
    pkg_insercoes.inserir_possui(12, '22222333000122', 12);
    pkg_insercoes.inserir_possui(13, '33333444000133', 13);
    pkg_insercoes.inserir_possui(14, '44444555000144', 14);
    pkg_insercoes.inserir_possui(15, '55555666000155', 15);
    pkg_insercoes.inserir_possui(16, '66666777000166', 16);
    pkg_insercoes.inserir_possui(17, '77777888000177', 17);
    pkg_insercoes.inserir_possui(18, '88888999000188', 18);
    pkg_insercoes.inserir_possui(19, '99999000000199', 19);
    pkg_insercoes.inserir_possui(20, '10101033000101', 20);

    pkg_insercoes.inserir_possui(21, '20202033000120', 21);
    pkg_insercoes.inserir_possui(22, '30303044000130', 22);
    pkg_insercoes.inserir_possui(23, '40404055000140', 23);
    pkg_insercoes.inserir_possui(24, '50505066000150', 24);
    pkg_insercoes.inserir_possui(25, '60606077000160', 25);
    pkg_insercoes.inserir_possui(26, '70707088000170', 26);
    pkg_insercoes.inserir_possui(27, '80808099000180', 27);
    pkg_insercoes.inserir_possui(28, '90909000000290', 28);
    pkg_insercoes.inserir_possui(29, '12121233000112', 29);
    pkg_insercoes.inserir_possui(30, '13131344000113', 30);
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

