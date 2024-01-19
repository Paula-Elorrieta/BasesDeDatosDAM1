-- PAULA FRAGA PINTA

-- 1. Idatzi kontsulta bat SQLn, langile bakoitzaren izena, abizena, sailaren zenbakia eta sailaren izena erakusteko.

select first_name, last_name, departments.department_id, departments.department_name
from employees
INNER JOIN departments on employees.department_id = departments.department_id;

-- 2. Idatzi kontsulta bat SQLn, langile bakoitzaren izen-deiturak, saila, hiria eta probintzia erakusteko.

select first_name, last_name, department_name, city, state_province
from employees INNER JOIN departments 
	on employees.department_id = departments.department_id
	INNER JOIN locations
    on departments.location_id = locations.location_id;

select E.first_name, E.last_name, D.department_id, D.department_name, L.city, L.state_province
from employees E INNER JOIN departments D
	on E.department_id = D.department_id
	INNER JOIN locations L
    on D.location_id = L.location_id;
    
-- 3. Idatzi kontsulta bat SQLn, langile guztien izena, abizena eta soldata erakusteko.

select first_name, last_name, salary
from employees;

-- 4. Idatzi kontsulta bat SQLn, izena, abizena, sailaren zenbakia eta sailaren izena bistaratzeko, 80 edo 40 sailetako enplegatu guztientzat.

select E.first_name, E.last_name, D.department_id, D.department_name
from employees E INNER JOIN departments D
	on E.department_id = D.department_id
where D.department_id IN (40, 80);

-- 5. Idatzi kontsulta bat SQLn, euren izenean z letra duten langileak erakusteko eta euren abizena, saila, hiria eta estatuko probintzia erakusteko.

select E.first_name, E.last_name, D.department_id, D.department_name, L.city, L.state_province
from employees E INNER JOIN departments D
	on E.department_id = D.department_id
	INNER JOIN locations L
    on D.location_id = L.location_id
where first_name LIKE "%Z%";

-- 6. Idatzi kontsulta bat SQLn, langilerik ez duten sailak erakusteko.

select first_name, department_id
from employees
where department_id IS NULL;

-- 7. Idatzi kontsulta bat SQLn, 182 zenbakia duen enplegatuak irabazten duena baino gutxiago irabazten duten langileen izen-deiturak eta soldata erakusteko.
-- ganan menos de lo que gana el empleado número 182.

select first_name, last_name, salary, employee_id
from employees
where salary < (SELECT salary FROM employees WHERE employee_id = 182);

select E2.first_name, E2.last_name, E2.salary, E2.employee_id
from employees E1 INNER JOIN employees E2 
	on E1.salary > E2.salary
where E1.employee_id = 182;

-- 8. Idatzi kontsulta bat SQLn, langile guztien izena eta kudeatzailearen izena (manager) erakusteko.

select concat(E1.first_name, " ", E1.last_name) as LANGILEA , concat(M.first_name, " ", M.last_name) as MANAGER 
from employees E1 INNER JOIN employees M
	on E1.manager_id = M.employee_id;

-- 12. Idatzi kontsulta bat SQLn, Taylor abizena duen langilearen departamentu berean lan egiten duten langileen izena, abizena eta sailaren zenbakia bistaratzeko

select E1.first_name, E1.last_name, D.department_name
from employees E1 INNER JOIN employees E2
	on E1.department_id = E2.department_id
    inner join departments D
    on E2.department_id = D.department_id
where E2.last_name = "Taylor";

select E1.first_name, E1.last_name, D.department_name
from employees E1 INNER JOIN employees E2
	using (department_id)
    inner join departments D
    using (department_id)
where E2.last_name = "Taylor";

-- 14. Idatzi kontsulta bat SQLn, lanpostua, langilearen izen osoa (izena eta abizena) eta laneko gehieneko soldataren eta langilearen soldataren arteko aldea erakusteko.

select E.first_name, E.last_name, salary, J.job_title, J.max_salary, J.max_salary - E.salary as DIFERENCIA
from employees E INNER JOIN jobs J
	using (job_id);
    
-- 16. Idatzi kontsulta bat SQLn, langileen izen osoa (izena eta abizena), kargua eta beren lanean dituzten soldata-aldeak erakusteko, ID 80 duen sailean lan egiten duten langileentzat.

select E.first_name, E.last_name, salary, J.job_title, J.max_salary, J.max_salary - E.salary as DIFERENCIA
from employees E INNER JOIN jobs J
	using (job_id)
where E.department_id = 80;

-- 17. Idatzi kontsulta bat SQLn, herrialdearen, hiriaren eta bertan dauden sailen izenak erakusteko.

select L.city, L.state_province, D.department_name
from locations L INNER JOIN departments D
	using (location_id);
    
-- 18. Idatzi kontsulta bat SQLn, sailaren izena eta kudeatzailearen izen osoa (izena eta abizena) erakusteko.

select D.department_name, E.first_name, E.last_name, E.manager_id
from departments D INNER JOIN employees E
	on D.manager_id = E.employee_id;
    
-- 20. Idatzi kontsulta bat SQLn, gaur egun 12.000 soldata edo handiagoa irabazten duen edozein langilek egindako lanen xehetasunak erakusteko.

select salary, first_name, last_name, job_title
from employees INNER JOIN jobs 
	using (job_id)
where salary >= 12000;

-- 22. Idatzi kontsulta bat SQLn, sailaren izena, kudeatzailearen izen osoa (izena eta abizena) eta euren hiria erakusteko.

select department_name, first_name, last_name, city
from departments D INNER JOIN employees E
	on D.manager_id = E.employee_id
    INNER JOIN locations L
    using (location_id);
    
-- 23. Idatzi kontsulta bat SQLn, langilearen identifikazioa, lanaren izena eta 80. sailean lan horietarako lan egindako egun-kopurua erakusteko.

select E.first_name, E.last_name, salary, J.job_title, DATEDIFF (end_date, start_date) as "Egun-kopurua"
from employees E INNER JOIN jobs J
	using (job_id)
    inner join job_history
    using (employee_id)
where E.department_id = 80;

select employee_id, job_title, DATEDIFF (end_date, start_date) as "Egun-kopurua"
from job_history natural join jobs
where department_id = 80;

-- 24. Idatzi kontsulta bat SQLn, izen osoa (izen-abizenak) eta Londresko edozein departamentutan lan egiten duten langileen soldata erakusteko.

select E.first_name, E.last_name, L.city, D.department_name, E.salary
from employees E INNER JOIN departments D
	using (department_id)
    inner join locations L
    using (location_id)
    where city LIKE "London";
    
-- 27. Idatzi kontsulta bat SQLn langilearen izen osoa (izena eta abizena) bistaratzeko, lanean ari den herrialdearen identifikazioarekin eta izenarekin.

select E.first_name, E.last_name, C.country_id, C.country_name
from employees E INNER JOIN departments D
	using (department_id)
    inner join locations L
    using (location_id)
    inner join countries C
    using (country_id);


