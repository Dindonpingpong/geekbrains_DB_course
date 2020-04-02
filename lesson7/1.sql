CREATE USER 'shop_read'@'localhost' IDENTIFIED BY '123';
CREATE USER 'shop'@'localhost' IDENTIFIED BY '456';

GRANT SELECT ON shop.* TO 'shop_read' identified by '123';
GRANT ALL ON shop.* TO 'shop' identified by '456';