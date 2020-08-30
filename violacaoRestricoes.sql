-- 2) Violacao das restricoes

-- Restricao de dominio
insert into 
    dependente(fcpf,nome_dependente,sexo,datanasc,parentesco)
values 
    (98765432168,'Andreia', 'M', '09 de maio de 1989', 'Filha');

-- Restricao de chave
insert into 
    projeto (projnome,projnumero,projlocal,dnum)
values  
   ('ProjetoA',1,'São Paulo',5);

-- Restricao de valores não nulo
insert into 
    funcionario (pnome,minicial,unome,cpf,datanasc,endereco,sexo,salario,cpf_supervisor,dnr)
values 
    (NULL,'G','Santos',12345666966,Date '1967-02-03','Rua Aldimiro Batista, 800, São Paulo, SP','M',35000,33344555587,5);

-- Restricao de entidade
insert into 
    departamento(dnome,dnumero,cpf_gerente,data_inicio_gerente)
values
    ('TI',NULL,99988777767,Date '1990-02-25');

-- Restricao de integridade referencial
delete from 
    funcionario
where 
    dnr = 5;

update 
    departamento
set 
    dnumero = 9
where 
    dnumero = 1; 


