-- a) Erakutsi datu-baseko jokalari gazteenari bere izena, jaioteguna eta jolasten duen taldearen izena.

select j.nombre, j.fecha_nac, e.nombre as Equipo
	from jugadores j join equipos e
		using (id_equipo)
where j.fecha_nac = (select max(fecha_nac)
						from jugadores);


-- b) Villa hiriko taldean gol bat baino gehiago sartu duten jokalariaren izena, jaioteguna eta sartutako gol kopurua erakutsi.

select J.nombre, J.fecha_nac, count(*) as NumGoles
from jugadores J join goles G using (id_jugador)
				join equipos E using (id_equipo)
where E.ciudad = "Villa"
group by J.nombre, J.fecha_nac
having count(*) > 1;

-- c) Ligako gol goiztiarrenarentzat (partida batean arinen sartu dena), erakutsi gola sartu
-- zeneko minutua, haren deskribapena, jokalari goleatzailearen izena eta jokalari hori
-- zein taldetakoa den.

select G.minuto, G.descripción, J.nombre, E.nombre
from goles G join jugadores J using (id_jugador)
				join equipos E using (id_equipo)
where G.minuto = (select min(minuto) from goles);

-- d) 1970 baino lehen sortutako taldeek tokiko talde moduan jokatutako partida guztietan,
-- adierazi taldearen izena, jokatutako partiden kopurua (ezizena Partida kopurua),
-- sartutako gol kopuru totala (ezizena Golak etxean), jasotako gol kopuru osoa (ezizena
-- Golak kanpoan) eta golen aldea (ezizena Golen aldea). Ordenatu emaitza golen arteko
-- aldearen arabera, handitik txikira.

select E.nombre as "Taldearen Izena", count(P.fecha) as "Partida kopurua", sum(P.Goles_casa) as "Golak etxean",
		sum(P.Goles_fuera) as "Golak kanpoan", (sum(P.Goles_casa) - sum(P.Goles_fuera)) as Golen_aldea
from Equipos E join Partidos P on E.id_equipo = P.id_equipo_casa 
where E.año_fundación < 1970
group by E.nombre
order by Golen_aldea desc;

-- e) 1990 baino lehen jaiotako jokalari guztientzat, erakutsi jokalariaren izena, jaioteguna,
-- jolasten den taldearen izena eta taldearen kapitainaren izena (ezizena Kapitaina).
-- Ordenatu emaitza, lehenbizi jokalari gazteenak ager daitezen, eta, ondoren, zaharrenak.

select J.nombre, J.fecha_nac, E.nombre as Taldea, C.nombre as Kapitaina
from Jugadores J join Equipos E using (id_equipo)
join Jugadores C on E.capitán = C.id_jugador
where J.fecha_nac < "1990-01-01"
order by J.fecha_nac desc;

-- f) Partidari buruzko oharretan zerbait duten alderdi guztietan, erakutsi tokiko taldearen izena, talde bisitariaren izena, partidaren data eta oharrak.

select EL.nombre as Tokiko_Taldea, EF.nombre as Talde_Bisitaria, P.fecha as Partidaren_data, P.Observaciones as Oharrak
from equipos EL join partidos P on P.id_equipo_casa = EL.id_equipo
		join equipos EF on EF.id_equipo = P.id_equipo_fuera
where P.Observaciones is not null;

-- g) Villa F.C. taldeak bere jokalarien sailkapen bat lortu nahi du; bertan adieraziko delarik
-- jokalari bakoitzaren izena, sartu duen gol kopurua eta gola markatzen duen
-- batazbesteko minutua (biribilduta, hamartarrik gabeko). Gola sartu ez duten jokalariak
-- ere sailkapen honetan agertu behar dira. Sailkapenean, jokalariak ordenatuta agertuko
-- dira, handienetik txikienerako gol kopuruaren arabera.

select J.nombre as Jokalari, count(G.id_jugador) as Gol_Kopurua, round(avg(G.minuto)) as Batazbesteko_Minutua
from jugadores J LEFT JOIN goles G using (id_jugador)
	join equipos E using (id_equipo)
where E.nombre LIKE "%Villa F.C%"
group by J.nombre
order by Gol_Kopurua desc;

-- h) Erakutsi golen bat sartu duten Villa hiriko jokalari guztientzat bere izena, adina eta
-- sartutako gol kopurua. Ordenatu emaitza adinaren arabera, eta berdinketarik izanez
-- gero, gol kopurua handienetik txikienera. Adina kalkulatzeko, timestampdiff(denbora
-- unitatea, data1, data2) funtzioa erabil dezakezu. Funtzio horrek denbora-unitate bat
-- eta bi data hartzen ditu parametro gisa, data2 data1 baino handiagoa izanik. Funtzioak
-- bi data horien arteko aldea ematen du lehen parametrotzat adierazitako denboraunitatean. Denbora unitateak year, month, week, day, hour, minute, second… izan daitezke.

select J.nombre as Jokalari, timestampdiff(YEAR, fecha_nac, CURDATE()) as Adina, count(G.id_jugador) as Gol_Kopurua
from jugadores J JOIN goles G using (id_jugador)
	join equipos E using (id_equipo)
where E.ciudad LIKE "%Villa%"
group by J.nombre, adina
order by Adina asc;



