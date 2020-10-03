-- 1) 
select department_name 
from PROFESSOR.departments
where department_id not in 
    (select e.department_id 
    from PROFESSOR.employees e 
    where e.department_id is not NULL);
     
--2) 
select d.department_name,d.department_id 
from PROFESSOR.departments d
where not exists 
    (select distinct * 
    from PROFESSOR.employees e 
    where d.department_id = e.department_id);
    
--3) 
select concat(concat(e.First_name,' '),e.Last_name) as Nome_completo, 
d.department_name as Department_name 
from PROFESSOR.departments d join PROFESSOR.employees e
on d.department_id = e.department_id;

--4)
select concat(concat(e.First_name,' '),e.Last_name) as Nome_completo, 
d.department_name as Department_name 
from PROFESSOR.departments d right outer join PROFESSOR.employees e
on d.department_id = e.department_id;

--5) 
select concat(concat(e.First_name,' '),e.Last_name) as Nome_completo, 
d.department_name as Department_name 
from PROFESSOR.employees e left outer join PROFESSOR.departments d
on d.department_id = e.department_id;

--6)
select e.first_name, e.last_name, jh.job_id, jh.start_date, jh.end_date
from PROFESSOR.employees e left outer join PROFESSOR.job_history jh
on e.employee_id = jh.employee_id;

--7) 
select e.first_name, e.last_name, jh.job_id, jh.start_date, jh.end_date,j.job_title
from (PROFESSOR.employees e left outer join PROFESSOR.job_history jh
on e.employee_id = jh.employee_id) left outer join PROFESSOR.jobs j 
on j.job_id = jh.job_id;

--8) 
select j.job_title 
from PROFESSOR.jobs j
where j.job_id in (select distinct e.job_id 
    from PROFESSOR.employees e 
    where e.department_id in (select d.department_id 
        from PROFESSOR.departments d
        where d.location_id in (select l.location_id 
            from professor.locations l
            where l.city = 'Seattle')));
            
--9)
select distinct j.job_title 
from (((PROFESSOR.jobs j inner join PROFESSOR.employees e 
    on e.job_id = j.job_id) inner join PROFESSOR.departments d
        on d.department_id = e.department_id) inner join PROFESSOR.locations l
            on l.location_id = d.location_id)
where l.city = 'Seattle';

