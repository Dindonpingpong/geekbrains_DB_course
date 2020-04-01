START TRANSACTION;

 SELECT * FROM shop.users;
 SELECT * FROM sample.users;

  INSERT INTO sample.users (name) SELECT shop.name FROM shop.users WHERE users.id = '1';
  DELETE FROM shop.users WHERE users.id = '1';

  COMMIT;