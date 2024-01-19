/* Database ezabatu	*/
drop database db_retailer;

/* Databasea sortu */
create database if not exists db_retailer
collate utf8mb4_spanish_ci;

/* Datubasea erabiltzeko */
use db_retailer; 

/* Tablak sortu (primary key bakarra badago ondoan ipini ahal da) */
create table FABRICANTES(
	cod_fabricante smallint primary key,
    nombre varchar(15),
    pais varchar(15)
);

/* Primary key ahazten bada */
alter table FABRICANTES
add
primary key (cod_fabricante);

/* nombre eta pais balioak letra larrian gordetzeko */
alter table FABRICANTES 
add
check (nombre = UPPER(nombre));

alter table FABRICANTES 
add
check (pais = UPPER(pais));

/* Taula ikusteko */
describe fabricantes;

/* Taula ezabatzeko aldaketak egiteko */
drop table articulos;

/* Articulos taula sortu (PK bat baino gehiago dago, zerrendatu behar da) (FK references beste taulako PK-ri) */
create table ARTICULOS(
	articulo varchar(20),
	cod_fabricante smallint,
    peso smallint,
    categoria enum('PRIMERA', 'SEGUNDA', 'TERCERA'),
    precio_venta float,
    precio_costo float,
    existencias int,
    primary key (articulo, cod_fabricante, peso, categoria),
    foreign key (cod_fabricante) references FABRICANTES (cod_fabricante),
    check (precio_venta > 0 AND precio_costo > 0 AND peso > 0)
);

-- 06.01.02 Zatia
drop table TIENDAS;

create table TIENDAS (
	nif varchar(10),
    direccion varchar(20),
    nombre varchar(20),
    poblacion varchar(20),
    proviciencia varchar(20),
    codpostal int
); 

-- PK sortu taula barruan
alter table TIENDAS 
add
primary key (nif);
 
alter table TIENDAS
add
check (provincia = upper(provincia));

-- TIENDAS barruan columna baten mota aldatzea 
alter table TIENDAS 
modify
nombre varchar(30);

-- Columna baten izena aldatzea 
alter table TIENDAS 
change
proviciencia  provincia varchar(20);

-- Toledo ez nahi badugu sartu 
alter table TIENDAS 
add
check (provincia <> 'TOLEDO');

-- 06.01.03 Zatia

create table PEDIDOS (
	nif varchar(20),
    articulo varchar(20),
    cod_fabricante smallint,
    peso smallint,
    categoria enum('PRIMERA', 'SEGUNDA', 'TERCERA'),
    fecha_pedido date,
    unidades_pedidas smallint,
    primary key (nif, articulo, cod_fabricante, peso, categoria, fecha_pedido),
    foreign key (cod_fabricante) references FABRICANTES (cod_fabricante) on delete cascade on update cascade,
    foreign key (nif) references TIENDAS (nif),
    check (unidades_pedidas > 0)
); 

alter table PEDIDOS 
add
foreign key (articulo, cod_fabricante, peso, categoria) references ARTICULOS (articulo, cod_fabricante, peso, categoria);

-- DATUAK TXERTATUKO DITUFU MURRIZKETAK KONPROBATZEKO

insert into fabricantes values (3, "Mattel", "USA");

insert into tiendas values ("C123456789", "Eroski", "Lehendakari Aguirre 184", "Bilbo", "Bizkaia", 48015); 

insert into articulos values ("ART34523", 3, 400 , "Primera", 6.9, 2.6, 100);


