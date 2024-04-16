drop database if EXISTS db_enpresak;
create database db_enpresak collate utf8mb4_spanish_ci;
use db_enpresak;
CREATE TABLE GAITASUNAK
(KodGai CHAR (5) PRIMARY KEY,
Deskribapena VARCHAR(30) NOT NULL UNIQUE);

INSERT INTO GAITASUNAK VALUES ('G001I', 'Iturgintza');
INSERT INTO GAITASUNAK VALUES ('G002G', 'Gerentzia');
INSERT INTO GAITASUNAK VALUES ('G003K', 'Kontabilitatearen Kudeaketa');
INSERT INTO GAITASUNAK VALUES ('G004M', 'Marketin');
INSERT INTO GAITASUNAK VALUES ('G005M', 'Mekanografia');
INSERT INTO GAITASUNAK VALUES ('G006H', 'Harreman Publikoak');
INSERT INTO GAITASUNAK VALUES ('G007B', 'Bezeroaren Arreta');

CREATE TABLE lantokia
(KodZen CHAR(4) PRIMARY KEY,
KodLanZuz int,
Izena VARCHAR(30) NOT NULL,
Helbidea VARCHAR(50) NOT NULL,
Herria VARCHAR(20) NOT NULL
);

INSERT INTO lantokia VALUES ('Z001', 1, 'Zuzendaritza Nagusia', 'Kale Nagusia 88', 'Bilbo');
INSERT INTO lantokia VALUES ('Z002', 6, 'Fabrica Hegoaldea', 'Pol. Ind. Rocaforte', 'Zangoza');
INSERT INTO lantokia VALUES ('Z003', 6, 'Bulegoak Hegoaldea', 'Pl. Sta. Catalina 1', 'Zangoza');

CREATE TABLE Departamentua 
(KodDep CHAR(5) PRIMARY KEY,
KodLanZuz int,
KodDepDep CHAR(5),
foreign key (KodDepDep) references Departamentua (KodDep) on delete cascade,
KodZen CHAR(4),
foreign key (KodZen) REFERENCES lantokia (KodZen) ON DELETE CASCADE,
Izena VARCHAR(40) NOT NULL,
PresupUrte float NOT NULL,
ZuzMota enum('F', 'P') NOT NULL);

INSERT INTO Departamentua VALUES ('D00A1', 1, NULL,'Z001', 'Zuzendaritza Nagusia', 156000, 'P');
INSERT INTO Departamentua VALUES ('D00AZ', 2, 'D00A1', 'Z001', 'Ikerketa eta diseinua', 150000, 'P');
INSERT INTO Departamentua VALUES ('D014K',6, 'D00A1',NULL, 'Hegoaldea fabrikako burutza', 37200, 'F');
INSERT INTO Departamentua VALUES ('ADMZS', 5,'D014K', NULL,  'Hegoaldea administrazioa', 84000, 'P');
INSERT INTO Departamentua VALUES ('PROZS', 9, 'D014K', 'Z002',  'Hegoaldea Produkzioa', 600000, 'P');
INSERT INTO Departamentua VALUES ('SALZS', 3, 'ADMZS','Z003', 'Hegoaldea Salmentak', 81000, 'F');

 
CREATE TABLE Langilea
(KodLang int PRIMARY KEY,
KodDep CHAR(5),
foreign key (KodDep) REFERENCES Departamentua (KodDep) ON DELETE CASCADE,
TelfExt int,
KontratazioData DATE NOT NULL, 
JaiotzaData DATE NOT NULL,
NAN CHAR(9) NOT NULL UNIQUE,
Izena VARCHAR (40) NOT NULL,
SemeAlabaKop int DEFAULT 0 NOT NULL,
Soldata float NOT NULL);

