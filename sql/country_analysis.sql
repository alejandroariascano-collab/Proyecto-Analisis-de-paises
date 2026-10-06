------------------------------------------------------
--BLOQUE 1 — Exploración general
------------------------------------------------------

-- Número total de registros
SELECT COUNT(*) FROM country_stats;

-- Lista de países disponibles
SELECT DISTINCT(country_name) FROM country_stats;

-- Países duplicados
SELECT country_name,COUNT(*) AS contador FROM country_stats
GROUP BY country_name
HAVING COUNT(*) > 1;

-- Registros con valores nulos
SELECT country_name FROM country_stats
WHERE  (country_name IS NULL
	OR  Total_in_km2 IS NULL
	OR  Land_in_km2 IS NULL
	OR  Inland_water_in_km2	IS NULL
	OR  water_percent IS NULL
	OR  Population IS NULL
	OR  percent_of_world_population	IS NULL
	OR  Population_density	IS NULL
	OR  HDI	IS NULL
	OR  Fertility_rate IS NULL
	OR  Mortality_rate IS NULL
	OR  percent_of_internet_users_in_population	IS NULL
	OR  External_debt_billions IS NULL);

------------------------------------------------------
--BLOQUE 2 — Población
------------------------------------------------------

-- Top 10 países por población
SELECT country_name FROM country_stats
ORDER BY population DESC
LIMIT 10;

-- Bottom 10 países por población
SELECT country_name FROM country_stats
ORDER BY population ASC
LIMIT 10;

-- Población media
SELECT AVG(population) FROM country_stats;

-- Población total
SELECT SUM(population) FROM country_stats;

-- Países con población superior a la media
SELECT country_name, population FROM country_stats
WHERE population > (SELECT AVG(population) FROM country_stats);

------------------------------------------------------
--BLOQUE 3 — Superficie
------------------------------------------------------

-- 10 países con mayor superficie
SELECT country_name FROM country_stats
ORDER BY Total_in_km2 DESC
LIMIT 10;

-- Países con una superficie inferior a 10.000 km²
SELECT country_name FROM country_stats
where Total_in_km2 < 10000;

-- Superficie media de los países
SELECT AVG(Total_in_km2) FROM country_stats;

------------------------------------------------------
--BLOQUE 4 — RELACIONES ENTRE VARIABLES
------------------------------------------------------

-- Países pequeños con población superior a la media
SELECT country_name, Total_in_km2, population FROM country_stats
WHERE Total_in_km2 < (SELECT AVG(Total_in_km2) FROM country_stats) 
AND population > (SELECT AVG(population) FROM country_stats);

-- Países grandes con población inferior a la media
SELECT country_name, Total_in_km2, population FROM country_stats
WHERE Total_in_km2 > (SELECT AVG(Total_in_km2) FROM country_stats) 
AND population < (SELECT AVG(population) FROM country_stats);

-- 10 países con mayor densidad de población
SELECT country_name FROM country_stats
ORDER BY Population_density DESC
LIMIT 10;

------------------------------------------------------
--BLOQUE 5 — COMPARACIONES
------------------------------------------------------

-- Países con un PIB superior a la media
SELECT cs.country_name,ce.GDP FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
WHERE ce.GDP > (SELECT AVG(GDP) FROM country_economy)
ORDER BY ce.GDP DESC;

-- Países con PIB superior a la media y población inferior a la media
SELECT cs.country_name,ce.GDP,cs.Population FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
WHERE ce.GDP > (SELECT AVG(GDP) FROM country_economy)
AND cs.Population <(SELECT AVG(population) FROM country_stats);

-- Países con PIB y población inferiores a la media
SELECT cs.country_name,ce.GDP,cs.Population FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
WHERE ce.GDP < (SELECT AVG(GDP) FROM country_economy)
AND cs.Population < (SELECT AVG(population) FROM country_stats);

-- Países con PIB, población y superficie inferiores a la media
SELECT cs.country_name,ce.GDP,cs.Population FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
WHERE ce.GDP < (SELECT AVG(GDP) FROM country_economy)
AND cs.Population < (SELECT AVG(population) FROM country_stats)
AND cs.Total_in_km2 < (SELECT AVG(Total_in_km2) FROM country_stats);

-- 10 países con menor PIB per cápita
SELECT cs.country_name,ce.GDP_per_capita FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
ORDER BY ce.GDP_per_capita ASC
LIMIT 10;

-- 10 países con mayor PIB per cápita
SELECT cs.country_name,ce.GDP_per_capita FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
ORDER BY ce.GDP_per_capita DESC
LIMIT 10;

-- Países con PIB per cápita superior a la media pero PIB total inferior a la media
SELECT cs.country_name,ce.GDP,ce.GDP_per_capita FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
WHERE ce.GDP_per_capita > (SELECT AVG(GDP_per_capita) FROM country_economy)
AND ce.GDP < (SELECT AVG(GDP) FROM country_economy);

-- Relación entre población, PIB total y PIB per cápita
SELECT cs.country_name,cs.Population,ce.GDP,ce.GDP_per_capita FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
ORDER BY cs.population DESC;
