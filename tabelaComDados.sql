-- 2) Criacao da tabela e insercao dos dados

CREATE TABLE departamento (
    dnome                VARCHAR(100) NOT NULL,
    dnumero              NUMERIC NOT NULL,
    cpf_gerente          NUMERIC(11,0) NOT NULL,
    data_inicio_gerente  DATE NOT NULL
);

ALTER TABLE departamento ADD CONSTRAINT departamento_pk PRIMARY KEY ( dnumero );

CREATE TABLE dependente (
    fcpf             NUMERIC(11,0) NOT NULL,
    nome_dependente  VARCHAR(30) NOT NULL,
    sexo             VARCHAR(1),
    datanasc         DATE NOT NULL,
    parentesco       VARCHAR(30) NOT NULL
);

ALTER TABLE dependente ADD CONSTRAINT dependente_pk PRIMARY KEY ( fcpf,
                                                                  nome_dependente );
																
insert into
    dependente (fcpf, nome_dependente, sexo, datanasc, parentesco)
values
    (33344555587, 'Alicia', 'F', Date '1986-04-05', 'Filha'),
    (33344555587, 'Tiago', 'M', Date '1983-10-25', 'Filho'),
    (33344555587, 'Janaína', 'F', '1958-05-03', 'Esposa'),
    (98765432168, 'Antonio', 'M',Date '1942-02-28', 'Marido'),
    (12345678966, 'Michael', 'M',Date '1988-01-04', 'Filho'),
    (12345678966, 'Alicia', 'F', Date '1988-12-30', 'Filha'),
    (12345678966, 'Elizabeth', 'F',Date '1967-05-05', 'Esposa');

insert into
    departamento (dnome, dnumero, cpf_gerente, data_inicio_gerente)
values
    ('Pesquisa', 5, 33344555587, Date '1988-05-22'),
    ('Administração', 4, 98765432168, Date '1995-01-01'),
    ('Matriz', 1, 88866555576, Date '1981-06-19');
   
CREATE TABLE funcionario (
    pnome           VARCHAR(30) NOT NULL,
    minicial        VARCHAR(30),
    unome           VARCHAR(30) NOT NULL,
    cpf             NUMERIC(11,0) NOT NULL,
    datanasc        DATE NOT NULL,
    endereco        VARCHAR(200) NOT NULL,
    sexo            VARCHAR(1),
    salario         NUMERIC(5,0) NOT NULL,
    cpf_supervisor  NUMERIC(11,0),
    dnr             NUMERIC NOT NULL
);

ALTER TABLE funcionario ADD CONSTRAINT funcionario_pk PRIMARY KEY ( cpf );   
    
insert into 
    Funcionario (pnome,minicial,unome,cpf,datanasc,endereco,sexo,salario,cpf_supervisor,dnr)
values
    ('Joao','B','Silva',12345678966,Date '1965-01-09','Rua das Flores, 751, São Paulo, SP','M',30000,33344555587,5),
    ('Fernando','T','Wong',33344555587,Date '1955-12-08','Rua da Lapa, 34, São Paulo, SP','M',40000,88866555576,5),
    ('Alice','J','Zelaya',99988777767,Date '1968-01-19','Rua Souza Lima, 35, Curitiba, PR','F',25000,98765432168,4),
    ('Jennifer','S','Souza',98765432168,Date '1941-06-20','Av. Arthur de Lima, 54, Santo André, SP','F',43000,88866555576,4),
    ('Ronaldo','K','Lima',66688444476,Date '1962-09-15','Rua Rebouças, 65, Piracicaba, SP','M',38000,33344555587,5),
    ('Joice','A','Leite',45345345376,Date '1972-07-31','Av. Lucas Obes, 74, São Paulo, SP','F',25000,33344555587,5),
    ('André','V','Pereira',98798798733,Date '1969-03-29','Rua Timbira, 35, São Paulo, SP','M',25000,98765432168,4),
    ('Jorge','E','Brito',88866555576,Date '1937-11-10','Rua do Horto, 35, São Paulo, SP','M',55000,NULL,1);

