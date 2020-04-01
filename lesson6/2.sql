CREATE OR REPLACE VIEW goods (Category, ProductName) AS
SELECT catalogs.category, products.name FROM products JOIN catalogs ON products.catalog_id = catalogs.id;