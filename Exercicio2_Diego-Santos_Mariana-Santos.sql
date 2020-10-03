-- EXERCICIO 2
-- Nome: Diego Santos Gonçalves                 Matricula: 20183012537
--       Mariana Bulgarelli Alves dos Santos               20183000330

-- Gerado por Oracle SQL Developer Data Modeler 20.2.0.167.1538
--   em:        2020-09-14 20:28:19 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g


-- 2)Preencha o banco de dados criado na Questão 1


drop table departamento cascade constraints;
drop table funcionario cascade constraints;
drop table dependente cascade constraints;
drop table localizacoes_departamento cascade constraints;
drop table projeto cascade constraints;
drop table trabalha_em cascade constraints;
-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE departamento (
    nome_departamento    VARCHAR2(100) NOT NULL,
    numero_departamento  NUMBER NOT NULL,
    cpf_gerente          VARCHAR2(11),
    data_inicio_gerente  DATE NOT NULL
);

ALTER TABLE departamento ADD CONSTRAINT departamento_pk PRIMARY KEY ( numero_departamento );

ALTER TABLE departamento ADD CONSTRAINT departamento__unv2 UNIQUE ( nome_departamento );

ALTER TABLE departamento ADD CONSTRAINT un_cpf_gerente UNIQUE ( cpf_gerente );

CREATE TABLE dependente (
    cpf_funcionario  VARCHAR2(11) NOT NULL,
    nome_dependente  VARCHAR2(30) NOT NULL,
    sexo             VARCHAR2(1) NOT NULL,
    data_nascimento  DATE NOT NULL,
    parentesco       VARCHAR2(30) NOT NULL
);

ALTER TABLE dependente
    ADD CONSTRAINT ck_sexo_dependente CHECK ( sexo = 'F'
                                              OR sexo = 'M' );

ALTER TABLE dependente
    ADD CONSTRAINT ck_parentesco CHECK ( parentesco IN ( 'Filho', 'Filha', 'Marido', 'Esposa' ) );

ALTER TABLE dependente ADD CONSTRAINT dependente_pk PRIMARY KEY ( cpf_funcionario,
                                                                  nome_dependente );

CREATE TABLE funcionario (
    primeiro_nome        VARCHAR2(30) NOT NULL,
    nome_meio            VARCHAR2(30),
    ultimo_nome          VARCHAR2(30) NOT NULL,
    cpf                  VARCHAR2(11) NOT NULL,
    data_nascimento      DATE NOT NULL,
    endereco             VARCHAR2(100) NOT NULL,
    sexo                 VARCHAR2(1) NOT NULL,
    salario              NUMBER(5) NOT NULL,
    cpf_supervisor       VARCHAR2(11),
    numero_departamento  NUMBER NOT NULL
);

ALTER TABLE funcionario
    ADD CONSTRAINT ck_salario CHECK ( salario BETWEEN 10000 AND 100000 );

ALTER TABLE funcionario
    ADD CONSTRAINT ck_sexo_func CHECK ( sexo = 'F'
                                        OR sexo = 'M' );

ALTER TABLE funcionario ADD CONSTRAINT funcionario_pk PRIMARY KEY ( cpf );

CREATE TABLE localizacoes_departamento (
    numero_departamento  NUMBER NOT NULL,
    local                VARCHAR2(100) NOT NULL
);

ALTER TABLE localizacoes_departamento ADD CONSTRAINT localizacoes_departamento_pk PRIMARY KEY ( numero_departamento,
                                                                                                local );

CREATE TABLE projeto (
    nome_projeto         VARCHAR2(50) NOT NULL,
    numero_projeto       NUMBER(2) NOT NULL,
    local_projeto        VARCHAR2(100) NOT NULL,
    numero_departamento  NUMBER NOT NULL
);

ALTER TABLE projeto ADD CONSTRAINT projeto_pk PRIMARY KEY ( numero_projeto );

