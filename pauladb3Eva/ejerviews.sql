create or replace view lang20
as 
select izena, postua, komisioa, soldata
from langilea
where saila = 20;

describe langilea;

insert into lang20 values ("Gartzia", "Langilea", 1200, 100);

delete from lang20 where izena = "Sanchez";

create or replace view soldataUrtea
as
select idLangilea, izena, soldata * 12 as "Urteko Soldata"
from langilea
where saila = 20;

update soldataUrtea set soldata = 5000 where izena = "ALONSO";

update soldataUrtea set izena = "Alonsotegi" where izena = "ALONSO";

drop view soldataUrtea;