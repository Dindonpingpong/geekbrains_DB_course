CREATE OR REPLACE VIEW username AS 
SELECT id, `name`
FROM accounts;

CREATE USER 'user_read'@'localhost' IDENTIFIED BY '123';
GRANT SELECT ON shop.username TO 'shop' identified by '456';