CREATE TABLE trabalha_em (
    cpf_funcionario  VARCHAR2(11) NOT NULL,
    numero_projeto   NUMBER(2) NOT NULL,
    horas            NUMBER(3, 1)
);

ALTER TABLE trabalha_em ADD CONSTRAINT trabalha_em_pk PRIMARY KEY ( cpf_funcionario,
                                                                    numero_projeto );

ALTER TABLE departamento
    ADD CONSTRAINT departamento_funcionario_fk FOREIGN KEY ( cpf_gerente )
        REFERENCES funcionario ( cpf );

ALTER TABLE dependente
    ADD CONSTRAINT dependente_funcionario_fk FOREIGN KEY ( cpf_funcionario )
        REFERENCES funcionario ( cpf );

ALTER TABLE funcionario
    ADD CONSTRAINT funcionario_departamento_fk FOREIGN KEY ( numero_departamento )
        REFERENCES departamento ( numero_departamento );

ALTER TABLE funcionario
    ADD CONSTRAINT funcionario_funcionario_fk FOREIGN KEY ( cpf_supervisor )
        REFERENCES funcionario ( cpf );

ALTER TABLE localizacoes_departamento
    ADD CONSTRAINT localizacoes_depto_depto_fk FOREIGN KEY ( numero_departamento )
        REFERENCES departamento ( numero_departamento );

ALTER TABLE projeto
    ADD CONSTRAINT projeto_departamento_fk FOREIGN KEY ( numero_departamento )
        REFERENCES departamento ( numero_departamento );

ALTER TABLE trabalha_em
    ADD CONSTRAINT trabalha_em_funcionario_fk FOREIGN KEY ( cpf_funcionario )
        REFERENCES funcionario ( cpf );

ALTER TABLE trabalha_em
    ADD CONSTRAINT trabalha_em_projeto_fk FOREIGN KEY ( numero_projeto )
        REFERENCES projeto ( numero_projeto );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             0
-- ALTER TABLE                             20
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0




-- Inserir departamento com cpf do gerente nulos
insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('Pesquisa', 5, Null, Date '1988-05-22');

insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('Administracao', 4, Null, Date '1995-01-01');

insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('Matriz', 1, Null, Date '1981-06-19');

-- Inserir funcionários por ordem hierárquica
insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Jorge','E','Brito','88866555576',Date '1937-11-10','Rua do Horto, 35, Sao Paulo, SP','M',55000,NULL,1);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Jennifer','S','Souza','98765432168',Date '1941-06-20','Av. Arthur de Lima, 54, Santo Andre, SP','F',43000,'88866555576',4);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Fernando','T','Wong','33344555587',Date '1955-12-08','Rua da Lapa, 34, Sao Paulo, SP','M',40000,'88866555576',5);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Alice','J','Zelaya','99988777767',Date '1968-01-19','Rua Souza Lima, 35, Curitiba, PR','F',25000,'98765432168',4);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Andre','V','Pereira','98798798733',Date '1969-03-29','Rua Timbira, 35, Sao Paulo, SP','M',25000,'98765432168',4);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Joao','B','Silva','12345678966',Date '1965-01-09','Rua das Flores, 751, Sao Paulo, SP','M',30000,'33344555587',5);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Ronaldo','K','Lima','66688444476',Date '1962-09-15','Rua Reboucas, 65, Piracicaba, SP','M',38000,'33344555587',5);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Joice','A','Leite','45345345376',Date '1972-07-31','Av. Lucas Obes, 74, Sao Paulo, SP','F',25000,'33344555587',5);


-- Atualiza os cpf dos gerentes nos dados do Departamento agora que os funcionarios foram inseridos
update DEPARTAMENTO set  Cpf_gerente = '33344555587'
where Numero_departamento = 5;

update DEPARTAMENTO set  Cpf_gerente = '98765432168'
where Numero_departamento = 4;

