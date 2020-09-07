```sql
--1)
select first_name, last_name, hire_date 
from PROFESSOR.employees e 
where e.last_name like 'R%';

--2)
select concat(concat(last_name,' '),first_name)as Nome_Completo 
from  PROFESSOR.employees e 
where e.department_id = 60;

--3)
select upper(d.department_name) as Department_Name 
from PROFESSOR.departments d 
where d.department_id = 60;

--4)
select concat(concat(first_name,' '),last_name)as Nome_Completo 
from PROFESSOR.employees e 
where extract(year from e.hire_date)=1999;

--5)
select first_name, last_name, salary*12 as Annual_salary 
from PROFESSOR.employees 
where salary >= 4000 and salary <= 7000;

--6)
select concat(concat(first_name,' '),last_name)as Nome_Completo 
from PROFESSOR.employees emp, PROFESSOR.departments dep
where emp.department_id = dep.department_id and dep.department_name = 'Shipping'; 
    
--7)
select concat(concat(first_name,' '),last_name)as Nome_Completo 
from PROFESSOR.employees emp, PROFESSOR.departments dep
where emp.department_id = dep.department_id and dep.department_name = 'Shipping' and
    emp.salary >= 5000 and emp.salary <= 8000 and
    emp.hire_date between '01/01/97' and '31/12/99'; 

--8)
select * from PROFESSOR.employees e 
where e.manager_id = (select e2.employee_id 
    from PROFESSOR.employees e2 
    where e2.first_name = 'Steven' and e2.last_name = 'King');









--9)
select concat(concat(emp.first_name,' '),emp.last_name)as Nome_Completo, 
    country.country_name
from PROFESSOR.employees emp, PROFESSOR.departments dep, 
    PROFESSOR.locations loc, PROFESSOR.countries country 
where emp.department_id = dep.department_id and 
    dep.location_id = loc.location_id and 
    loc.country_id = country.country_id ;

--10)
select 
    concat(concat(first_name,' '),last_name)as Nome_Completo, 
    dep.department_name as Department_name, 
    loc.city as City, country.country_name as Country_name, 
    reg.region_name as Region_name
from 
    PROFESSOR.employees emp, 
    PROFESSOR.departments dep, 
    PROFESSOR.locations loc,
    PROFESSOR.countries country, 
    PROFESSOR.regions reg
where emp.department_id = dep.department_id and 
    dep.department_name = 'Shipping' and
    emp.salary >= 2000 and
    emp.hire_date between '01/01/99' and '31/12/05' and
    dep.location_id = loc.location_id and
    loc.country_id = country.country_id and
    reg.region_id = country.region_id; 

```