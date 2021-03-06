USE amigos;

-- Toda la lista de usuarios
SELECT CONCAT(u.first_name, ' ', u.last_name) AS usuario, CONCAT(u2.first_name, ' ', u2.last_name) AS amigo 
FROM users AS u
LEFT JOIN friendships AS f ON u.id = f.user_id 
LEFT JOIN users AS u2 ON f.friend_id = u2.id; 

-- Lista de usuarios solo con amigos
SELECT CONCAT(u.first_name, ' ', u.last_name) AS usuario, CONCAT(u2.first_name, ' ', u2.last_name) AS amigo 
FROM users AS u, friendships AS f, users AS u2
WHERE u.id = f.user_id AND f.friend_id = u2.id; 

-- Ejercicio Adicional

-- 1. 
SELECT u.first_name, u.last_name, CONCAT(u2.first_name, ' ', u2.last_name) AS amigo
FROM users AS u
INNER JOIN friendships AS f ON u.id = f.user_id 
INNER JOIN users AS u2 ON f.friend_id = u2.id
WHERE u2.first_name = 'Kermit';

SELECT u.first_name, u.last_name, CONCAT(u2.first_name, ' ', u2.last_name) AS amigo
FROM users AS u, friendships AS f, users AS u2
WHERE u.id = f.user_id AND f.friend_id = u2.id AND u2.first_name = 'Kermit';

-- 2.
SELECT COUNT(friend_id) AS nro_total_amistades
FROM friendships;

-- 3. 
-- Toda la lista de usuarios con o sin amigos
SELECT u.first_name, u.last_name, COUNT(f.friend_id) AS cantidad_amigos
FROM users AS u
LEFT JOIN friendships AS f ON u.id = f.user_id
GROUP BY u.id
ORDER BY cantidad_amigos DESC;

-- Considera solo a los usuarios que tienen amigos
SELECT u.first_name, u.last_name, COUNT(f.friend_id) AS cantidad_amigos
FROM users AS u, friendships AS f
WHERE u.id = f.user_id
GROUP BY u.id
ORDER BY cantidad_amigos DESC;

-- 4. 
INSERT INTO users (first_name, last_name, created_at, updated_at)
VALUES ('Mike', 'Patton', NOW(), NULL);

SELECT * FROM users; -- Para Corroborar

INSERT INTO friendships (user_id, friend_id, created_at, updated_at)
VALUES (6, 2, NOW(), NULL),(6, 4, NOW(),NULL),(6, 5, NOW(), NULL);

SELECT * FROM friendships; -- Para Corroborar

-- 5.
SELECT u.id, CONCAT(u.first_name, ' ', u.last_name) AS usuario, CONCAT(u2.first_name, ' ', u2.last_name) AS amigo
FROM users AS u
INNER JOIN friendships AS f ON u.id = f.user_id
INNER JOIN users AS u2 ON f.friend_id = u2.id
WHERE u.first_name = 'Eli'
ORDER BY u2.last_name ASC;

SELECT u.id, CONCAT(u.first_name, ' ', u.last_name) AS usuario, CONCAT(u2.first_name, ' ', u2.last_name) AS amigo
FROM users AS u, friendships AS f, users AS u2
WHERE u.id = f.user_id AND f.friend_id = u2.id AND u.first_name = 'Eli'
ORDER BY u2.last_name ASC;

-- 6. 
DELETE FROM friendships
WHERE friend_id = 5;

-- 7. 
SELECT CONCAT(u.first_name, ' ', u.last_name) AS usuario, CONCAT(u2.first_name, ' ', u2.last_name) AS amigo 
FROM users AS u
INNER JOIN friendships AS f ON u.id = f.user_id 
INNER JOIN users AS u2 ON f.friend_id = u2.id; 

SELECT CONCAT(u.first_name, ' ', u.last_name) AS usuario, CONCAT(u2.first_name, ' ', u2.last_name) AS amigo 
FROM users AS u, friendships AS f, users AS u2
WHERE u.id = f.user_id AND f.friend_id = u2.id;


