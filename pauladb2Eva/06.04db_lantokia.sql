-- PAULA db_lantokia
-- drop database db_lantokia;

create database if not exists db_lantokia;

use db_lantokia;

create table SAILA (
	kodesaila char(5) primary key,
    izenasaila varchar(40) unique,
	aurrekontua float,
    kodelantokia int unsigned,
    kodesailaburua char(5),
    
    foreign key (kodesailaburua) references SAILA (kodesaila)
);

create table LANTOKIA (
	kodelantokia int unsigned primary key,
    izenalant varchar(40) unique,
    helbidea varchar(40),
    aurrekontua float,
    kodeHiria int unsigned
);

create table HIRIA (
	kodehiria int unsigned primary key,
    izenahiria varchar(40),
    probintzia varchar(30),
    hiriburua boolean
);

alter table SAILA 
add
foreign key (kodelantokia) references LANTOKIA (kodelantokia);

alter table LANTOKIA 
add
foreign key (kodeHiria) references HIRIA (kodeHiria);

alter table SAILA
modify
aurrekontua float not null;

alter table HIRIA 
modify
probintzia enum("BIZKAIA", "GUIPUZKUA", "ALABA") default "BIZKAIA";

-- describe saila;

-- DATUAK SARTU

insert into hiria values (1, "bilbo", "BIZKAIA", 1);

insert into lantokia values (1, "Nagusia", "Gran Via, 80", 1200000, 1);

insert into saila values ("ZUZEN", "Zuzendaritza", 500000, 1, null);






