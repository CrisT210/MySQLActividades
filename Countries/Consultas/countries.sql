USE world;

-- 1. 
SELECT c.name, l.language, l.percentage 
FROM countries AS c
INNER JOIN languages AS l ON c.id = l.country_id
WHERE l.language = 'Slovene'
ORDER BY l.percentage DESC;

-- 2. 
SELECT co.name, COUNT(ci.country_code) AS nro_ciudades 
FROM countries AS co 
INNER JOIN cities AS ci ON co.id = ci.country_id
GROUP BY co.name
ORDER BY nro_ciudades DESC;

-- 3. 
SELECT name, population, country_id
FROM cities
WHERE country_code = 'MEX' AND population > 500000
ORDER BY population DESC;

SELECT ci.name, ci.population, co.id
FROM countries AS co
INNER JOIN cities AS ci ON co.id = ci.country_id
WHERE co.name = 'MEXICO' AND ci.population > 500000
ORDER BY population DESC;

-- 4.
SELECT c.name, l.language, l.percentage
FROM countries AS c
INNER JOIN languages AS l ON c.id = l.country_id
WHERE l.percentage > 89
ORDER BY l.percentage DESC;

-- 5.
SELECT name, surface_area, population
FROM countries
WHERE surface_area < 501 
AND population > 100000;

-- 6.
SELECT name, government_form, capital, life_expectancy
FROM countries
WHERE government_form = 'Constitutional Monarchy' 
AND capital > 200 
AND life_expectancy > 75;

-- 7.
SELECT co.name, ci.name, ci.district, ci.population
FROM countries AS co
INNER JOIN cities AS ci ON co.id = ci.country_id
WHERE ci.district = 'Buenos Aires' 
AND ci.population > 500000;

-- 8.
SELECT region, COUNT(name) AS nro_paises
FROM countries
GROUP BY region
ORDER BY nro_paises DESC;




 