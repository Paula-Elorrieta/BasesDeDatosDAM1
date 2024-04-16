use db_enpresa;

-- a
create or replace view langileSail
as select l.izena, l.soldata, timestampdiff(year, l.sarreraData, curdate()) as Antzinatasuna, s.izena as IzenaDepart
from langilea l join saila s on l.saila = s.idsaila;

-- b
select count(izena) as LangileKop
from langilesail
group by IzenaDepart;

-- c (Ezin da aldatu kalkulu bat delako)
update langilesail set Antzinatasuna = 6 WHERE izena = "Gil";

-- d (Bai aldatu ahal da)
SET SQL_SAFE_UPDATES = 0;
update langilesail set izena = "Gila" WHERE izena = "Gil";

-- LangileBista 

-- a
create or replace view LangileBista as
select idLangilea, izena, sarreraData
from langilea
where year(sarreraData) >= 2023;

-- b (Ezin da, datu langile datuak ez dauzkagulako)
insert into LangileBista values (7777, "GARTZIA", "2019-12-31");

-- c
update LangileBista set saila = 20 where izena = "tovar";

-- d (Bai, ezabatu ahal da)
delete from langilebista where izena = "TOVAR";

