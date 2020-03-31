SELECT cities_from.name AS `from`, cities_to.name AS `to` FROM flights 
LEFT JOIN cities AS cities_from ON flights.from = cities_from.label 
LEFT JOIN cities AS cities_to ON flights.to = cities_to.label;