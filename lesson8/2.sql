DELIMITER ;
DROP TRIGGER IF EXISTS check_columns;

DELIMITER //
CREATE TRIGGER check_columns BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF (NEW.name is NULL AND NEW.description is NULL) THEN
        DELETE FROM products WHERE name = NEW.name AND description = NEW.description;
    END IF;
END//