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