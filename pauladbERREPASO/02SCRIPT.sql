-- Sortu ezazu prozedura berria, ErkidegoaXehetasuna izenekoa, autonomia-erkidego baten izena jasoko duena eta autonomia-erkidego horretako 
-- probintzia-kopurua eta udalerri-kopurua erakutsiko duena. Autonomia-erkidego hori datu-basean ez 
-- badago, mezu hau agertuko da: “XXXX izeneko autonomia-erkidegoa ez dago datu-basean”.

DELIMITER $$
	DROP procedure if exists ErkidegoaXehetasuna;
	create procedure ErkidegoaXehetasuna(in izena varchar(30))
    begin
    
    declare provKop int;
    declare udalKop int;
    
    select count(n_provincia) into provKop
    from provincias join comunidades using (id_comunidad)
    where comunidades.nombre = izena;
    
    if provKop = 0 then
		select concat(izena, " izeneko autonomia-erkidegoa ez dago datu-basean") as MezuaErrorea;
    else 
		select count(id_localidad) into udalKop
		from comunidades join provincias using (id_comunidad)
						join localidades using (n_provincia)
		where comunidades.nombre = izena;
    
		select concat("Probintzia kopurua ", provKop, " , udal kopurua: ", udalKop) as Mezua;
    end if;
    
    end;
$$

call ErkidegoaXehetasuna("Galicia");

-- Sortu ProbintziaNagusi izeneko funtzio bat, autonomia-erkidego baten izena jasoko duena, 
-- eta itzuliko duena autonomia-erkidego horren azalera handiena duen probintziaren izena.


DELIMITER $$
create function ProbintziaNagusi(izena varchar(30)) RETURNS VARCHAR(30)
reads sql data
begin

	declare provIzena varchar(30);

	select provincias.nombre into provIzena
    from provincias 
    where superficie = (select max(superficie) from provincias join comunidades using(id_comunidad) where comunidades.nombre = izena);

	return provIzena;

end;
$$

select ProbintziaNagusi("Extremadura") as Mezua; 



