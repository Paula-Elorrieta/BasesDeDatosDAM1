-- drop database db_pizzeria;

create database db_pizzeria 
collate utf8mb4_spanish_ci;
use db_pizzeria;

create table Pizza
(izena_pizza varchar(30) primary key,
preparazio_denbora integer not null,
prezioa float not null);

create table Osagaia
(id smallint primary key,
izena_osagaia varchar(30) not null,
neurri_unitatea varchar(3),
mota char);

create table Eduki
(izena_pizza varchar(30),
id_osagaia smallint,
kantitatea float,
primary key (izena_pizza, id_osagaia),
foreign key (izena_pizza) references Pizza(izena_pizza),
foreign key (id_osagaia) references Osagaia(id));

insert into pizza values ('Margarita',11,10.50);
insert into pizza values ('4 gaztai',15,13.50);
insert into pizza values ('Napolitana',15,13.50);
insert into pizza values ('Mediterranea',18,7.50);
insert into pizza values ('Funghi',18,10.0);

insert into Osagaia values (1, 'Tomate Saltsa','gr','B');
insert into Osagaia values (2, 'Mozzarela','gr','E');    
insert into Osagaia values (3, 'Albaka','gr','B');       
insert into Osagaia values (4, 'Oreganoa','gr','B');     
insert into Osagaia values (5, 'Gorgonzola','gr','E');   
insert into Osagaia values (6, 'Parmesano','gr','E');    
insert into Osagaia values (7, 'Fontina Gaztaia','gr','E');  
insert into Osagaia values (8, 'Antxoak','gr','A'); 
insert into Osagaia values (9, 'Alkaparrak','gr','B');
insert into Osagaia values (10, 'Urdaiazpikoa','gr','A');    
insert into Osagaia values (11, 'Txanpiak','gr','B');        
insert into Osagaia values (12, 'Olibak','gr','B');          

insert into Eduki values ('Margarita',1,50);
insert into Eduki values ('Margarita',2,100);
insert into Eduki values ('Margarita',3,50);
insert into Eduki values ('Margarita',4,25);
insert into Eduki values ('4 gaztai',2,200);
insert into Eduki values ('4 gaztai',5,200);
insert into Eduki values ('4 gaztai',6,200);
insert into Eduki values ('4 gaztai',7,200);
insert into Eduki values ('Napolitana',1,15);
insert into Eduki values ('Napolitana',4,20);
insert into Eduki values ('Napolitana',8,10);
insert into Eduki values ('Napolitana',9,5);
insert into Eduki values ('Mediterranea',1,50);
insert into Eduki values ('Mediterranea',2,30);
insert into Eduki values ('Mediterranea',3,30);
insert into Eduki values ('Mediterranea',4,20);
insert into Eduki values ('Mediterranea',8,30);
insert into Eduki values ('Mediterranea',9,20);
insert into Eduki values ('Mediterranea',11,30);
insert into Eduki values ('Mediterranea',12,20);
insert into Eduki values ('Funghi',1,40);
insert into Eduki values ('Funghi',10,40);
insert into Eduki values ('Funghi',11,200);

create table Bezeroak
(nan char(9) primary key,
izena varchar(30) not null,
abizena varchar(40) not null,
helbidea varchar(100),
herria varchar(50),
telefonoa char(9),
emaila varchar(50));

insert into Bezeroak values ('12345678A', 'Ane', 'Madariaga', 'Artekale, 12, 1A', 'Bilbo', '654321123', 'ane.madariaga@gmail.com');
insert into Bezeroak values ('87654321B', 'Olatz', 'Zarate', 'Blas de Otero, 15, 3D', 'Bilbo', '665455555', 'olatz.zarate@gmail.com');
insert into Bezeroak values ('22334455A', 'Olaia', 'Eizmendi', 'Iturribide, 8, 2esk', 'Bilbo', '667788990', 'olaia.eizmendi@gmail.com');
insert into Bezeroak values ('15666667Z', 'Julen', 'Garmendia', 'Olagorta, 23', 'Bilbo', '686868685', 'julen.garmendia@gmail.com');

create table Eskaerak
(zbk integer auto_increment primary key,
data datetime default current_timestamp,
nan char(9) not null,
izena_pizza varchar(30) not null, 
id_osagai_gehiagarria smallint, 
foreign key(nan) references Bezeroak(nan),
foreign key(izena_pizza) references pizza(izena_pizza),
foreign key(id_osagai_gehiagarria) references Osagaia(id));

insert into Eskaerak (data, nan, izena_pizza, id_osagai_gehiagarria) values ('2024-02-15 12:12:24','12345678A', 'Napolitana', 11);
insert into Eskaerak (data, nan, izena_pizza, id_osagai_gehiagarria) values ('2024-02-16 21:10:21','12345678A', 'Napolitana', 12);
insert into Eskaerak (data, nan, izena_pizza, id_osagai_gehiagarria) values ('2024-02-17 20:10:00','12345678A', 'Mediterranea', 5);
insert into Eskaerak (data, nan, izena_pizza, id_osagai_gehiagarria) values ('2024-02-17 20:00:30','87654321B', 'Funghi', 5);
insert into Eskaerak (data, nan, izena_pizza, id_osagai_gehiagarria) values ('2024-02-18 14:01:20','87654321B', 'Funghi', null);
insert into Eskaerak (data, nan, izena_pizza, id_osagai_gehiagarria) values ('2024-02-18 14:20:25','15666667Z', 'Funghi', 2);
