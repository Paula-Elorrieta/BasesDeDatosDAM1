drop database db_herriak2;

create database if not exists db_herriak2
collate utf8mb4_spanish_ci;

use db_herriak2;

create table HERRIAK(
	id_herriak int primary key,
    izena varchar(20) not null,
    populazioa int not null,
    kod_probintzia smallint,
    
	check (id_herriak > 1 and id_herriak < 9000),
    check (populazioa between 1 AND 10000000), -- Artea sortzeko
	unique (izena, kod_probintzia) -- Bakarra eta balore bikotea 
);

create table PROBINTZIAK (
	kod_probintzia smallint primary key,
    izena varchar(20) not null unique, -- Derrigorrezkoa eta bakarra.
    azalera int not null,
    id_hiruburua int not null unique,
    id_erkidegoa smallint not null,
    
    check (kod_probintzia between 1 AND 52),
    check (azalera between 1 AND 150000),
    
    -- FK
    foreign key (id_hiruburua) references HERRIAK (id_herriak) on delete cascade on update cascade
);

create table KOMUNITATEAK (
	id_erkidegoa smallint primary key check (id_erkidegoa between 1 AND 19), -- Murrizketa lerro berean
    izena varchar(20) unique not null,
    id_hiriburua int not null unique,
    
    foreign key (id_hiriburua) references HERRIAK (id_herriak) on delete cascade on update cascade
);

alter table probintziak
add
foreign key (id_erkidegoa) references KOMUNITATEAK (id_erkidegoa) on update cascade;

alter table herriak
add
foreign key (kod_probintzia) references PROBINTZIAK (kod_probintzia) on update cascade;

describe herriak;
