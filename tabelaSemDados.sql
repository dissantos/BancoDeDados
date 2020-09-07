-- Lista 1
-- Nome: Diego Santos Gonçalves                 Matricula: 20183012537
--       Mariana Bulgarelli Alves dos Santos               20183000330

--1) Criação das tabelas
-- Criação da tabela DEPARTAMENTO
CREATE TABLE DEPARTAMENTO (
    Nome_departamento                VARCHAR2(100) NOT NULL unique,
    Numero_departamento              NUMBER NOT NULL,
    Cpf_gerente                      NUMBER(11,0) unique,
    Data_inicio_gerente              DATE NOT NULL,
    constraint PK_DEPARTAMENTO primary key (Numero_departamento)
);

--Criação da tabela Funcionário
CREATE TABLE FUNCIONARIO (
    Primeiro_nome           VARCHAR2(30) NOT NULL,
    Nome_meio              VARCHAR2(30),
    Ultimo_nome            VARCHAR2(30) NOT NULL,
    Cpf                    NUMBER(11,0) NOT NULL,
    Data_nascimento        DATE  NOT NULL,
    Endereco               VARCHAR2(200) NOT NULL,
    Sexo                   VARCHAR2(1) NOT NULL,
    Salario                NUMBER(5,0) NOT NULL,
    Cpf_supervisor         NUMBER(11,0),
    Numero_departamento    NUMBER NOT NULL,
    constraint PK_FUNCIONARIO primary key (Cpf),
    constraint FK_FUNCIONARIO_FUNCIONARIO foreign key (Cpf_supervisor) references FUNCIONARIO ( cpf ),
    constraint FK_FUNCIONARIO_DEPARTAMENTO foreign key (Numero_departamento) references DEPARTAMENTO (Numero_Departamento),
    constraint CK_SALARIO check (Salario between 1000 and 10000 ),
    constraint CK_SEXO check (Sexo = 'F' or Sexo = 'M')
);

-- Possivel equivoco de digitação dos valores limites de salário na Lista 1, entre 1000 e 10000 não é possivel a adição de nenhum funcionário
Alter table FUNCIONARIO drop constraint CK_SALARIO;
Alter table FUNCIONARIO add constraint CK_SALARIO check (Salario between 10000 and 100000 );

--Adição da chave estrangeira de DEPARTAMENTO_FUNCIONARIO
Alter table DEPARTAMENTO add constraint FK_DEPARTAMENTO_FUNCIONARIO foreign key (CPF_gerente) references FUNCIONARIO (Cpf);


-- Criação da tabela LOCALIZACOES_DEPARTAMENTO
CREATE TABLE LOCALIZACOES_DEPARTAMENTO (
    Numero_departamento           NUMBER NOT NULL references DEPARTAMENTO (Numero_departamento) on delete cascade,
    Local_departamento            VARCHAR2(100) default 'Belo Horizonte' NOT NULL,
    constraint PK_LOCALIZACOES_DEPARTAMENTO primary key (Numero_departamento)
);

-- Vemos que a ausencia da chave primaria de Local_departamento gerou o erro de restrição exclusiva na inserção de dois dados com mesmo Numero_departamento
Alter table LOCALIZACOES_DEPARTAMENTO drop constraint PK_LOCALIZACOES_DEPARTAMENTO;
Alter table LOCALIZACOES_DEPARTAMENTO add constraint PK_LOCALIZACOES_DEPARTAMENTO primary key (Numero_departamento,Local_departamento);

-- Criação da tabela PROJETO
-- Ao tentarmos colocar como chave primaria o local do PROJETO, encontramos um problema na hora de referenciar a chave estrangeira de TRABALHA_EM
-- ERRO: ORA-02270: não há chave exclusiva ou primária compatível para esta lista de colunas
--       02270. 00000 -  "no matching unique or primary key for this column-list"
-- Sendo assim decidimos por não colocar o Local_projeto como chave primária
CREATE TABLE PROJETO (
    Nome_projeto               VARCHAR2(50) NOT NULL,
    Numero_projeto             NUMBER(2,0) NOT NULL,
    Local_projeto              VARCHAR2(100) NOT NULL,
    Numero_departamento        NUMBER NOT NULL,
    constraint PK_PROJETO primary key (Numero_projeto),
    constraint FK_PROJETO_DEPARTAMENTO foreign key (Numero_departamento) references DEPARTAMENTO (Numero_departamento)
);

-- Criação da tabela TRABALHA_EM
CREATE TABLE TRABALHA_EM (
    Cpf_do_funcionario   NUMBER(11,0) NOT NULL,
    Numero_do_projeto    NUMBER(2,0) NOT NULL,
    Horas                NUMBER(3,1),
    constraint PK_TRABALHA_EM primary key (Cpf_do_funcionario, Numero_do_projeto),
    constraint FK_TRABALHA_EM_FUNCIONARIO foreign key (Cpf_do_funcionario) references FUNCIONARIO (Cpf),
    constraint FK_TRABALHA_EM_PROJETO foreign key (Numero_do_projeto) references PROJETO (Numero_projeto)
);


-- Criação tabela DEPENDENTE
CREATE TABLE DEPENDENTE (
    Cpf_funcionario             NUMBER(11,0) NOT NULL references FUNCIONARIO (Cpf) on delete cascade, 
    Nome_dependente             VARCHAR2(30) NOT NULL,
    Sexo                        VARCHAR2(1),
    Data_nascimento             DATE NOT NULL,
    Parentesco                  VARCHAR2(30) NOT NULL,
    constraint PK_DEPENDENTE primary key (Cpf_funcionario,Nome_dependente),
    constraint CK_SEXO_DEPENDENTE check (Sexo = 'F' or Sexo = 'M'),
    constraint CK_PARENTESCO_DEPENDENTE check (Parentesco  in	 ('Filho',	 'Filha',	 'Esposa',	'Esposa'))
);

alter table DEPENDENTE drop constraint CK_PARENTESCO_DEPENDENTE;
alter table DEPENDENTE add constraint CK_PARENTESCO_DEPENDENTE check (Parentesco  in	 ('Filho',	 'Filha',	 'Marido',	'Esposa'));
