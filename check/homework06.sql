/*************************************************************
  Для корректного вывода русских символов в консоли Windows:
  - запустить консоль (start)
  - сменить кодировку (chcp 65001)
  - запустить mysql
*************************************************************/

DROP DATABASE sample6;
CREATE DATABASE sample6 CHARACTER SET utf8 COLLATE utf8_general_ci;
USE sample6;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Вася Пупкин',       STR_TO_DATE('01-01-2001', '%d-%m-%Y')),
  ('Кащей Бессмертный', STR_TO_DATE('02-05-2002', '%d-%m-%Y')),
  ('Серый волк',        STR_TO_DATE('03-08-2004', '%d-%m-%Y')),
  ('Баба Яга',          STR_TO_DATE('11-04-2009', '%d-%m-%Y'));
  
DROP DATABASE shop6;
CREATE DATABASE shop6 CHARACTER SET utf8 COLLATE utf8_general_ci;
USE shop6;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs (name) VALUES
  ('Процессоры'), ('Мат.платы'), ('Видеокарты'), ('Память');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at) VALUES
  ('Змей Горыныч',
    STR_TO_DATE('01-01-0001', '%d-%m-%Y'),
    STR_TO_DATE('2007-07-07', '%Y-%m-%d')),
  ('Соловей-разбойник',
    STR_TO_DATE('01-01-2001', '%d-%m-%Y'),
    STR_TO_DATE('2018-08-01', '%Y-%m-%d')),
  ('Иван Царевич',
    STR_TO_DATE('02-05-2002', '%d-%m-%Y'),
    STR_TO_DATE('2018-08-04', '%Y-%m-%d')),
  ('Василиса Прекрасная',
    STR_TO_DATE('03-08-2004', '%d-%m-%Y'),
    STR_TO_DATE('2018-08-06', '%Y-%m-%d')),
  ('Жар-птица',
    STR_TO_DATE('11-04-2009', '%d-%m-%Y'),
    STR_TO_DATE('2018-08-17', '%Y-%m-%d'));
  
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  desription TEXT COMMENT 'Описание',
  price DECIMAL(11 , 2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id(catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products (name, catalog_id) VALUES
  ('Intel Core i7',     1),
  ('Intel Xeon Silver', 1),
  ('AMD Ryzen 3',       1),
  ('GeForce GTX 1060',  3),
  ('GeForce GTX 1070',  3),
  ('Radeon RX 580',     3),
  ('Kingston ValueRAM', 4);

DROP TABLE IF EXISTS task4;
CREATE TABLE task4 (
  id SERIAL PRIMARY KEY,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) COMMENT 'Данные для задачи № 4';

INSERT INTO task4 (created_at) VALUES
  (STR_TO_DATE('01-01-2001', '%d-%m-%Y')),
  (STR_TO_DATE('23-01-2002', '%d-%m-%Y')),
  (STR_TO_DATE('15-07-2004', '%d-%m-%Y')),
  (STR_TO_DATE('20-05-2005', '%d-%m-%Y')),
  (STR_TO_DATE('31-08-2006', '%d-%m-%Y')),
  (STR_TO_DATE('04-11-2006', '%d-%m-%Y')),
  (STR_TO_DATE('11-03-2007', '%d-%m-%Y')),
  (STR_TO_DATE('07-07-2010', '%d-%m-%Y')),
  (STR_TO_DATE('06-04-2012', '%d-%m-%Y')),
  (STR_TO_DATE('17-04-2013', '%d-%m-%Y')),
  (STR_TO_DATE('13-12-2015', '%d-%m-%Y')),
  (STR_TO_DATE('21-03-2020', '%d-%m-%Y'));

SELECT ' --- [ task 1 ] --- ' AS '';
START TRANSACTION;
  UPDATE sample6.users
    SET name = (SELECT name FROM shop6.users WHERE id = 1),
      birthday_at = (SELECT birthday_at FROM shop6.users WHERE id = 1), 
      created_at = (SELECT created_at FROM shop6.users WHERE id = 1),
      updated_at = (SELECT updated_at FROM shop6.users WHERE id = 1)
    WHERE sample6.users.id = 1;
  DELETE FROM shop6.users
    WHERE id = 1;
COMMIT;

SELECT * FROM sample6.users;

SELECT ' --- [ task 2 ] --- ' AS '';
DROP VIEW IF EXISTS cat_view;

CREATE VIEW cat_view AS
  SELECT products.name AS prod,
    catalogs.name AS cat FROM products
    LEFT JOIN catalogs
    ON products.catalog_id = catalogs.id;

SELECT * FROM cat_view;

SELECT ' --- [ task 3 ] --- ' AS '';
DROP TABLE IF EXISTS days_of_month;
CREATE TEMPORARY TABLE days_of_month (
  id SERIAL,
  dd DATETIME,
  status INT
);

DROP PROCEDURE IF EXISTS full_month;
DELIMITER //  
CREATE PROCEDURE full_month(IN start_date DATE)   
BEGIN
  DECLARE day_count INT DEFAULT 0;
  DECLARE days INT DEFAULT DATEDIFF(LAST_DAY(start_date), start_date);
  DECLARE _dd DATETIME;
  DECLARE _status INT DEFAULT 0;
  WHILE (day_count <= days) DO
    SET _dd = ADDDATE(start_date, INTERVAL day_count DAY);
    SELECT 
      CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
      INTO _status
      FROM users
      WHERE created_at = _dd;
    INSERT INTO days_of_month (dd, status) VALUES
      (_dd, _status);
    SET day_count = day_count + 1;
  END WHILE;
END; //  
DELIMITER ;

CALL full_month('2018-08-01');
SELECT 
  id as '№',
  DATE_FORMAT(dd, '%d.%m.%Y') AS 'Дата',
  status AS 'Статус'
  FROM days_of_month;

SELECT ' --- [ task 4 ] --- ' AS '';
DELETE olders FROM task4 AS olders
  JOIN
    (
      SELECT created_at, id
        FROM task4 
        ORDER BY created_at DESC, id DESC
          LIMIT 1 OFFSET 4
    ) AS resent
    ON olders.created_at < resent.created_at
      OR olders.created_at = resent.created_at
      AND olders.id < resent.id;
    
SELECT id AS '№', created_at AS 'Последние 5 записей' FROM task4;
