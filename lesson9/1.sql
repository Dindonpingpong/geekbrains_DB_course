CREATE TABLE logs (id serial primary key, created_at datetime, 
table_name varchar(255), row_id bigint(20) unsigned,
row_name varchar(255)
)ENGINE=Archive;

DELIMITER //

CREATE TRIGGER log_user AFTER INSERT ON user
FOR EACH ROW 
BEGIN
    INSERT INTO logs VALUES (NOW(), 'user', NEW.id, NEW.name);
END//

CREATE TRIGGER log_user AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN
    INSERT INTO logs VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END//

CREATE TRIGGER log_user AFTER INSERT ON products
FOR EACH ROW 
BEGIN
    INSERT INTO logs VALUES (NOW(), 'user', NEW.id, NEW.name);
END//