USE lead_gen_business;

SELECT * FROM clients;

-- 1. 
SELECT MONTHNAME(charged_datetime) AS mes, SUM(amount) AS ingreso_total 
FROM billing
WHERE charged_datetime BETWEEN '2012/03/01' AND '2012/03/31'
GROUP BY mes;

-- 2. 
SELECT c.client_id AS id, CONCAT(c.first_name, ' ', c.last_name) AS cliente, SUM(b.amount) AS ingreso_total
FROM clients AS c
INNER JOIN billing AS b ON c.client_id = b.client_id
WHERE c.client_id = 2;

-- 3.
SELECT c.client_id AS id, CONCAT(c.first_name, ' ', c.last_name) AS cliente, s.domain_name AS sitio
FROM clients AS c
INNER JOIN sites AS s ON c.client_id = s.client_id
WHERE c.client_id = 10;

-- 4.
SELECT c.client_id AS id, COUNT(s.site_id) AS cantidad_sitios, MONTHNAME(s.created_datetime) AS mes, YEAR(s.created_datetime) AS año
FROM clients AS c
INNER JOIN sites AS s ON c.client_id = s.client_id
WHERE c.client_id = 1
GROUP BY s.site_id;

SELECT c.client_id AS id, COUNT(s.site_id) AS cantidad_sitios, MONTHNAME(s.created_datetime) AS mes, YEAR(s.created_datetime) AS año
FROM clients AS c
INNER JOIN sites AS s ON c.client_id = s.client_id
WHERE c.client_id = 20
GROUP BY s.site_id;

-- 5.
SELECT s.domain_name AS sitio, COUNT(l.leads_id) AS nro_clientes_potenciales, DATE_FORMAT(l.registered_datetime, "%M %d, %Y") AS fecha
FROM sites AS s
LEFT JOIN leads AS l ON s.site_id = l.site_id
WHERE l.registered_datetime BETWEEN '2011/01/01' AND '2011/02/15'
GROUP BY sitio, l.registered_datetime;

-- 6.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS cliente, COUNT(l.leads_id) AS nro_clientes_potenciales
FROM clients AS c
INNER JOIN sites AS s ON c.client_id = s.client_id
INNER JOIN leads AS l ON s.site_id = l.site_id
WHERE l.registered_datetime BETWEEN '2011/01/01' AND '2011/12/31'
GROUP BY c.client_id;

-- 7. 
SELECT CONCAT(c.first_name, ' ', c.last_name) AS cliente, COUNT(l.leads_id) AS nro_clientes_potenciales, MONTHNAME(l.registered_datetime) AS mes
FROM clients AS c
INNER JOIN sites AS s ON c.client_id = s.client_id
INNER JOIN leads AS l ON s.site_id = l.site_id
WHERE l.registered_datetime BETWEEN '2011/01/01' AND '2011/06/31'
GROUP BY c.client_id, l.registered_datetime
ORDER BY MONTH(l.registered_datetime);

-- 8. 
SELECT CONCAT(c.first_name, ' ', c.last_name) AS cliente, s.domain_name AS sitio, COUNT(l.leads_id) AS nro_clientes_potenciales, DATE_FORMAT(MIN(l.registered_datetime), "%M %d, %Y") AS fecha
FROM clients AS c
INNER JOIN sites AS s ON c.client_id = s.client_id
INNER JOIN leads AS l ON s.site_id = l.site_id
WHERE l.registered_datetime BETWEEN '2011/01/01' AND '2011/12/31'
GROUP BY c.client_id, sitio
ORDER BY c.client_id, MIN(l.registered_datetime);

SELECT CONCAT(c.first_name, ' ', c.last_name) AS cliente, s.domain_name AS sitio, COUNT(l.leads_id) AS nro_clientes_potenciales
FROM clients AS c
INNER JOIN sites AS s ON c.client_id = s.client_id
INNER JOIN leads AS l ON s.site_id = l.site_id
GROUP BY c.client_id, sitio
ORDER BY c.client_id, MIN(l.registered_datetime);

-- 9.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS cliente, SUM(b.amount) AS ingreso_total, MONTHNAME(b.charged_datetime) AS mes, YEAR(b.charged_datetime) AS año
FROM clients AS c
INNER JOIN billing AS b ON c.client_id = b.client_id
GROUP BY c.client_id, mes, año
ORDER BY c.client_id, MIN(b.charged_datetime);

-- 10. 
SELECT CONCAT(c.first_name, ' ', c.last_name) AS cliente, GROUP_CONCAT(' ', s.domain_name, ' ' SEPARATOR '/') as sitios
FROM clients AS c
LEFT JOIN sites AS s ON c.client_id = s.client_id
GROUP BY c.client_id;

 

