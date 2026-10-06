#BLOQUE 1 — Exploración general

SELECT COUNT(*) FROM country_stats;

SELECT DISTINCT(country_name) FROM country_stats;

SELECT country_name,COUNT(*) AS contador FROM country_stats
GROUP BY country_name
HAVING contador > 1;

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

#BLOQUE 2 — Población

SELECT country_name FROM country_stats
ORDER BY population DESC
LIMIT 10;

SELECT country_name FROM country_stats
ORDER BY population ASC
LIMIT 10;

SELECT AVG(population) FROM country_stats;

SELECT SUM(population) FROM country_stats;

SELECT country_name, population FROM country_stats
WHERE population > (SELECT AVG(population) FROM country_stats);

#BLOQUE 3 — Superficie

SELECT country_name FROM country_stats
ORDER BY Total_in_km2 DESC
LIMIT 10;

SELECT country_name FROM country_stats
where Total_in_km2 < 10000;

SELECT AVG(Total_in_km2) FROM country_stats;

#BLOQUE 4 — RELACIONES ENTRE VARIABLES

SELECT country_name, Total_in_km2, population FROM country_stats
WHERE Total_in_km2 < (SELECT AVG(Total_in_km2) FROM country_stats) 
AND population > (SELECT AVG(population) FROM country_stats);

SELECT country_name, Total_in_km2, population FROM country_stats
WHERE Total_in_km2 > (SELECT AVG(Total_in_km2) FROM country_stats) 
AND population < (SELECT AVG(population) FROM country_stats);

SELECT country_name FROM country_stats
ORDER BY Population_density DESC
LIMIT 10;

#BLOQUE 5 — COMPARACIONES

SELECT cs.country_name,ce.GDP FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
WHERE ce.GDP > (SELECT AVG(GDP) FROM country_economy)
ORDER BY ce.GDP DESC;

SELECT cs.country_name,ce.GDP,cs.Population FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
WHERE ce.GDP > (SELECT AVG(GDP) FROM country_economy)
AND cs.Population <(SELECT AVG(population) FROM country_stats);

SELECT cs.country_name,ce.GDP,cs.Population FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
WHERE ce.GDP < (SELECT AVG(GDP) FROM country_economy)
AND cs.Population < (SELECT AVG(population) FROM country_stats);

SELECT cs.country_name,ce.GDP,cs.Population FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
WHERE ce.GDP < (SELECT AVG(GDP) FROM country_economy)
AND cs.Population < (SELECT AVG(population) FROM country_stats)
AND cs.Total_in_km2 < (SELECT AVG(Total_in_km2) FROM country_stats);

SELECT cs.country_name,ce.GDP_per_capita FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
ORDER BY ce.GDP_per_capita ASC
LIMIT 10;

SELECT cs.country_name,ce.GDP_per_capita FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
ORDER BY ce.GDP_per_capita DESC
LIMIT 10;

SELECT cs.country_name,ce.GDP,ce.GDP_per_capita FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
WHERE ce.GDP_per_capita > (SELECT AVG(GDP_per_capita) FROM country_economy)
AND ce.GDP < (SELECT AVG(GDP) FROM country_economy);

SELECT cs.country_name,cs.Population,ce.GDP,ce.GDP_per_capita FROM country_stats AS cs 
INNER JOIN country_economy AS ce 
ON cs.country_name = ce.country
ORDER BY cs.population DESC;
