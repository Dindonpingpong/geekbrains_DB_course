--Без autocommit будет намного дольше инсертить
SET autocommit = 0;

DELIMITER //
CREATE PROCEDURE generate()
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 1000000 DO
    INSERT INTO user VALUES (0,'test');
    SET i = i + 1;
    END WHILE;
END//

DELIMITER ;

CALL generate();