-- 1) Erakutsi bere izenak 8 karaktere baino gehiago dituen langileen xehetasunak (izena - > first_name).

select first_name as Izena
from employees
where length(first_name) > 8;

-- 2) Erakutsi langile kodea, izena eta abizena eta langilea kontratatua izan zen hilabetea.

select employee_id as Langile_Kodea, first_name as Izena, last_name as Abizena, monthname(hire_date) as Kontratatua
from employees;

-- 3) Erakutsi teléfono zenbaki guztien azken 4 karaktereak.

select first_name as Izena, SUBSTRING(phone_number, -4) as "Zenbaki 4 Digitoak"
from employees;

select first_name as Izena, RIGHT(phone_number, 4) as "Zenbaki 4 Digitoak"
from employees;

-- 4) Erakutsi langileen izena eta bere izenaren luzera (karaktere kopurua) baldin eta izena
-- bera A, J edo M letrekin hasten den. Zutabe bakoitzari etiketa egokia esleitu. Ordenatu
-- emaitza langilearen izenaren arabera.

select first_name as Izena, length(first_name) as Luzeera
from employees
where first_name LIKE "A%" or first_name LIKE "J%" or first_name LIKE "M%"
order by first_name;

-- 5) Ekainean kontratatuak izan ziren langileen izena eta abizena erakutsi, ordenatuta, dataren arabera.

select first_name as Izena, last_name as Abizena, monthname(hire_date)
from employees
where month(hire_date) = 06;

-- 6) Erakutsi lanpostu bakoitzak dituen langileen ID-ak. Outputa honelako zerbait izango da:

select job_id, group_concat(employee_id) 
from employees
group by job_id;
