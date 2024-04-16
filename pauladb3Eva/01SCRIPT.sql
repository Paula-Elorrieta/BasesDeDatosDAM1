-- Sor ezazu prozedura bat eskaera baten erreferentzia jaso eta pantailan erreferentzia 
-- hori eta erreferentzia hori duen eskaeraren data  erakutsiko dituena eta datu-basetik ezabatzeaz arduratuko dena. 
-- Ezabaketa adierazten duen mezua erakutsi behar duzu.

DELIMITER $$
DROP procedure if exists EZABATU_ESKAERA;
create procedure EZABATU_ESKAERA(IN zenbakia int)
begin
	declare v_eguna date;
    
	select eguna into v_eguna 
    from eskaera
    where eskaerazbk = zenbakia;
    
    SELECT concat("Eskaera erreferentzia: ", zenbakia, " eta eskaeraren eguna: ", v_eguna) as Mezua;
    
    delete from eskaeraitem where eskaerazbk = zenbakia;
    delete from eskaera where eskaerazbk = zenbakia;
    
    select concat("Eskaera erreferentzia: ", zenbakia, " ezabatu da") as Ezabatu_Mezua;

end;
$$

call EZABATU_ESKAERA(9);

-- Sortu EskaerakZbk izeneko funtzioa, artikulu baten deskribapena jasoko duena eta zenbaki oso bat itzuliko duena, 
-- artikulu hori zenbat eskaeratan eskatu den adierazteko

DELIMITER $$
drop function if exists EskaerakZbk;
create function EskaerakZbk(desk varchar(25)) RETURNS INT
reads sql data
begin

declare v_kant int;

select count(eskaerazbk) into v_kant 
from eskaeraitem join artikuluak using (artikulukodea)
where deskribapena = desk;

return v_kant;

end;
$$

select EskaerakZbk ("Boli gorria") as Mezua;


