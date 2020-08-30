create table BANCO (
Codigo number(4) primary key, -- restrição de chave
Nome varchar2(30) not null); -- restrição de não nulidade

select * from Banco;

-- Teste da restrição de chave (PK)
insert into banco values (1,'Banco Principal');

-- tentativa de incluir null em nome
insert into banco values (2,null);

-- tentativa de duplicidade de chave
insert into banco values (1,'Banco Senior');

create table AGENCIA (
Codigo number (4) constraint PK_AGENCIA primary key,
Gerente varchar2(50) not null unique,
Cod_Banco number(4) not null references BANCO (Codigo) -- RIR
-- restrição de integridade referencial (RIR) - na remoção: bloqueio
-- se o comportamento é de propagação da remoção, então a RIR deve ser:
-- Cod_Banco number(4) not null references BANCO (Codigo) on
-- delete cascade. Se banco for removido, suas agências também são
);

-- Chave
insert into AGENCIA values (1,'Ana Maria',1);
select * from AGENCIA;

insert into AGENCIA values (1,'Ana Maria',1);

insert into AGENCIA values (2,'Jose Antonio',null);

-- Unicidade da coluna Gerente
insert into AGENCIA values (2,'Ana Maria',1);-- não aceito pois Ana já é gerente

insert into AGENCIA values (2,'Jose Antonio',1); -- nao inserção: gerente único

create table CONTA (
Cod_Agencia number (4),
Numero number(8),
CPF varchar2(50) not null,
Saldo number(10,2) default 0 not null,
constraint FK_CONTA_AGENCIA foreign key (Cod_agencia)
references AGENCIA(Codigo),
constraint PK_CONTA primary key (Cod_Agencia, Numero),
constraint CK_SALDO check (saldo >=0 ));

select * from conta;

-- Teste da restricão de check
insert into conta values (1,1000,'222222222',-20); -- Tupla não aceita: saldo negativo
insert into conta values (1,1000,'222222222',0);
select * from conta;