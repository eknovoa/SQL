CREATE TABLE amazon_sales (
	index TEXT,
	order_id TEXT,
	sale_date DATE,
	status TEXT,
	fulfillment TEXT,
	sales_channel TEXT,
	shipping_level TEXT,
	style TEXT,
	sku TEXT,
	category TEXT,
	size TEXT,
	asin TEXT,
	courier_status TEXT,
	qty INT,
	currency TEXT,
	amount FLOAT,
	ship_city TEXT,
	ship_state TEXT,
	ship_postal_code TEXT,
	ship_country TEXT,
	promotion_ids TEXT,
	b2b BOOLEAN,
	fulfilled_by TEXT
);

-- View Data
SELECT *
FROM amazon_sales
LIMIT 5;

-- Clean Data
SELECT order_id, COUNT(order_id)
FROM amazon_sales
GROUP BY order_id
HAVING COUNT(order_id) > 1;
-- some order_ids appear more than once

SELECT DISTINCT(category)
FROM amazon_sales;

UPDATE amazon_sales
SET category = 'Kurta'
WHERE category = 'kurta';
-- capitalized the values in category column from kurta to Kurta for better text formatting to match the other
-- values in the field

SELECT DISTINCT(size)
FROM amazon_sales;
-- I changed the value of "Free" to be "One Size" instead for better clarity to represent it is a one size fits all item

UPDATE amazon_sales
SET size = 'One Size'
WHERE size = 'Free';

SELECT DISTINCT(ship_state)
FROM amazon_sales;

SELECT DISTINCT(ship_city)
FROM amazon_sales;

UPDATE amazon_sales
SET ship_state = INITCAP(ship_state);

UPDATE amazon_sales
SET ship_city = INITCAP(ship_city);
-- needed to update the values in these columns because some are lowercase, some
-- are in proper case, and then some all upper case