CREATE TABLE localizacao_dep (
    dnumero  NUMERIC NOT NULL,
    dlocal   VARCHAR(100) NOT NULL
);

ALTER TABLE localizacao_dep ADD CONSTRAINT localizacao_dep_pk PRIMARY KEY ( dnumero,
                                                                            dlocal );

insert into
    Localizacao_Dep(dnumero, dlocal)
values
    (1, 'São Paulo'),
    (4, 'Maua'),
    (5, 'Santo André'),
    (5, 'Itu'),
    (5, 'São Paulo');
    
CREATE TABLE projeto (
    projnome    VARCHAR(50) NOT NULL,
    projnumero  NUMERIC(2,0) NOT NULL,
    projlocal   VARCHAR(100) NOT NULL,
    dnum        NUMERIC NOT NULL
);

ALTER TABLE projeto ADD CONSTRAINT projeto_pk PRIMARY KEY ( projnumero );

insert into
    Projeto (projnome, projnumero, projlocal, dnum)
values
    ('ProdutoX', 1, 'Santo André', 5),
    ('ProdutoY', 2, 'Itu', 5),
    ('ProdutoZ', 3, 'São Paulo', 5),
    ('Informatização', 10, 'Mauá', 4),
    ('Reorganização', 20, 'São Paulo', 1),
    ('Novosbenefícios', 30, 'Mauá', 4);
    

CREATE TABLE trabalha_em (
    fcpf   NUMERIC(11,0) NOT NULL,
    pnr    NUMERIC(2,0) NOT NULL,
    horas  NUMERIC(3,1)
);

ALTER TABLE trabalha_em ADD CONSTRAINT trabalha_em_pk PRIMARY KEY ( fcpf,
                                                                    pnr );
                                                                    
insert into
    trabalha_em (fcpf, pnr, horas)
values
    (12345678966, 1, 32.5),
    (12345678966, 2, 7.5),
    (66688444476, 3, 40.0),
    (45345345376, 1, 20.0),
    (45345345376, 2, 20.0),
    (33344555587, 2, 10.0),
    (33344555587, 3, 10.0),
    (33344555587, 10, 10.0),
    (33344555587, 20, 10.0),
    (99988777767, 30, 30.0),
    (99988777767, 10, 10.0),
    (98798798733, 10, 35.0),
    (98798798733, 30, 5.0),
    (98765432168, 30, 20.0),
    (98765432168, 20, 15.0),
    (88866555576, 20, NULL);

ALTER TABLE departamento
    ADD CONSTRAINT departamento_funcionario_fk FOREIGN KEY ( cpf_gerente )
        REFERENCES funcionario ( cpf );

ALTER TABLE dependente
    ADD CONSTRAINT dependente_funcionario_fk FOREIGN KEY ( fcpf )
        REFERENCES funcionario ( cpf );

ALTER TABLE funcionario
    ADD CONSTRAINT funcionario_departamento_fk FOREIGN KEY ( dnr )
        REFERENCES departamento ( dnumero );

ALTER TABLE funcionario
    ADD CONSTRAINT funcionario_funcionario_fk FOREIGN KEY ( cpf_supervisor )
        REFERENCES funcionario ( cpf );

ALTER TABLE localizacao_dep
    ADD CONSTRAINT localizacao_dep_dep_fk FOREIGN KEY ( dnumero )
        REFERENCES departamento ( dnumero );

ALTER TABLE projeto
    ADD CONSTRAINT projeto_departamento_fk FOREIGN KEY ( dnum )
        REFERENCES departamento ( dnumero );

ALTER TABLE trabalha_em
    ADD CONSTRAINT trabalha_em_funcionario_fk FOREIGN KEY ( fcpf )
        REFERENCES funcionario ( cpf );

ALTER TABLE trabalha_em
    ADD CONSTRAINT trabalha_em_projeto_fk FOREIGN KEY ( pnr )
        REFERENCES projeto ( projnumero );
        



