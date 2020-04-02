drop database if exists shop;
create database shop;

use shop

DROP TABLE if EXISTS users;
CREATE TABLE USERs (
    ID serial PRIMARY KEY,
    name varchar(256) DEFAULT 'anon',
    birthday date,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO users (name, birthday) VALUES ('USER1', '1980-01-01');
INSERT INTO users (name, birthday) VALUES ('USER2', '1982-02-10');
INSERT INTO users (name, birthday) VALUES ('USER3', '1983-03-12');
INSERT INTO users (name, birthday) VALUES ('USER4', '1984-04-07');
INSERT INTO users (name, birthday) VALUES ('USER5', '1985-05-22');
INSERT INTO users (name, birthday) VALUES ('USER6', '1986-06-20');
INSERT INTO users (name, birthday) VALUES ('USER7', '1987-07-15');
INSERT INTO users (name, birthday) VALUES ('USER8', '1988-08-13');
INSERT INTO users (name, birthday) VALUES ('USER9', '1989-09-10');
INSERT INTO users (name, birthday) VALUES ('USER10', '1990-10-29');

drop table if exists catalogs;
create table catalogs (
    id serial primary key,
    name varchar(256)
);
insert into catalogs (name) values ('cat1');
insert into catalogs (name) values ('cat2');
insert into catalogs (name) values ('cat3');
insert into catalogs (name) values ('cat4');

drop table  if exists products;

create table products (
    id serial primary key,
    name varchar(256),
    value int unsigned,
    catalogs_id bigint unsigned default null,
    foreign key (catalogs_id) references catalogs(id)
);

insert into products values (null, 'Product1', 431, 1);
insert into products values (null, 'Product2', 43, 1);
insert into products values (null, 'Product3', 142, 2);
insert into products values (null, 'Product4', 0, 1);
insert into products values (null, 'Product5', 41, 3);
insert into products values (null, 'Product6', 0, 2);
insert into products values (null, 'Product7', 31, 1);
insert into products values (null, 'Product8', 31, null);

drop database if exists sample;
create database sample;

use sample

DROP TABLE if EXISTS users;
CREATE TABLE USERS (
    ID serial PRIMARY KEY,
    name varchar(256) DEFAULT 'anon',
    birthday date,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

