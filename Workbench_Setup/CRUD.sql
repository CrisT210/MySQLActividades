USE twitter;

INSERT INTO users (first_name, last_name, handle, birthday, created_at, updated_at) 
VALUES ('Cristian', 'Vasquez', 'cristianvasquez', '1989-12-22', NOW(), NOW());

SELECT * FROM users
WHERE id = 7;

UPDATE users 
SET handle = 'crist_v', updated_at = NOW()
WHERE id = 6;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM users 
WHERE handle = 'crist_v';




