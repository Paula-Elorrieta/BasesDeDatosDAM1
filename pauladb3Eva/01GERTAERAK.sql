-- db_eskaerak
-- 1
create table ESTATISTIKAK_ART
(artikulukodea char(5) not null,
deskribapena varchar(30) not null,
salmentaprezioa float not null,
sal_kop int not null,
eguna date,
constraint PK_est_arti primary key(artikulukodea, eguna ));

DELIMITER $$
create event Estatistikak_sortu on schedule
every 1 month starts current_timestamp()
do
begin

declare artKodea char(4);
declare artDeskr varchar(25);
declare salmPrezioa float;
declare artKantitate int;
declare amaiera bool default 0;

declare c cursor for
SELECT a.artikulukodea, a.deskribapena, a.salmentaprezioa, SUM(e.kantitatea)
FROM artikuluak a join eskaeraitem e using (artikulukodea)
GROUP BY 1,2,3;

declare continue handler for not found
	set amaiera = 1;
open c;
fetch c into artKodea, artDeskr, salmPrezioa, artKantitate;
while amaiera = 0 do
    insert into ESTATISTIKAK_ART values (artKodea, artDeskr, salmPrezioa, artKantitate, current_date);
	fetch c into artKodea, artDeskr, salmPrezioa, artKantitate;
end while;

close c;

end;
$$


-- 2

create table Artikulu_Zaharkituak (
	artikulukodea char(5) not null,
	deskribapena varchar(30) not null,
	salmentaprezioa float not null,
	baja_eguna date,
	constraint PK_est_arti primary key(artikulukodea, baja_eguna)
);

DELIMITER $$
create event Baja on schedule
every 1 month starts current_timestamp()
do
begin

select eguna, artikulukodea
from eskaera; 



end;
$$