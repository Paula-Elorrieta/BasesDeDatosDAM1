-- 1. Sortu parametro gisa bi zenbaki jasotzen dituen prozedura bat: gutxieneko soldata eta gehieneko soldata. 
-- Soldata bi horien artean (biak barne) kobratzen duten langile guztientzat erakutsi: izena, bere abizena, soldata, eta lan egiten duen sailaren izena erakutsi behar ditu.


DELIMITER $$
-- drop procedure if exists langileSoldata;
create procedure langileSoldata(in v_sMin decimal(8,2), in v_sMax decimal(8,2))
begin

declare v_langId int;
declare v_izena varchar(20);
declare v_abizena varchar(25);
declare v_soldata decimal(8,2);
declare amaiera bool default 1;

declare c cursor for 
select employee_id, first_name, last_name, salary
from employees
where salary between v_sMin and v_sMax;

declare continue handler for not found

set amaiera = 0;
declare exit handler for 1329
select concat("Ez dago langile soldata horiekin") as ErroreMezua1;

open c;

while amaiera = 1 do
	fetch c into v_langId, v_izena, v_abizena, v_soldata;
    select concat(v_langId, " langile kodea, izen-abizena: ", v_izena, v_abizena, " soldata: ",  v_soldata) as Informazioa;
end while;

close c;

end;
$$

call langileSoldata(21, 24);
call langileSoldata(2100, 2400);

-- 2. Sortu prozedura bat, langile gehien dituzten bi departamentuetarako: izena, 
-- langile-kopurua eta horien batez besteko soldata (bi hamartarrekin biribilduta) erakutsiko dituena.

delimiter //
drop procedure if exists langilegehien //
create procedure langilegehien ()
begin
declare v_izena varchar(30);
    declare v_soldata float;
    declare v_kant int;
    declare amaiera bool default 0;
   
    declare c cursor for
select count(employee_id), department_name, avg(salary)
    from employees join departments using (department_id)
    group by department_name
    order by count(employee_id) desc
    limit 2;
       
declare continue handler for not found
set amaiera = 1;
   
    open c;
   
    while amaiera = 0 do
fetch c into v_kant, v_izena, v_soldata ;
        select concat(v_izena, " departamentua. Batazbesteko soldata: ", v_soldata, " eta langile kopurua ", v_kant) as  Informazioa;
    end while;
    close c;
   
end;
//

call langilegehien();