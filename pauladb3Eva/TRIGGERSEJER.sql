
-- Sor ezazu BorradoLocalidades izeneko trigger bat, Localidades taulatik herri bat ezabatzen den bakoitzean LocalidadesAntiguas taulari automatikoki gehitzen diona.
-- Bertan, ezabatuko den herriaren datuak agertuko dira, herriaren probintziaren izena eta ezabaketa egiten den egunaren data barne. 
-- Azken informazio hori current_date() funtzioak ematen du.

create table LocalidadesAntiguas(
id_localidad int,
nombre varchar(50) not null,
poblacion int, 
n_provincia int not null,
nomprov varchar(30) not null,
fecha_baja date not null);

DELIMITER $$
-- DROP trigger if exists BorradoLocalidades;
create trigger BorradoLocalidades
AFTER delete on localidades
for each row 
begin

declare nomprovOLD varchar(30);

SELECT nombre into nomprovOLD
from provincias
where n_provincia = OLD.n_provincia;

-- INSERT INTO LocalidadesAntiguas
-- SET action = "delete",
	-- id_localidad = OLD.id_localidad,
    -- nombre = OLD.nombre,
    -- poblacion = OLD.poblacion,
	-- n_provincia = OLD.n_provincia,
	-- nomprov = nomprovOLD,
    -- fecha_baja = current_date();

INSERT INTO LocalidadesAntiguas values 
(OLD.id_localidad, OLD.nombre, OLD.poblacion, OLD.n_provincia, nomprovOLD, current_date());

end;
$$

DELETE FROM localidades where id_localidad = 2866;
select * from LocalidadesAntiguas;


Create table CambiosPoblacion
(texto varchar(200),
fecha date);

DELIMITER $$
-- drop trigger if exists ModifPoblacion;
create trigger ModifPoblacion
AFTER update on localidades
for each row
begin

declare nomprovOLD varchar(30);

SELECT nombre into nomprovOLD
from provincias
where n_provincia = OLD.n_provincia;

if new.poblacion < old.poblacion then
	insert into CambiosPoblacion values
    (concat(nomprovOLD, " probintziako ", new.nombre, " herriko biztanleria txikitu egin da ", old.poblacion, 
    " izatetik ", new.poblacion, " biztanle izatera"), current_date());

elseif new.poblacion > old.poblacion then
	insert into CambiosPoblacion values
    (concat(nomprovOLD, " probintziako ", new.nombre, " herriko biztanleria hazi egin da ", old.poblacion, 
    " izatetik ", new.poblacion, " biztanle izatera"), current_date());

end if;
end;
$$

UPDATE localidades set poblacion = 5096 where id_localidad = 2865;
select * from CambiosPoblacion;

