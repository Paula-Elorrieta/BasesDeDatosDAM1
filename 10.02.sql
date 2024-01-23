use db_langileenp;

-- PRIMER BLOQUE

# a) Erakutsi langile bakoitzaren kodea, izena, soldata eta lan egiten duen sailaren izena.

select E.CodEmp as kodea, E.NomEmp as Izena, E.SalEmp as soldata, D.NomDep as Saila
from empleado E INNER JOIN departamento D using (CodDep);


# d) Erakutsi 30.000 €-tik gorako soldata duten langile guztien izena eta soldata, bai eta haien
-- soldatak euren sailaren aurrekontuaren gainean duten ehunekoa ere. Biribildu azken
-- eragiketa horren emaitza 2 hamartarrera

select NomEmp as izena, SalEmp as Soldata, round((salemp / PreAnu) * 100, 2) as PorCen
from empleado INNER JOIN departamento using (CodDep)
where SalEmp > 30000
order by CodDep;

# e) Erakutsi 1969tik aurrera jaiotako langileen izena, telefono luzapena, jaioteguna, lan egiten
-- duen departamentuaren izena eta zein zentrotan dagoen kokatuta. Ordena ezazu emaitza
-- enplegatuen adinaren arabera, gazteenetik zaharrenera.



# f) 1990. urtetik aurrera jaiotako seme-alabak dituzten langileen izenak eta soldatak erakutsi.

# h) Beste departamentu baten menpe ez dagoen departamentuarentzat erakutsi bere izena,
-- aurrekontua, zentruaren izena, helbidea eta sail hori zuzentzen duen langilearen izena.

-- BLOQUE DOS

-- a) Bi langile baino gehiago dituen enpresako sail bakoitzeko, erakutsi sailaren izena,
-- lantokiaren izena, langile-kopurua eta langileen batez besteko soldata bi hamartarrekin.
-- Ordenatu emaitza departamentu bakoitzeko langile kopuruaren arabera, handienetik
-- txikienera.

-- g) Bistaratu departamentu buru bakoitzaren kodea, izena eta haren mendeko sailen kopurua.

-- h, j, ñ


