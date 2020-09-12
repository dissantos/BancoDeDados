-- 1o Exercio em Sala de Aula de Lab BD I - 2 pontos - 04/09/2020
-- Nome: Diego Santos Goncalves        
-- Matricula: 20183000330

--- 1) BD com Agencia com chave propria
-- Caso existam tabelas antiga
drop table Banco cascade constraints;
drop table Agencia cascade constraints;
drop table Conta cascade constraints;
drop table Cliente cascade constraints;

-- a)Criacao da tabela BANCO
create table BANCO (
    Codigo      number(4), 
    Nome        varchar2(50) not null,
    constraint PK_BANCO primary key (Codigo)
);

--b) criacao da tabela AGENCIA
create table AGENCIA (
    Codigo      number (4),
    Gerente     varchar2(50) not null unique,
    Cod_Banco   number(4) not null,
    constraints PK_AGENCIA primary key(Codigo),
    constraints FK_AGENCIA_BANCO foreign key (Cod_Banco) references BANCO (Codigo)
);


-- c) Criacao da tabela CONTA
create table CONTA (
    Cod_Agencia     number (4),
    Numero          number(8),
    CPF             number(11) not null,
    Saldo           number(10,2) default 0 not null,
    constraint FK_CONTA_AGENCIA foreign key (Cod_agencia) references AGENCIA(Codigo),
    constraint PK_CONTA primary key (Cod_Agencia, Numero)
);



-- 2)  BD com Agencia com chave fraca codigo da agencia. Fk faz parte da chave

-- Apagar as tabelas da questao anterior
drop table Banco cascade constraints;
drop table Agencia cascade constraints;
drop table Conta cascade constraints;

-- a)Criacao da tabela BANCO
create table BANCO (
    Codigo      number(4), 
    Nome        varchar2(30) not null,
    constraint PK_BANCO primary key (Codigo)
);


-- b) criacao da tabela AGENCIA
create table AGENCIA (
    Codigo      number (4),
    Gerente     varchar2(50) not null unique,
    Cod_Banco   number(4) not null, 
    constraint FK_AGENCIA_BANCO foreign key (Cod_Banco) references BANCO (Codigo),
    constraints PK_AGENCIA primary key(Cod_Banco, Codigo)
);

-- c) Criacao da tabela CONTA
create table CONTA (
    Cod_Banco       number(4),
    Cod_Agencia     number(4),
    Numero          number(8),
    CPF             number(11) not null,
    Saldo           number(10,2) default 0 not null,
    constraint FK_CONTA_AGENCIA foreign key (Cod_Banco,Cod_agencia) references AGENCIA(Cod_Banco,Codigo),
    constraint PK_CONTA primary key (Cod_Banco,Cod_Agencia, Numero),
    constraint CK_SALDO check (saldo>=0)
);


-- 3) Popular o banco de dados com linhas v�lidas e tentar violar a chave estrangeira de CONTA

-- Inserir dados na tabela BANCO
insert into BANCO(Codigo, Nome)
values (1,'Itau');

insert into BANCO(Codigo, Nome) 
values (4,'Caixa');

insert into BANCO(Codigo, Nome) 
values (7,'Banco do Brasil');

select * from Banco;

-- Codigo, Gerente, Cod_Banco
insert into AGENCIA(Codigo, Gerente, Cod_Banco)
values (1234,'Ana Carolina',1);

insert into AGENCIA(Codigo, Gerente, Cod_Banco)
values (3452,'Lorena',1);

insert into AGENCIA(Codigo, Gerente, Cod_Banco)
values (6667, 'Jose Antonio', 7);

insert into AGENCIA(Codigo, Gerente, Cod_Banco)
values (1357, 'Jorda', 4);

select * from Agencia;

-- inserir dados na tabela CONTA
insert into CONTA(Cod_Banco,Cod_Agencia,Numero,CPF,Saldo)
values (1,1234,55566699,48615375912,35000);

insert into CONTA(Cod_Banco,Cod_Agencia,Numero,CPF,Saldo)
values (7,6667,98732165,88855522213,10000);

insert into CONTA(Cod_Banco,Cod_Agencia,Numero,CPF,Saldo)
values (4,1357,15975324,48621357900,5600);

--tentativa de viola�ao da chave estrangeira de CONTA
insert into CONTA(Cod_Banco,Cod_Agencia,Numero,CPF,Saldo)
values(7,0000,00000002,11155599988,100000);

select * from Conta;

-- 4) Com CPF ja existentes na table CONTA, Tentar criar a seguinte tabela de CLIENTE 

-- Criacao da tabela CLIENTE
create table CLIENTE (
    CPF             number(11) not null,
    Nome            varchar2(50) not null,
    Endereco        varchar2(60) not null,
    Data_Nascimento date not null,
    constraint FK_CLIENTE_CONTA foreign key (CPF) references CONTA(CPF),
    constraint PK_CLIENTE primary key(CPF)
);

-- Como nao existe os cpfs que estao inseridos na tabela CONTA 
-- na tabela CLIENTE para relacionar na chave estrangeira dara erro


--5) Caso nao tenha sido possivel fazer a questao 4 anterior, excutar comandos DML apropriados para que a questao 4 seja atendida.

create table CLIENTE (
    CPF             number(11) not null,
    Nome            varchar2(50) not null,
    Endereco        varchar2(60) not null,
    Data_Nascimento date not null,
    constraint PK_CLIENTE primary key(CPF)
);

-- Precisa inicialmente inserir os clientes com os cpf de conta e depois adicionar a constraint
insert into CLIENTE (CPF, Nome, Endereco, Data_Nascimento)
values (48615375912,'Jo�o Lucas Silva','Rua Alagoana, 205','19/05/2000');

insert into CLIENTE (CPF, Nome, Endereco, Data_Nascimento)
values (88855522213,'Roberta Sanches','Avenida Alburqueque, 3520','17/12/1985');

insert into CLIENTE (CPF, Nome, Endereco, Data_Nascimento)
values (48621357900,'Clodovil da Silva','Rua dos Papas, 1009','12/09/1996');

alter table CONTA add constraint FK_CONTA_CLIENTE foreign key(CPF) references CLIENTE(CPF);

select * from Cliente;


