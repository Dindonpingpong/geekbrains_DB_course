DROP TABLE IF EXISTS shop.users;
CREATE TABLE shop.users (
	id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя покупателя',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

DROP TABLE IF EXISTS sample.users;
CREATE TABLE sample.users (
	id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя покупателя',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

insert into shop.users (name, birthday_at) values ('John', '1990-10-11'), ('Kate', '1998-05-10');

start transaction;
insert into sample.users (name, birthday_at)
	select name, birthday_at from shop.users
    where shop.users.id = 1;
delete from shop.users where shop.users.id = 1;
commit;

select * from shop.users;
select * from sample.users;