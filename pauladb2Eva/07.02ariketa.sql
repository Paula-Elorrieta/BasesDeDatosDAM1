-- PAULA FRAGA PINTA

-- drop database db_mundua;

create database if not exists db_mundua
collate utf8mb4_spanish_ci;

use db_mundua;

create table CITY (
	city_id int primary key,
    city_name varchar(50) not null,
    country_code varchar(3) not null,
    district varchar(100) not null,
    population int
);

create table COUNTRY(
	country_code varchar(3) primary key,
    country_name varchar(150) not null,
    continent varchar(40) not null,
    region varchar(100) not null,
    surface_area int,
    independence_year year,
    population int,
    life_expectancy float,
    GNP float,
    GNP_old varchar(50), 
    local_name varchar(50),
    government_form varchar(200),
    head_of_state varchar(100),
    capital int,
    code2 varchar(2)
);

create table LANGUAGETable (
	language_code varchar(3),
    language_language varchar(30),
    official char(1),
    percentage float,
    
	primary key (language_code, language_language)
);

-- EL FK ES AL REVES
alter table CITY
add
foreign key (country_code) references COUNTRY (country_code);

alter table LANGUAGETable
add
foreign key (language_code) references COUNTRY (country_code);

-- KONTSULTAK -------------------------------------------------------------------------------------------------------------

-- 1) Hautatu Karibeko herrialde guztiak (region = “Caribbean”)

select country_name
from country
where region = "Caribbean";
-- LIKE

-- 2) Hautatu 1900 urtea ondoren independizatu diren herrialde guztia

select country_name, independence_year
from country
where independence_year > 1900;

-- 3) Hautatu errepublika diren herrialdeak.

select country_name, government_form
from country
where government_form = "Republic";
-- LIKE

-- 4) Hautatu 10 milioi biztanle baino gehiago dituzten Europako herrialde guztiak.

select country_name
from country
where population > 10000000 and continent = "Europe";

-- 5) Hautatu Asian hitz egiten diren hizkuntza guztiak

-- BIDERKADURA KARTESIARRA

-- select country_name, language_language, country_code
-- from languagetable
-- where continent = "Asia" and country_code = "AFG";

select country_name, language_language
from country
INNER JOIN languagetable on language_code = country_code
where continent = "Asia";

-- 6) Aukeratu ingelesa hizkuntza ofiziala duten herrialde guztiak.

select country_name
from languagetable
INNER JOIN country on language_code = country_code
where official = "T" and language_language = "English"
order by country_name desc;

-- 7) Zerrendatu kontinentearen arabera taldekatutako herrialde guztiak.

select country_name, count(country_name) as Total, sum(continent)
from country
group by country_name, continent
order by continent;

-- 8) Gaztelania hitz egiten den herrialde guztiak hautatu.

select country_name
from languagetable
JOIN country on language_code = country_code
where language_language = "Spanish";
