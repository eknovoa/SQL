-- TABLE CREATION AND IMPORTING DATA

CREATE TABLE coffee_sales (
	transaction_id VARCHAR(255) PRIMARY KEY,
	item VARCHAR(255),
	quantity VARCHAR(255),
	price_per_unit VARCHAR(255),
	total_spent VARCHAR(255),
	payment_method VARCHAR(255),
	location VARCHAR(255),
	transaction_date VARCHAR(255)
);


COPY coffee_sales FROM '/Users/erinnovoa/Desktop/Projects/github/eknovoa/Data Cleaning/SQL/dirty_cafe_sales.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');


-- IMPORT VERIFICATION

-- view columns
SELECT *
  FROM coffee_sales
 LIMIT 10;

-- verify number of rows
SELECT COUNT(*)
  FROM coffee_sales;

-- verifying 10,000 unique transaction_ids
SELECT COUNT(transaction_id)
  FROM coffee_sales
 WHERE transaction_id LIKE 'TXN%';

