drop database if exists db_company;
create database if not exists db_company;

use db_company;

CREATE TABLE employees (
    id int,
    emp_name varchar(100),
    salary int,
    dept_id int,
    manager_id int
);

INSERT INTO employees 
VALUES 
(1, 'Idris', 1000, 1, 1), 
(2, 'Aweda', 2000, 2, 2), 
(3, 'Zubair', 3000, 3, 2), 
(4, 'Young', 4000, 3, 3), 
(5, 'Babu', 5000, 1, 3), 
(6, 'John', 1000, 8, 1);

CREATE TABLE departments (
    id int,
    dept_name varchar(100)
);

INSERT INTO departments
VALUES 
(1, 'Engineering'), 
(2, 'Product'), 
(3, 'Marketing'), 
(4, 'Support');

CREATE TABLE managers (
    id int,
    manager_name varchar(100),
    dept_id int
);

INSERT INTO managers
VALUES 
(1, 'Doe', 1), 
(2, 'Jane', 2), 
(3, 'May', 4);

CREATE TABLE projects (
    id int,
    project_name varchar(100),
    emp_id int
);

INSERT INTO projects
VALUES 
(1, 'Fintech App', 1), 
(1, 'Fintech App', 5), 
(1, 'Fintech App', 6), 
(2, 'Cooking Website', 1), 
(2, 'Cooking Website', 2);



# 1. Langile bakoitzak zein departamentuetan lan egiten duen jakin nahi dugu. Langile izena eta departamentuaren izena erakutsi

select E.emp_name, D.dept_name, E.dept_id 
from employees E
INNER JOIN departments D on  E.dept_id = D.id;



# 2. Langile bakoitzak zein departamentuetan lan egiten duen jakin nahi dugu. 
-- Baina kasu honetan, langile batek ez baldin badu departamenturik esleituta, edo existitzen ez den baldin badu esleituta, 
-- bere izena ere agertzea nahi dugu. Langile izena eta departamentuaren izena erakutsi

select E.emp_name, D.dept_name, E.dept_id 
from employees E
LEFT OUTER JOIN departments D on  E.dept_id = D.id;

# 3. Departamentu bakoitzean nork egiten duen lan. Inork ez badu lanik egiten ere departamentu batean, hori agertu behar da. 

select E.emp_name, D.dept_name
from employees E
RIGHT OUTER JOIN departments D on  E.dept_id = D.id;

# 4. Langileak, managerrak, departmentuak, proiektuak



# 5. Esleitu langile bakoitzari departmentu guztiak

select E.emp_name, D.dept_name
from employees E, departments D;

select E.emp_name, D.dept_name
from employees E cross join departments D;
