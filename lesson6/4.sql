SELECT @end := created_at FROM ex4 ORDER BY created_at desc LIMIT 5;
DELETE FROM ex4 WHERE created_at < @END;