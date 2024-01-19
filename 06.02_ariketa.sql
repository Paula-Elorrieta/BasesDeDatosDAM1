create database if not exists db_herriak;

use db_herriak;

create table HERRIAK (
	id_herria int primary key, 
    izena varchar(20),
    populazioa int,
    kod_probintzia smallint
);

create table PROBINTZIAK (
	kod_probintzia smallint primary key,
    izena varchar(20),
    azalera int,
    id_hiriburua int,
    id_erkidegoa int,
    foreign key (id_hiriburua) references HERRIAK (id_herria)
);

create table KOMUNITATEA (
	id_erkidegoa smallint primary key,
    izena varchar(20),
    id_hiriburua int,
    foreign key (id_hiriburua) references HERRIAK (id_herria)
);

alter table HERRIAK
add
foreign key (kod_probintzia) references PROBINTZIAK (kod_probintzia);

alter table PROBINTZIAK 
modify
id_erkidegoa smallint;

alter table PROBINTZIAK 
add
foreign key (id_erkidegoa) references KOMUNITATEA (id_erkidegoa);

alter table HERRIAK 
modify
izena varchar(20) not null unique;

alter table HERRIAK 
modify
populazioa int not null;

alter table HERRIAK 
add
check (populazioa > 0 AND populazioa < 10000000);

alter table HERRIAK 
add
check (id_herria > 0 AND id_herria < 9000);

alter table PROBINTZIAK 
add
check (kod_probintzia > 0 AND kod_probintzia < 53);

alter table PROBINTZIAK
modify
izena int not null unique;

alter table probintziak
add
check (azalera >  0 AND azalera < 150001);

alter table probintziak
modify 
azalera int not null;

alter table probintziak
modify 
id_hiriburua int not null unique;

alter table probintziak
modify
id_erkidegoa smallint not null;

alter table komunitatea
add
check (id_erkidegoa > 0 AND id_erkidegoa < 20);

alter table komunitatea
modify
izena varchar(20) not null unique;

alter table komunitatea
modify
id_hiriburua int not null unique;

alter table probintziak -- Izena aldatazeko
modify
izena varchar(20);