USE sakila;

-- 1.
SELECT y.city_id, y.city, CONCAT(c.first_name, ' ', c.last_name) AS nombre_cliente, c.email, a.address 
FROM customer AS c
JOIN address AS a ON  a.address_id = c.address_id
JOIN city AS y ON y.city_id = a.city_id
WHERE y.city_id = 312;


-- 2. 
SELECT f.film_id, f.title, f.description, f.release_year, f.rating, f.special_features, c.name AS genero
FROM film AS f 
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy';

-- 3. 
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS nombre_actor, f.title, f.description, f.release_year
FROM film AS f
JOIN film_actor AS fa ON f.film_id = fa.film_id
JOIN actor AS a ON a.actor_id = fa.actor_id
WHERE a.actor_id = 5;

-- 4. 
SELECT c.store_id, a.city_id, CONCAT(c.first_name, ' ', c.last_name) AS cliente, c.email, a.address
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id 
WHERE c.store_id = 1 AND a.city_id IN (1, 42, 312, 459) 
ORDER BY a.city_id ASC;

-- 5. 
SELECT fa.actor_id, f.title, f.description, f.release_year, f.rating, f.special_features
FROM film AS f 
JOIN film_actor AS fa ON f.film_id = fa.film_id
WHERE f.rating = 'G' AND f.special_features LIKE '%Behind%' AND fa.actor_id = 15;

-- 6. 
SELECT f.film_id, f.title, a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS actor
FROM film AS f
JOIN film_actor AS fa ON f.film_id = fa.film_id
JOIN actor AS a ON a.actor_id = fa.actor_id
WHERE f.film_id = 369;

-- 7. 
SELECT f.film_id, f.title, f.description, f.release_year, f.rating, f.special_features, c.name AS genero, f.rental_rate AS tarifa_alquiler
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON c.category_id = fc.category_id
WHERE c.name = 'Drama' AND f.rental_rate = 2.99;

-- 8. 
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS actor , f.film_id, f.title, f.description, f.release_year, f.rating, f.special_features, c.name AS genero
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON c.category_id = fc.category_id
JOIN film_actor AS fa ON f.film_id = fa.film_id
JOIN actor AS a ON a.actor_id = fa.actor_id
WHERE c.name = 'Action' AND a.first_name = 'SANDRA' AND a.last_name = 'KILMER';
