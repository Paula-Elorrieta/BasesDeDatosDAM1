-- Adina_lortu izeneko funtzio bat sortu, zeinek langile baten NAN jasoko duen, eta haren adina itzuliko duen. Adina kalkulatzeko timestampdiff funtzioa erabil daiteke.

DELIMITER $$
drop function if exists Adina_lortu;
create function Adina_lortu(v_nan char(9)) RETURNS INT
reads sql data
begin

declare adina int;

select timestampdiff(year, JaiotzaData, current_date) into adina
from langilea
where NAN = v_nan;

return adina;

end;
$$

select Adina_lortu("21231347K");

-- 2. Sor ezazu SoldataIgoera prozedura, honek departamentu baten izena jaso, eta bere departamentu horretako langileen batez besteko soldataren arabera, 
-- egin dezala honako hau: batez besteko soldata 35.000 €-tik gorakoa bada, %2 igo behar die soldata langile guztiei; 
-- bestela, %4 igoko die soldata langile guztiei. Honelako mezua erakutsi beharko du: ‘XX saileko langileen soldata.%YY igo da’.

DELIMITER $$
-- drop procedure if exists SoldataIgoera;
create procedure SoldataIgoera (in v_departamentu varchar(40))
begin 

declare v_soldata float;
declare v_kodDepart char(5);

select avg(l.soldata), l.KodDep into v_soldata, v_kodDepart
from langilea l join departamentua d using (KodDep)
where d.Izena = v_departamentu
group by l.KodDep;


if v_soldata > 35000 then
	update langilea
    set soldata = soldata * 1.02
    where KodDep = v_kodDepart;
    
    select concat(v_departamentu, " saileko langileen soldata %2 igo da") as Mezua;
    
else 
	update langilea
	set soldata = soldata * 1.04
    where KodDep = v_kodDepart;
    
	select concat(v_departamentu, " saileko langileen soldata %4 igo da") as Mezua;
    
end if;

end; 
$$

call SoldataIgoera("Zuzendaritza Nagusia");