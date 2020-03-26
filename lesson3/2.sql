UPDATE users SET created_at = STR_TO_DATE(created_at, "%d.%m.%Y %T");
ALTER TABLE users MODIFY COLUMN created_at datetime;