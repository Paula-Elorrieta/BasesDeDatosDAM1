-- 1. Langile guztien datu guztiak lortzea.

select * 
from employees;

-- 2. Departamentu edo sail guztien datu guztiak lortzea.

select *
from departments;

-- 3. Administrarien datu guztiak lortzea (ingelesez, CLERK).

		-- MARCA LOS QUE QUIERE QUE APAREZCA
select * 
from employees
where job_id = "PU_CLERK" or job_id = "ST_CLERK" or job_id = "SH_CLERK";
		
        -- APARECEN TODOS EN LOS QUE PONGA CLERK
select * 
from employees
where job_id LIKE "%CLERK";

-- 4. Berdin, baina izenaren arabera ordenatuta.

select * 
from employees
where job_id LIKE "%CLERK"
order by first_name;

-- 5. Lortu aurreko galderaren emaitza bera, baina aldatu SQL sententzia
	
select * 
from employees
where job_id LIKE "%CLERK"
order by 2;

-- 6. Langileen zenbakia (kodea), izena eta soldata jaso.

select employee_id, first_name, salary
from employees
order by salary;


-- 7. Departamentu guztien izenen zerrenda.

select department_name
from departments;

-- 8. Berdin, baina izenaren arabera ordenatuta.

select department_name
from departments
order by 1;


-- 9. Berdin, baina hiriaren arabera ordenatuta (emaitzan ez da hiria hautatu behar).

select department_name
from departments
order by location_id;

-- 10. Berdin, baina emaitza alderantzizko ordenan erakutsi behar da.

select department_name
from departments
order by location_id desc;

-- 11. Langile guztien izena eta enplegua lortzea, soldataren arabera ordenatuta.

select first_name, job_id
from employees
order by salary;

-- 12. Langile guztien izena eta lana lortzea, lehenik beren lanaren eta gero beren soldataren arabera ordenatuta.

select first_name, job_id
from employees
order by job_id, salary;

-- 13. Berdin, baina alderantzizko hurrenkeran, lanaren arabera eta, normal, soldataren arabera.

select first_name, job_id
from employees
order by job_id desc, salary;


-- 14. Eskuratu 30. departamentuko langileen soldatak eta komisioak.

select salary, commission_pct
from employees
where department_id = 30;

-- 15. Berdin, baina komisioaren arabera ordenatua.

select salary, commission_pct
from employees
where department_id = 30
order by commission_pct;

-- 16. (a) Langile guztien komisioak lortu. 

select commission_pct
from employees; 

-- (b) Ez errepikatu langileen komisioak.

select distinct commission_pct
from employees;

-- 17. Lortu langilearen izena eta komisioa errenkadak errepikaturik gabe.

select distinct first_name, commission_pct
from employees;

-- 18. Langileen izenak eta soldatak jaso, ez errepikatzea errenkadarik.

select distinct first_name, salary
from employees;

-- 19. Langileen komisioak eta haien departamentu-zenbakiak jaso, errenkadak errepikatu gabe.

select distinct commission_pct, department_id
from employees;

-- 20. Bere soldataren erdia baino gehiagoko komisioa duten langileak aurkitu (Izenen eta Abizenen alias-ak) 

select concat(first_name, "  ", last_name) as IzenAbizena 
from employees
where commission_pct >= 0.25;

-- 21. Komisiorik ez duten langileak aurkitu, edo bai dutenak baina bere soldataren %25 edo gutxiago izatea

select concat(first_name, "  ", last_name) as IzenAbizena 
from employees
where commission_pct is null or commission_pct <= 0.25;

-- 22. 7500 baino kode handiagoa duten langileen, kodea, soldata eta komisioa aurkitu.

select first_name, employee_id, salary, commission_pct
from employees
where employee_id >= 150;

-- 23. Izena J letratik aurrera, hau barne, duten langileen datuak jaso (ASCII ordenazioa irizpide).

select * 
from employees
where first_name >= "J";

-- 24. Lortu komisioa duten langileen soldata, komisioa eta soldata osoa (soldata+komisioa), eta ordenatu emaitza langile-kopuruaren arabera.

select employee_id as Kodea, salary as Soldata, commission_pct as Komisioa, round(salary +(salary * commission_pct), 1) as "Soldata Totala"
from employees
where commission_pct is not null
order by employee_id;

-- 25. Informazio bera eman, baina komisiorik ez duten langileentzat.

select employee_id as Kodea, salary as Soldata, commission_pct as Komisioa, round(salary +(salary * commission_pct), 1) as "Soldata Totala"
from employees
where commission_pct is null;

-- 26. 120 kodea duen langilea nagusi duten langileen izena erakutsi, baldin eta soldata 1000 baino handiagoa duten.

select employee_id
from employees
where manager_id = 120 and salary > 1000;

-- 27. Aurreko kontsultaren gainontzeko balioak lortu (bere multzo osagarria).

select employee_id
from employees
where manager_id <> 120 or salary < 1000;

select employee_id
from employees
where NOT(manager_id = 120 and salary > 1000);

-- 28. Langile bakoitzak duen komisioa bere soldataren gainean duen portzentajea aurkitu, eta emaitza haren arabera ordenatu.

select commission_pct, first_name, last_name
from employees
order by 1; 

-- 29. Aurkitu LA katea ez duten 50. departamentuko langileak.

select first_name, last_name
from employees
where department_id = 50 and first_name not like "%La%";

-- 30. Jaso beste inork gainbegiratzen ez dituen langileak

select first_name, last_name
from employees
where manager_id is null;

-- 40 Lana MAN letrekin amaitu eta izena A letrarekin hasten diren langileen izenak eta lanak zerrendatu

select first_name, job_id
from employees
where first_name LIKE "A%" and job_id LIKE "%MAN"; 

-- 41. Programatzaileak ez diren langileen (IT_PROG) izen-zerrenda eta kontratazio-data

select concat(first_name, "  ", last_name) as "Izen Abizena", hire_date as "kontratazio-data"
from employees
where job_id <> "IT_PROG"; 
-- NOT LIKE

-- 42. Lor ezazu zenbaki hauetako bat duten enplegatuen informazioa: 78, 79, 75, 72, 177, 179, 178 eta 69, baina ez bada hauetako bat: 90, 45, 26 eta 37. Ez konplikatu kontsultarekin!!

select *
from employees
where employee_id IN (78, 79, 75, 72, 177, 179, 178, 69); 

-- 43. Bere kodea baino handiagoa duen langile bat buru duten langileentzat, eskuratu 1000tik gorako eta 2000tik beherako soldata jasotzen dutenak edo 30. departamentuan daudenak.

select first_name, last_name, employee_id, department_id, manager_id, sala
from employees
where department_id = 30 and manager_id > employee_id and (salary between 1000 and 2000);
