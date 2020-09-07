drop table banco cascade constraints;

create table BANCO (
Codigo number(4) primary key, -- restrição de chave
Nome varchar2(30) not null); -- restrição de não nulidade
-- DML

insert into banco values (1,'Banco Principal');
insert into banco values (2,'Banco Senior');

select * from banco;

drop table agencia cascade constraints;

create table AGENCIA (
Cod_Banco number(4) not null references BANCO (Codigo), -- RIR
Codigo number (4) constraint PK_AGENCIA primary key,
Gerente varchar2(50) not null unique
);

insert into AGENCIA values (1,1,'Ana Maria');
insert into AGENCIA values (1,2,'Jose Antonio');

select * from Agencia;

drop table conta cascade constraints;

create table CONTA (
Cod_Agencia number (4) ,
Numero number(8) ,
CPF varchar2(50) not null,
Saldo number(10,2) default 0 not null,
constraint FK_CONTA_AGENCIA foreign key (Cod_agencia)
references AGENCIA(Codigo),
constraint PK_CONTA primary key (Cod_Agencia, Numero),
constraint CK_SALDO_CONTA check (saldo >=0));

insert into conta values (1,1000,'111111111',1000); -- Tupla não aceita: saldo nega.

insert into conta values (1,2000,'222222222',2000);
select * from conta;

-- 1) remove a table conta e depois a tabela agencia
drop table conta;
drop table agencia;

-- 2) Recriando a table AGENCIA com a chave primária composta
create table AGENCIA (
Cod_Banco number(4) not null references BANCO (Codigo), -- RIR
Codigo number (4),
Gerente varchar2(50) not null unique,
constraint PK_AGENCIA primary key (Cod_Banco, Codigo)
);


insert into AGENCIA values (1,1,'Ana Maria');
insert into AGENCIA values (1,2,'Jose Antonio');

-- Agora, é possível inserir um código de agência já existente, desde
-- que em outro banco.

insert into AGENCIA values (2,1,'Ana Cláudia');

select * from AGENCIA;

create table CONTA (
Cod_Banco number (4),
Cod_Agencia number (4) ,
Numero number(8) ,
CPF varchar2(50) not null,
Saldo number(10,2) default 0 not null,
constraint FK_CONTA_AGENCIA foreign key (Cod_Banco, Cod_agencia)
references AGENCIA(Cod_Banco, Codigo),
constraint PK_CONTA primary key (Cod_Banco, Cod_Agencia, Numero),
constraint CK_SALDO_CONTA check (saldo >=0));

select * from agencia order by 1, 2;

insert into conta values (2,1,1000,'111111111',1000);
select * from CONTA;

insert into conta values (1,2,2000,'222222222',2000);
select * from CONTA;

-- o comando insert seguinte não será aceito, pois não existe a linha 2,2 em agencia,
-- sendo esse par: cod_banco e cod_agencia
insert into conta values (2,2,3000,'333333333',3000);
select * from AGENCIA;

insert into conta values (2,1,2000,'222222222',1000);

select * from CONTA;

create table CLIENTE (
CPF varchar2(50) constraint PK_CPF primary key,
Nome varchar2(50) constraint NN_NOME_CLIENTE not null,
Endereco varchar2(50) constraint NN_ENDERECO_CLIENTE not null,
Data_Nascimento date constraint NN_DATANASCIMENTO_CLIENTE not null);

-- Não será possível estabelecer a FK seguinte, pois não clientes (1111.., 222...) em CLIENTE
alter table CONTA add constraint FK_CONTA_CLIENTE foreign key (CPF) references CLIENTE(CPF);

-- Para resolver: inserir linhas em CLIENTES para que a FK nova possa
-- referenciá-las
insert into cliente values ('111111111','Antonio José Silva','Rua A, 1','01/01/2000');
insert into cliente values ('222222222','Maria José Silva','Rua B, 2','02/02/2002');

alter table CONTA add constraint FK_CONTA_CLIENTE foreign key (CPF) references CLIENTE(CPF);

insert into conta values (1,2,3000,'333333333',3000);

-- para resolver
insert into cliente values ('333333333','Paulo José Silva','Rua C, 3','03/03/2003');
insert into conta values (1,2,3000,'333333333',3000);