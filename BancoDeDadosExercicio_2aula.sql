create table Banco (
    Codigo number(4) primary key,
    Nome varchar2(50)
);

alter table Banco
modify Nome varchar2(50) not null;

select * from banco;

create table Agencia (
    Cod_banco number(4),
    Codigo number(4),
    Gerente varchar2(50),
    constraint FK_AGENCIA_BANCO foreign key (Cod_banco) references Banco (Codigo),
    constraint PK_AGENCIA primary key (Codigo,Cod_banco)
);

alter table Agencia
modify Gerente varchar2(50) unique;


create table Conta(
    Cod_banco number(4),
    Cod_agencia number(4),
    Numero number(8),
    CPF number(11),
    Saldo number(10,2),
    constraint FK_CONTA_AGENCIA foreign key (Cod_banco,Cod_agencia) references Agencia(Cod_banco, Codigo),
    constraint PK_CONTA primary key(Cod_banco,Cod_agencia,Numero),
    constraint CK_SALDo check (saldo>=0)
);

alter table Conta
modify Saldo number(10,2) default 0 not null;

alter table Conta
modify CPF number(11) not null;

