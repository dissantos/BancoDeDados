-- Lista 1
-- Nome: Diego Santos Gon�alves                 Matricula: 20183012537
--       Mariana Bulgarelli Alves dos Santos               20183000330

-- 2) Inser��o de dados na tabela criada da quest�o anterior

-- Inserir departamento com cpf do gerente nulos
insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('Pesquisa', 5, Null, Date '1988-05-22');

insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('Administracao', 4, Null, Date '1995-01-01');

insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('Matriz', 1, Null, Date '1981-06-19');

-- Inserir funcion�rios por ordem hier�rquica
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

-- Inser��o dos dados da tabela LOCALIZACOES_DEPARTAMENTO
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


-- Inser��o de dados na tabela PROJETO
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


-- Inser��o de dados na tabela TRABALHA_EM
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


-- Inser��o de dados na tabela dependente 

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

-- Violacao da restri��o de dominio
insert into DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco)
values (33344555587, 'Roberto', 'N', Date '1986-04-05', 'Filho');

-- Violacao da restri��o de chave
insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('RH', 5, Null, Date '2000-05-05');

-- Violacao da restri��o de	entidade
insert into DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente)
values ('Engenharia', Null, 77788866632, Date '1988-05-22');

-- Violacao da restri��o de	n�o	nulo
insert into PROJETO (Nome_projeto, Numero_projeto, Local_projeto, Numero_departamento)
values (Null, 6, 'Santo Andre', 5);

-- Violacao da restri��o de integridade referencial
insert into trabalha_em (Cpf_do_funcionario, Numero_do_projeto, Horas)
values (12345678966, 6, 44);

    

                                                                    






