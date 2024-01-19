use db_hr;

-- 1. EMPLOYEES taulatik abiatuta, erakutsi “Sales” departamentuko lanpostu bakoitzeko 

select job_title, sum(salary)
from jobs J inner join employees e
	on j.job_id = e.job_id
inner join departments d
	using (department_id)
where department_name LIKE "Sales"
group by job_title;

select job_title, sum(salary), department_name
from jobs J inner join employees e
	on j.job_id = e.job_id
inner join departments d
	using (department_id)
group by job_title, department_name;


-- 2. Erakutsi EMPLOYEES taulako langileen izen abizenak baldin eta euren soldata, departamentuko bataz-besteko soldataren berdina bada.

select concat(first_name, " ", last_name) as Employee, salary, department_name
from employees E inner join departments D using (department_id)
where (salary, department_id) IN (

select avg(salary), department_id 
from employees 
group by department_id);

-- 3. Erakutsi EMPLOYEES taulako langileen izen abizenak baldin eta euren soldata,
-- departamentuko bataz-besteko soldata baino handiagoa bada.

-- 4. EMPLOYEES taulatik abiatuta erakutsi departamentu bakoitzean dagoen langile kopurua. 

select department_id, count(employee_id)
from employees
group by department_id
order by 1 desc;

select department_id, count(*)
from employees
group by department_id
order by 1 desc;

-- 5. EMPLOYEES taulatik abiatua erakutsi zein departamentuk duen langile gehien.

select department_id, count(*)
from employees
group by department_id
order by count(*) desc
limit 1;

-- 6. Erakutsi zeintzuk departamentuk dute langile bi baino gehiago lanpostu berean lanean

select department_id, count(*)
from employees
group by department_id
having count(*) > 2
order by count(*);



