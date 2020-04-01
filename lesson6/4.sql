SELECT @end := august FROM ex3_tmp ORDER BY august desc LIMIT 5;
DELETE FROM ex3_tmp WHERE august < @END;