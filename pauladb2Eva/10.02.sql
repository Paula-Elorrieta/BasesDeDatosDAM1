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

select E.NomEmp as Izena, E.ExTelEmp as Telefonoa, E.FecNaEmp as Jaioteguna, D.NomDep as  "Departamendu izena", C.NomCen as Zentro
from empleado E INNER JOIN departamento D using (CodDep)
				INNER JOIN centro C using (CodEmpDir)
where YEAR(FecNaEmp) >= 1969
order by Jaioteguna;

# f) 1990. urtetik aurrera jaiotako seme-alabak dituzten langileen izenak eta soldatak erakutsi.

select E.NomEmp as Izena, E.SalEmp as Soldata
from empleado E INNER JOIN hijo H using (CodEmp)
where YEAR(FecNaHi) >= 1990;

# h) Beste departamentu baten menpe ez dagoen departamentuarentzat erakutsi bere izena,
-- aurrekontua, zentruaren izena, helbidea eta sail hori zuzentzen duen langilearen izena.

select D.NomDep as Departamendu_izena, D.PreAnu as Aurrekontu, C.NomCen as Zentro, E.NomEmp as Zuzendari
from departamento D LEFT JOIN departamento D2 using (CodDep)
		INNER JOIN centro C on D.CodCen = C.CodCen
        INNER JOIN empleado E on D.CodDep = E.CodDep
where D.CodDep not in (SELECT CodDep from departamento where CodDep <> CodDepDep);

-- BLOQUE DOS

-- a) Bi langile baino gehiago dituen enpresako sail bakoitzeko, erakutsi sailaren izena,
-- lantokiaren izena, langile-kopurua eta langileen batez besteko soldata bi hamartarrekin.
-- Ordenatu emaitza departamentu bakoitzeko langile kopuruaren arabera, handienetik
-- txikienera.

select D.NomDep as Departamendu_izena, C.NomCen as Zentro, count(E.CodEmp) as Langile_Kop, round(avg(SalEmp), 2) as Soldata
from departamento D INNER JOIN centro C using (CodCen)
		INNER JOIN empleado E using (CodDep) 
group by D.CodDep
HAVING count(E.CodEmp) > 2
order by Langile_Kop;

-- g) Bistaratu departamentu buru bakoitzaren kodea, izena eta haren mendeko sailen kopurua. !!!!!

select D1.CodDep, D1.NomDep, count(D2.CodDep)
from departamento D1 LEFT JOIN departamento D2 on D1.CodDep = D2.CodDepDep
group by D1.CodDep
having count(D2.CodDep) > 0;

-- h) Erakutsi langileen soldaten BATURA aurrekontuaren %25 edo gehiago den, sailen izena eta aurrekontua.

select D.NomDep, D.PreAnu
from departamento D INNER JOIN empleado E using (CodDep)
group by D.NomDep, D.PreAnu
having SUM(E.SalEmp) > (D.PreAnu * 0.25);

-- j) Erakutsi gutxienez 2 langile dituen eta Cartagenan dagoen zentroetako sailaren kodea,
-- izena eta langileen gutxieneko, gehieneko eta erdiko soldata. Ordenatu emaitza batez
-- besteko soldata handienetik txikienera.

select D.CodDep, D.NomDep, min(E.SalEmp) as Gutxiago, max(E.SalEmp) as Gehiena, avg(E.SalEmp) as Erdiko
from departamento D INNER JOIN empleado E using (CodDep)
					INNER JOIN centro C using (CodCen)
where C.PobCen LIKE "%Cartagena%"
group by D.CodDep, D.NomDep
order by Gehiena desc;

-- ñ) Langile guztien batez besteko soldata baino 1,5 aldiz gehiagoko soldata duten saileko
-- zuzendarien izena, soldata, lan egiten duen sailaren izena eta bere saila dagoen
-- zentroaren izena erakutsi

select E.NomEmp as Izena, E.SalEmp as Soldata, D.NomDep, C.NomCen
from empleado E INNER JOIN departamento D on E.CodEmp = D.CodEmpDir
				INNER JOIN centro C using (CodCen)
group by E.NomEmp, E.SalEmp, D.NomDep, C.NomCen
having avg(E.SalEmp) > (select avg(SalEmp) from empleado) * 1.5;