INSERT INTO Langilea  VALUES (5, 'ADMZS', 1239,  '1976-08-07', '1958-03-08', '38223923T', 'Araba Beriain, June', 1, 37200); 
INSERT INTO Langilea  VALUES (7, 'PROZS', NULL,  '1994-06-30', '1975-08-07', '47123132D', 'Foruria López, Galder', 0, 9600); 
INSERT INTO Langilea VALUES (6, 'D014K', 23838, '1991-08-01', '1969-06-03', '26454122D', 'Lekue Altanero, Jon', 1, 30000); 
INSERT INTO Langilea  VALUES (9, 'PROZS', 12124, '1987-06-10', '1968-07-19', '11312121D', 'Ameztoi Korrea, Rosa', 2, 18600); 
INSERT INTO Langilea  VALUES (2, 'D00AZ', 2233, '1991-06-14', '1970-06-08', '21231347K', 'Madariaga Bacterio, Luke', 0, 27000); 
INSERT INTO Langilea VALUES (8, 'PROZS', NULL,  '1994-08-15', '1976-06-15', '32132154H', 'Agirre Alto, Ekain', 1, 9600); 
INSERT INTO Langilea  VALUES (3, 'SALZS', 2133, '1984-06-08','1965-12-07', '23823930D', 'Monasterio Cid, Jokin', 1, 31200); 
INSERT INTO Langilea  VALUES ( 10, 'PROZS', NULL,  '1993-11-02','1975-01-07', '32939393D', 'Mox Almuerta, Maria', 0, 7800); 
INSERT INTO Langilea VALUES (1, 'D00A1', 1111, '1982-07-01','1961-08-07', '21451451V', 'Zarandona Irusta, Ane', 1, 43200); 
INSERT INTO Langilea  VALUES (4, 'SALZS', 3838, '1990-08-09', '1970-02-21', '38293923L', 'Eizmendi Illan, Mikel', 0, 19200); 


ALTER TABLE lantokia
ADD CONSTRAINT FK_Zuzendari_lantokia FOREIGN KEY (KodLanZuz) REFERENCES Langilea (KodLang) ON DELETE CASCADE;

ALTER TABLE Departamentua
ADD CONSTRAINT FK_Zuzendari_Dpto FOREIGN KEY (KodLanZuz) REFERENCES Langilea (KodLang) ON DELETE CASCADE;

CREATE TABLE SEMEALABAK 
(KodLang int,
foreign key (KodLang) REFERENCES Langilea (KodLang) ON DELETE CASCADE,
id int,
JaiotzaData DATE NOT NULL,
Izena VARCHAR(40) NOT NULL,
PRIMARY KEY (KodLang, id));

INSERT INTO SEMEALABAK VALUES (8,1, '1994-03-14', 'Ane Miren Agirre');
INSERT INTO SEMEALABAK VALUES (9,1, '1988-02-28', 'Julen Ameztoi');
INSERT INTO SEMEALABAK VALUES (9,2, '1990-07-18', 'Leire Ameztoi'); 
INSERT INTO SEMEALABAK VALUES (3,1, '1990-09-12', 'Maite Monasterio Lemos'); 
INSERT INTO SEMEALABAK VALUES (5,1, '1982-02-06', 'Maule Araba Pastora'); 
INSERT INTO SEMEALABAK VALUES (1,1, '1989-06-07', 'Ainara Zarandona Oropel');

CREATE TABLE LANG_GAI
(KodGai CHAR (5),
foreign key (KodGai) REFERENCES GAITASUNAK (KodGai) ON DELETE CASCADE,
KodLang int,
foreign key (KodLang) REFERENCES Langilea (KodLang) ON DELETE CASCADE,
maila int DEFAULT 5 NOT NULL CHECK (maila BETWEEN 0 AND 10),
PRIMARY KEY (KodGai, KodLang));

INSERT INTO LANG_GAI VALUES ('G002G', 1, 10);
INSERT INTO LANG_GAI VALUES ('G006H', 1, 9);
INSERT INTO LANG_GAI VALUES ('G004M', 3, 9);
INSERT INTO LANG_GAI VALUES ('G004M', 4, 6);
INSERT INTO LANG_GAI VALUES ('G007B', 5, 9);
INSERT INTO LANG_GAI VALUES ('G006H', 5, 8);
INSERT INTO LANG_GAI VALUES ('G001I', 8, 7);

COMMIT;
