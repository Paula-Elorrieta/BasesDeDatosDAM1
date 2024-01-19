create database if not exists db_bidaiak
collate utf8mb4_spanish_ci;

use db_bidaiak;

create table HERRIAK (
	kod_lekua int primary key,
    izena varchar(20) not null,
    deskribapena varchar(50),
    
    check (kod_lekua > 0)
);

create table JARDUERA (
	kod_bidaia varchar(10),
    jarduera_zbk smallint,
    kod_jatorri int not null,
    kod_helmuga int not null,
    kod_hotela smallint,
    km smallint,
    primary key (kod_bidaia, jarduera_zbk),
    
    check (jarduera_zbk between 1 AND 99),
    check (km between 0 AND 20000),
    
    foreign key (kod_jatorri) references HERRIAK (kod_lekua),
    foreign key (kod_helmuga) references HERRIAK (kod_lekua)
);

create table BIDAIA (
	kod_bidaia varchar(10) primary key,
    izena varchar(20) unique not null,
    iraupena smallint,
    
    check (iraupena between 1 and 99)
);

alter table JARDUERA
add
foreign key (kod_bidaia) references BIDAIA (kod_bidaia);

create table HOTEL (
	kod_hotela smallint primary key,
    izena varchar(10) not null,
    kategoria enum("1", "2", "3", "4", "5") default "3",
    deskribapena varchar(50),
    kod_hotel_r smallint,
    
    check (kod_hotela between 1 AND 999),
    
    foreign key (kod_hotel_r) references HOTEL (kod_hotela)
);

alter table JARDUERA
add
foreign key (kod_hotela) references HOTEL (kod_hotela);

-- Ezabatu FK
alter table JARDUERA
drop foreign key jarduera_ibfk_1;

-- FK cascade izateko eta aukeratutako izena izateko.
alter table jarduera
add
constraint fk_jarduera_A foreign key (kod_bidaia) references bidaia (kod_bidaia) on delete cascade on update cascade;
