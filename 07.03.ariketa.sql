-- 1) Idatzi SQL agindua, 163 kodea duen langileak baino soldata handiagoa duten langileen izen abizenak erakusteko.

select first_name, last_name, salary
from employees
where salary < (SELECT salary FROM employees WHERE employee_id = 163);

-- 2) Idatzi SQL agindua, 169 kodea duen langilearen departamentu berean lan egiten duten langileen izen abizenak, soldata, departamentu id-ea eta lan id-ea erakusteko.

select first_name, last_name, department_id, salary, job_id
from employees
where department_id = (SELECT department_id FROM employees WHERE employee_id = 169);

-- 3) Idatzi SQL agindua, Payam managerraren agindupean dauden langileen izen abizenak, langile kodea eta soldata erakusteko.

select first_name, last_name, employee_id, salary
from employees
where manager_id = (select employee_id from employees where first_name LIKE "Payam");


-- 4) Idatzi SQL agindua, Finance sailean lan egiten duten langile guztien izen abizenak erakusteko.

select first_name, last_name
from employees
where department_id = (select department_id from departments where department_name LIKE "Finance");

-- 5) Idatzi SQL agindua, 134, 159 edo 183 departamentuetan lan egiten duten langileen datuak erakusteko.

select *
from employees
where department_id IN (70, 80, 90);

-- 6) Idatzi SQL agindua, 100. eta 200. Bitartean kodea duen managerrek lan egiten duten departamentuetatik kanpo lan egiten duten langileen datu guztiak erakutsi.

select *
 from employees
 where department_id not in (select department_id from departments where department_id between 20 and 90);

-- 7) Idatzi SQL agindua, T letra izenean duten langileen departamentuetan lan egiten duten langile guztien zerrenda erakutsi (id-ea eta izen abizenak).

select employee_id, first_name, last_name
from employees
where department_id in (select department_id from employees where first_name LIKE "%T%");

-- 8) Idatzi SQL aginuda: Toronton lan egiten duten langile guztien izena eta abizena, langilearen identifikazioa eta kargua erakutsi.

select employee_id, first_name, last_name
from employees
where department_id in (select department_id from departments where location_id = (select location_id from locations where city  LIKE "Toronto"));

-- 9) Idatzi SQL agindua, Ozer jaunak baino gehiago nork irabazten duen zehazteko.



-- 10) Idatzi SQL agindua, sail bat kudeatzen duten langileen xehetasunak lortzeko.


