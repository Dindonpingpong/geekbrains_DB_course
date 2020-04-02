-- задание 1.
-- В базе данных shop и sample присутвуют одни и те же таблицы учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.


start transaction;
insert into sample.users select * from shop.users where id = 1 on duplicate key update sample.users.name = shop.users.name;
-- тут можно открыть вторую консоль и выполнить use sample; select * from users;
-- чтобы увидеть, что данные не появились в базе sample
delete from shop.users where id = 1;
commit;


-- задание 2.
-- Создайте представление, которое выводит название (name) товарной позиции из таблицы products
-- и соответствующее название (name) каталога из таблицы catalogs.

use shop
create or replace view view1 as select products.name,
(select catalogs.name from catalogs where catalogs.id = products.catalogs_id) as catalog from products;
select * from view1;

-- 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at.
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
select * from users;
set @count := (select count(id) as cc from users);
select @count:= @count - 5;
prepare del from 'delete from users order by created_at asc limit ?';
execute del using @count;
select * from users;