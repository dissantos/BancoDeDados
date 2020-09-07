<h3>Lista 1</h3>
<p><b>Nome</b>: Diego Santos Gonçalves                 <b>Matricula</b>: 20183012537 </p>
<p><b>Nome</b>: Mariana Bulgarelli Alves dos Santos    <b>Matricula</b>: 20183000330 </p>
                                   

<b>Questao 1</b> Criação das tabelas

```sql
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
    Primeiro_nome          VARCHAR2(30) NOT NULL,
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
    constraint CK_PARENTESCO_DEPENDENTE check (Parentesco  in	 ('Filho',	 'Filha',	 'Esposa',	'Esposa')));


alter table DEPENDENTE drop constraint CK_PARENTESCO_DEPENDENTE;
alter table DEPENDENTE add constraint CK_PARENTESCO_DEPENDENTE check (Parentesco in ('Filho','Filha','Marido' ,'Esposa'));
```
<b>Questão 2</b> Inserção de dados na tabela criada da questão anterior

```sql
-- Inserir departamento com cpf do gerente nulos
insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('Pesquisa', 5, Null, Date '1988-05-22');

insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('Administracao', 4, Null, Date '1995-01-01');

insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('Matriz', 1, Null, Date '1981-06-19');

-- Inserir funcionários por ordem hierárquica
insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Jorge','E','Brito',88866555576,Date '1937-11-10','Rua do Horto, 35, Sao Paulo, SP','M',55000,NULL,1);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Jennifer','S','Souza',98765432168,Date '1941-06-20','Av. Arthur de Lima, 54, Santo Andre, SP','F',43000,88866555576,4);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Fernando','T','Wong',33344555587,Date '1955-12-08','Rua da Lapa, 34, Sao Paulo, SP','M',40000,88866555576,5);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Alice','J','Zelaya',99988777767,Date '1968-01-19','Rua Souza Lima, 35, Curitiba, PR','F',25000,98765432168,4);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Andre','V','Pereira',98798798733,Date '1969-03-29','Rua Timbira, 35, Sao Paulo, SP','M',25000,98765432168,4);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Joao','B','Silva',12345678966,Date '1965-01-09','Rua das Flores, 751, Sao Paulo, SP','M',30000,33344555587,5);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Ronaldo','K','Lima',66688444476,Date '1962-09-15','Rua Reboucas, 65, Piracicaba, SP','M',38000,33344555587,5);

insert into Funcionario (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento)
values ('Joice','A','Leite',45345345376,Date '1972-07-31','Av. Lucas Obes, 74, Sao Paulo, SP','F',25000,33344555587,5);


-- Atualiza os cpf dos gerentes nos dados do Departamento agora que os funcionarios foram inseridos
update DEPARTAMENTO set  Cpf_gerente = 33344555587
where Numero_departamento = 5;

update DEPARTAMENTO set  Cpf_gerente = 98765432168
where Numero_departamento = 4;

update DEPARTAMENTO set  Cpf_gerente = 88866555576
where Numero_departamento = 1;

-- Inserção dos dados da tabela LOCALIZACOES_DEPARTAMENTO
insert into LOCALIZACOES_DEPARTAMENTO(Numero_departamento, Local_departamento)
values (1, 'Sao Paulo');

insert into LOCALIZACOES_DEPARTAMENTO(Numero_departamento, Local_departamento)
values (4, 'Maua');

insert into LOCALIZACOES_DEPARTAMENTO(Numero_departamento, Local_departamento)
values (5, 'Santo Andre');
    
insert into LOCALIZACOES_DEPARTAMENTO(Numero_departamento, Local_departamento)
values (5, 'Itu');

insert into LOCALIZACOES_DEPARTAMENTO(Numero_departamento, Local_departamento)
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
insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (12345678966, 1, 32.5);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (12345678966, 2, 7.5);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (66688444476, 3, 40.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (45345345376, 1, 20.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (45345345376, 2, 20.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (33344555587, 2, 10.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (33344555587, 3, 10.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (33344555587, 10, 10.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (33344555587, 20, 10.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (99988777767, 30, 30.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (99988777767, 10, 10.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (98798798733, 10, 35.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (98798798733, 30, 5.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (98765432168, 30, 20.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (98765432168, 20, 15.0);

insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (88866555576, 20, NULL);


-- Inserção de dados na tabela dependente 

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values (33344555587, 'Alicia', 'F', Date '1986-04-05', 'Filha');

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values (33344555587, 'Tiago', 'M', Date '1983-10-25', 'Filho');

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values (33344555587, 'Janaina', 'F',Date '1958-05-03', 'Esposa');

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values (98765432168, 'Antonio', 'M',Date '1942-02-28', 'Marido');

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values (12345678966, 'Michael', 'M',Date '1988-01-04', 'Filho');

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values (12345678966, 'Alicia', 'F', Date '1988-12-30', 'Filha');

insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values (12345678966, 'Elizabeth', 'F',Date '1967-05-05', 'Esposa');


-- Tentantivas de violacao

-- Violacao da restrição de dominio
insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values (33344555587, 'Roberto', 'N', Date '1986-04-05', 'Filho');

-- Violacao da restrição de chave
insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('RH', 5, Null, Date '2000-05-05');

-- Violacao da restrição de	entidade
insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('Engenharia', Null, 77788866632, Date '1988-05-22');

-- Violacao da restrição de	não	nulo
insert into PROJETO (Nome_projeto, Numero_projeto, Local_projeto, Numero_departamento)
values (Null, 6, 'Santo Andre', 5);

-- Violacao da restrição de integridade referencial
insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (12345678966, 6, 44);

```