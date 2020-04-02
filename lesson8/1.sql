DELIMITER ;
DROP FUNCTION IF EXISTS hello;

DELIMITER //
CREATE FUNCTION hello ()
RETURNS VARCHAR(255) NOT DETERMINISTIC
BEGIN
    DECLARE hours INT;

    SET hours = HOUR(NOW());
    IF (hours BETWEEN 6 AND 12) THEN
        RETURN 'Доброе утро';
    ELSEIF (hours BETWEEN 12 AND 18) THEN
        RETURN 'Добрый день';
    ELSEIF (hours BETWEEN 18 AND 0) THEN
        RETURN 'Добрый вечер'; 
    ELSE
        RETURN 'Доброй ночи'; 
    END IF;
END//

DELIMITER ;