update DEPARTAMENTO set  Cpf_gerente = '88866555576'
where Numero_departamento = 1;

-- Inserção dos dados da tabela LOCALIZACOES_DEPARTAMENTO
insert into LOCALIZACOES_DEPARTAMENTO(Numero_departamento, local)
values (1, 'Sao Paulo');

insert into LOCALIZACOES_DEPARTAMENTO(Numero_departamento, local)
values (4, 'Maua');

insert into LOCALIZACOES_DEPARTAMENTO(Numero_departamento, local)
values (5, 'Santo Andre');
    
insert into LOCALIZACOES_DEPARTAMENTO(Numero_departamento, local)
values (5, 'Itu');

insert into LOCALIZACOES_DEPARTAMENTO(Numero_departamento, local)
values (5, 'Sao Paulo');


-- Inserção de dados na tabela PROJETO
insert into PROJETO (Nome_projeto, Numero_projeto, Local_projeto, Numero_departamento)
values ('ProdutoX', 1, 'Santo Andre', 5);

insert into PROJETO (Nome_projeto, Numero_projeto, Local_projeto, Numero_departamento)
values ('ProdutoY', 2, 'Itu', 5);

insert into PROJETO (Nome_projeto, Numero_projeto, Local_projeto, Numero_departamento)
values ('ProdutoZ', 3, 'Sao Paulo', 5);

insert into PROJETO (Nome_projeto, Numero_projeto, Local_projeto, Numero_departamento)
values ('Informatizacao', 10, 'Maua', 4);

insert into PROJETO (Nome_projeto, Numero_projeto, Local_projeto, Numero_departamento)
values ('Reorganizacao', 20, 'Sao Paulo', 1);

insert into PROJETO (Nome_projeto, Numero_projeto, Local_projeto, Numero_departamento)
values ('Novosbeneficios', 30, 'Maua', 4);


-- Inserção de dados na tabela TRABALHA_EM
insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('12345678966', 1, 32.5);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('12345678966', 2, 7.5);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('66688444476', 3, 40.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('45345345376', 1, 20.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('45345345376', 2, 20.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('33344555587', 2, 10.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('33344555587', 3, 10.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('33344555587', 10, 10.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('33344555587', 20, 10.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('99988777767', 30, 30.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('99988777767', 10, 10.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('98798798733', 10, 35.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('98798798733', 30, 5.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('98765432168', 30, 20.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('98765432168', 20, 15.0);

insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('88866555576', 20, NULL);


-- Inserção de dados na tabela dependente 

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values ('33344555587', 'Alicia', 'F', Date '1986-04-05', 'Filha');

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values ('33344555587', 'Tiago', 'M', Date '1983-10-25', 'Filho');

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values ('33344555587', 'Janaina', 'F',Date '1958-05-03', 'Esposa');

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values ('98765432168', 'Antonio', 'M',Date '1942-02-28', 'Marido');

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values ('12345678966', 'Michael', 'M',Date '1988-01-04', 'Filho');

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values ('12345678966', 'Alicia', 'F', Date '1988-12-30', 'Filha');

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values ('12345678966', 'Elizabeth', 'F',Date '1967-05-05', 'Esposa');


-- Tentantivas de violacao

-- Violacao da restrição de dominio
insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values ('33344555587', 'Roberto', 'N', Date '1986-04-05', 'Filho');

-- Violacao da restrição de chave
insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('RH', 5, Null, Date '2000-05-05');

-- Violacao da restrição de	entidade
insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('Engenharia', Null, '77788866632', Date '1988-05-22');

-- Violacao da restrição de	não	nulo
insert into PROJETO (Nome_projeto, Numero_projeto, Local_projeto, Numero_departamento)
values (Null, 6, 'Santo Andre', 5);

-- Violacao da restrição de integridade referencial
insert into trabalha_em (Cpf_funcionario, Numero_projeto, Horas)
values ('12345678966', 6, 44);
