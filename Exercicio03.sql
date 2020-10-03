-- EXERCICIO 3
-- Nome:    Diego Santos Gon�alves                          matr�cula:  2018
--          Mariana Bulgarelli Alves dos Santos                         20183000330


--1) Apresente o nome e o m�s, por extenso, de admiss�o de todos os empregados que
-- come�am com a letra �R� no �ltimo nome. N�o utilize LIKE, mas fun��es SQL.
select first_name ||' '||last_name "Nome Completo", to_char(hire_date,'Month') DataAdmissao
from employees
where substr(upper(last_name),1,1)='R';


--2) Apresente o �ltimo nome concatenado com o primeiro nome, mas separados por branco,
--de todos os empregados que trabalham no departamento de nome �executive� (em
--min�sculas). Em mai�sculas, o nome do departamento deve aparecer no resultado. Utilize
--fun��es SQL e jun��es.
select (concat(concat(last_name,' '),first_name))as "Nome Completo", upper(department_name) as "Departamento"
from employees e join departments d
on e.department_id = d.department_id
where lower(department_name) = 'executive';


--3) Apresente o nome completo de todos os empregados que foram admitidos no ano de 1999.
--Use a coluna HIRE_DATE com fun��es de data.
select concat(concat(first_name,' '),last_name) as "Nome Completo"
from professor.employees
where extract(year from hire_date)=1999;


--4) Apresente o nome, o salario di�rio, arredondado, e o anual de todos os empregados. O
--sal�rio em EMPLOYEES � mensal.
select first_name "Nome", round(salary/30) "Salario Diario Arredondado", salary*12 "Salario Anual"
from employees;


--5) Apresente somente a inicial de cada nome de empregados que s�o gerentes de
--departamento. Incluir o nome do departamento.
select concat(concat(substr(first_name,1,1),'. '),substr(last_name,1,1)) as "Nome Abreviado", department_name "Departamento"
from employees e, departments d
where e.employee_id = d.manager_id;


--6) Apresente a m�dia salarial por departamento, incluindo o nome do departamento.
select department_name as "Departamento", round(avg(salary)) as "Media Salarial"
from employees e join departments d
on e.department_id = d.department_id
group by department_name;


--7) Apresente a quantidade de empregados por departamento. O departamento deve aparecer.
SELECT department_name as "Nome do Departamento", count(employee_id) as "Numero de Empregados"
from employees e join departments d
on e.department_id = d.department_id
group by department_name;

