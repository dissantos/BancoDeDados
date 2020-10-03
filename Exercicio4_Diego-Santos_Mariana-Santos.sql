-- EXERCICIO 04 - LBDI

-- Comandos DDL – Linguagem de Definição de Dados

-- Diego Santos Goncalves                   20183012537
-- Mariana Bulgarelli Alves dos Santos      20183000330

-- ****************************************************************

-- 1) Apresente os comandos LDD para os seguintes itens.
-- a. Crie as tabelas seguintes, sem chaves primárias e sem chaves estrangeiras.
-- • TIME (ID, NOME)
-- • JOGO (DATA,PLACAR_CASA,PLACAR_VISITANTE)
-- • JOGADOR (CPF,NOME)

-- drop table TIME cascade constraints;
-- drop table JOGO cascade constraints;
-- drop table JOGADOR cascade constraints;

create table TIME(
ID      number(2),
Nome    varchar2(50));

create table JOGO(
Data                DATE,
Placar_casa        NUMBER(2),
Placar_visitante   number(2));

create table JOGADOR(
cpf     VARCHAR2(11),
nome    varchar2(50));

-- b. Preencha essas tabelas com dados
Insert into TIME (ID, nome) values (01, 'Varzea');
Insert into TIME (ID, nome) values (02, 'Amazonia Verde');
Insert into TIME (ID, nome) values (03, 'Atlética Acriana');
Insert into TIME (ID, nome) values (04, 'Ursa Menor');

Insert into JOGO (Data, Placar_casa, Placar_visitante) values ('24-12-2020', 4, 2);
Insert into JOGO (Data, Placar_casa, Placar_visitante) values ('01-01-2021', 1, 0);
Insert into JOGO (Data, Placar_casa, Placar_visitante) values ('22-02-2021', 2, 1);
Insert into JOGO (Data, Placar_casa, Placar_visitante) values ('22-04-2021', 1, 1);

Insert into JOGADOR (cpf, nome) values ('12345678910', 'Fernanda Angela');
Insert into JOGADOR (cpf, nome) values ('98765432111', 'Marta Maria');
Insert into JOGADOR (cpf, nome) values ('78945612312', 'Pamela Silva');
Insert into JOGADOR (cpf, nome) values ('45698732113', 'Joana Loureiro');
Insert into JOGADOR (cpf, nome) values ('14785236914', 'Tatiana Souza');
Insert into JOGADOR (cpf, nome) values ('96385274115', 'Jurema Di Mariano');
Insert into JOGADOR (cpf, nome) values ('84269517316', 'Georgia Jorge');
Insert into JOGADOR (cpf, nome) values ('42687539117', 'Waleska Lima');
Insert into JOGADOR (cpf, nome) values ('10023654789', 'Ursula Ferreira');
Insert into JOGADOR (cpf, nome) values ('10123658749', 'Zuleide Tavares');
Insert into JOGADOR (cpf, nome) values ('54632189755', 'Luiza Monteiro');
Insert into JOGADOR (cpf, nome) values ('87412369589', 'Catarina Lemos');

-- c. Adicione as chaves primárias TIME.ID e JOGADOR.CPF.
alter table TIME add constraint PK_TIME_ID primary key (id);
alter table JOGADOR add constraint PK_JOGADOR_CPF primary key (cpf);

-- d. Adicione as chaves estrangeiras em tais tabelas, considerando as seguintes integridades
-- referencias. As colunas para as chaves estrangeiras também devem ser incluídas
-- (JOGO.ID_CASA, JOGO.ID_VISITANTE, JOGADOR.ID_TIME).

-- i. JOGO [ID_CASA] à TIME [ID]
alter table JOGO add id_casa number(2);

alter table JOGO
add constraint FK_JOGO_TIME_CASA
foreign key (id_casa)
references TIME(id);

-- ii. JOGO [ID_VISITANTE] à TIME [ID]
alter table JOGO add id_visitante number(2);

alter table JOGO
add constraint FK_JOGO_TIME_VISITANTE
foreign key (id_visitante)
references TIME(id);

-- iii. JOGADOR [ID_TIME] à TIME [ID]
alter table JOGADOR add id_time number(2);

alter table JOGADOR
add constraint FK_JOGADOR_TIME
foreign key (id_time)
references TIME(id);

-- e. Estabeleça as integridades referencias através de dados em todas as tabelas com chaves
-- estrangeiras. Para isso, atualize a chaves estrangeiras com valores de chaves primárias.
Update JOGO set id_casa=01 Where data='24-12-2020';
Update JOGO set id_casa=02 Where data='01-01-2021';
Update JOGO set id_casa=03 Where data='22-02-2021';
Update JOGO set id_casa=04 Where data='22-04-2021';

Update JOGADOR set id_time=01 Where cpf ='12345678910';
Update JOGADOR set id_time=02 Where cpf ='98765432111';
Update JOGADOR set id_time=03 Where cpf ='78945612312';
Update JOGADOR set id_time=04 Where cpf ='45698732113';
Update JOGADOR set id_time=01 Where cpf ='14785236914';
Update JOGADOR set id_time=02 Where cpf ='96385274115';
Update JOGADOR set id_time=03 Where cpf ='84269517316';
Update JOGADOR set id_time=04 Where cpf ='42687539117';
Update JOGADOR set id_time=01 Where cpf ='10023654789';
Update JOGADOR set id_time=02 Where cpf ='10123658749';
Update JOGADOR set id_time=03 Where cpf ='54632189755';
Update JOGADOR set id_time=04 Where cpf ='87412369589';

Update JOGO set id_visitante=02 Where data='24-12-2020';
Update JOGO set id_visitante=03 Where data='01-01-2021';
Update JOGO set id_visitante=04 Where data='22-02-2021';
Update JOGO set id_visitante=01 Where data='22-04-2021';

-- f. Adicione a chave primária em JOGO
alter table JOGO add constraint PK_JOGO primary key (id_casa, id_visitante);

-- g. Adicione dados em todas tabelas
Insert into TIME (ID, nome) values (00, 'Mirim Kids');

Insert into JOGO (Data, Placar_casa, Placar_visitante, id_casa, id_visitante) values ('20-05-2021', 3, 1, 01, 03); -- A FINAL 

Insert into JOGADOR (cpf, nome, id_time) values ('10010010022', 'Valentina Fonseca', 00);


select * from JOGO;