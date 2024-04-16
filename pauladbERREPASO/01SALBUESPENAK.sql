
-- 1. Sortu prozedura bat, departamentu-zenbaki bat jaso eta haren izena eta herria erakusteko. 
-- Parametro gisa aurreko zenbakia duen departamenturik ez badago, errore-mezu bat sortuko da 
-- egoera horren berri emateko.

DELIMITER $$
-- drop procedure if exists P_DptoIzena;
create procedure P_DptoIzena(in v_DeptZbk int)
begin

declare v_dptIzena varchar(30);
declare v_herria varchar(30);

declare exit handler for 1329
select ("Adierazitako departamentua ez da existitzen") as ErroreMezua1;

declare exit handler for 02000
select ("Adierazitako departamentua ez da existitzen") as ErroreMezua2;

SELECT 
    department_name, city
INTO v_dptIzena , v_herria FROM
    departments
        JOIN
    locations USING (location_id)
WHERE
    department_id = v_DeptZbk;

SELECT 
    CONCAT(v_DeptZbk,
            ' departamentuaren izena: ',
            v_dptIzena,
            ' da eta hiria: ',
            v_herria);

end;
$$

call P_DptoIzena(10);


-- 2 Sortu sail baten zenbakia eta sailaren izena jasoko dituen prozedura bat. Bigarren parametro gisa jasotako izen berria lehen parametro gisa 
-- jasotako zenbakiaren sailari esleitzea da helburua. Prozedura arduratuko da aldaketa hori egiteaz, eta egin ahal izan den jakinaraziko du.
DELIMITER $$
-- drop procedure if exists dptDesk;
create procedure dptDesk(in dptoKode int, in desk varchar(30))
begin

	declare v_izena varchar(30);

	declare exit handler for 1329
    select concat(dptoKode, " departamentu hori ez da existitzen") as ErroreMezua1;

	select department_name into v_izena
    from departments
    where department_id = dptoKode;
    
    if v_izena = desk then
		select concat("Errepikatutako izena da ", desk) as ErroreMezua2;
	else 
		update departments
        set department_name = desk
        where department_id = dptoKode;
        
        select concat(dptoKode, " departamentuari izen berria esleituko zaio: ", desk) as Mezua;
	end if;
end;
$$

call dptDesk(0, "Salmentak");
call dptDesk(10, "Administration");
call dptDesk(10, "Administration and controlling");

-- 3. Sortu sail baten zenbakia jaso eta hura ezabatzeaz arduratuko den prozedura bat. Kasu horretan, ezabaketaren berri ematen duen mezua agertuko da. 

DELIMITER $$

create procedure SailaEzabatu(in dptoKode int)
-- drop procedure SailaEzabatu;
begin

	declare v_izena varchar(30);

	declare exit handler for 1329
    select concat(dptoKode, " departamentu hori ez da existitzen") as ErroreMezua1;
    
    declare exit handler for 1451
    select concat(dptoKode, " departamentuan langileak daude, eta ezin da ezabatu") as ErroreMezua2;

	select department_name into v_izena
    from departments
    where department_id = dptoKode; 

	delete from departments
	where department_id = dptoKode;

	select concat(dptoKode, " ondo ezabatu da") as OndoMezua;

end;
$$

call SailaEzabatu(100000);
call SailaEzabatu(80);
call SailaEzabatu(270);

