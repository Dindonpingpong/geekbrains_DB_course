use shop;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'название раздела',
    UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название',
    description TEXT COMMENT 'Описание',
    price DECIMAL(11,2) COMMENT 'Цена',
    catalog_id BIGINT(20) UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_catalog_id(catalog_id)
) COMMENT = 'Товарный позиции';

insert into catalogs (name) values ('rpg'), ('action');
insert into products (name, price, catalog_id) values ('witcher 3', 3000, 1), ('diablo 3', 2000, 1), ('cod', 2300, 2);

create or replace view rpg_games (name, genre) as 
	select p.name, c.name from products as p join catalogs as c where p.catalog_id = c.id and p.catalog_id = 1;

select * from rpg_games;
