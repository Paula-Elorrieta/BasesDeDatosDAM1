drop database if exists db_enpresa;
create database db_enpresa collate utf8mb4_spanish_ci;

use db_enpresa;

create table saila
(idSaila int primary key constraint ck_saila check (idSaila between 10 and 100),
izena varchar(40) unique not null,
kokapena varchar(40) not null);

create table langilea
(idLangilea int primary key constraint ck_langi check (idLangilea > 0),
izena varchar(40) not null,
postua enum ('langilea', 'saltzailea', 'zuzendaria', 'analista', 'programatzailea', 'presidentea') not null,
idBurua int,
sarreraData date not null,
soldata float not null constraint ck_soldata check (soldata >= 600),
komisioa float constraint ck_komisioa check (komisioa >= 0),
saila int default 10 not null,
constraint fk_burua foreign key(idBurua) references langilea(idLangilea) on update cascade,
constraint fk_saila foreign key(saila) references saila(idSaila) on update cascade);

INSERT INTO saila VALUES (10, 'Kontabilitatea', 'SEVILLA');
INSERT INTO saila VALUES (20, 'Ikerketa', 'MADRID');
INSERT INTO saila VALUES (30, 'Salmentak', 'BARCELONA');

INSERT INTO langilea VALUES (7839, 'REY', 'presidentea', NULL, '2023/11/17', 3900, 0, 10);
INSERT INTO langilea VALUES (7698, 'NEGRO', 'zuzendaria', 7839, '2023/05/01', 2200, 0, 30);
INSERT INTO langilea VALUES (7738, 'CEREZO', 'zuzendaria', 7839, '2023/09/06', 2210, 0, 10);
INSERT INTO langilea VALUES (7566, 'JIMÉNEZ', 'zuzendaria', 7839, '2023/02/04', 2300, 0, 20);
INSERT INTO langilea VALUES (7499, 'ARROYO', 'saltzailea', 7698, '2013/02/20', 1200, 240, 30);
INSERT INTO langilea VALUES (7521, 'SALA', 'saltzailea', 7698, '2023/02/22', 960, 390, 30);
INSERT INTO langilea VALUES (7654, 'MARTÍN', 'saltzailea', 7698, '2023/09/29', 965, 1000, 30);
INSERT INTO langilea VALUES (7844, 'TOVAR', 'saltzailea', 7698, '2023/09/08', 1100, 0, 30);
INSERT INTO langilea VALUES (7900, 'JIMENO', 'langilea', 7698, '2023/12/03', 725, 0, 30);
INSERT INTO langilea VALUES (7369, 'SÁNCHEZ', 'langilea', 7900, '2016/12/12', 600, 0, 20);
INSERT INTO langilea VALUES (7788, 'GIL', 'analista', 7566, '2017/04/23', 2350, 0, 20);
INSERT INTO langilea VALUES (7876, 'ALONSO', 'langilea', 7788, '2017/08/09', 860, 0, 20);