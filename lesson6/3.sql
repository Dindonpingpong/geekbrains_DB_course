SELECT ADDDATE('2018-07-31', INTERVAL temp.day DAY) AS august,
NOT ISNULL(tbl.name) AS total FROM temp 
LEFT JOIN tbl ON ADDDATE('2018-07-31', INTERVAL temp.day DAY) = tbl.created_at ORDER BY august;