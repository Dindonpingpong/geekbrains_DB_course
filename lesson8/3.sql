DELIMITER ;
DROP FUNCTION IF EXISTS FIBONACCI;

DELIMITER //
CREATE FUNCTION FIBONACCI(number INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
    DECLARE i, previous, current, tmp INT DEFAULT 0;

    SET current = 1;
    WHILE i < number - 1 DO
        SET tmp = current;
        SET current = current + previous;
        SET previous = tmp;
        SET i = i + 1;
    END WHILE;
    RETURN current;
END//

DELIMITER ;