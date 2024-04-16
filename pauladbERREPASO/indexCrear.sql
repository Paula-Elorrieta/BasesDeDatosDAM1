use db_hr;

show index from employees;

describe employees;

create index iemp_hiredate on employees (hire_date); 

drop index iemp_hiredate on employees;