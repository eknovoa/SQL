
-- DATA CLEANING AND TRANSFORMATION

-- look at 'item' column
SELECT item, COUNT(*) AS item_count
  FROM coffee_sales
 GROUP BY item
 ORDER BY item;

-- update the 'item' column where any values with 'ERROR' and 'UNKNOWN' are now null values
UPDATE coffee_sales
   SET item = NULL
 WHERE item = 'ERROR' OR item = 'UNKNOWN';

-- 636 values were updated
-- verify this new change
SELECT item, COUNT(*) AS item_count
  FROM coffee_sales
 GROUP BY item
 ORDER BY item;

-- look at 'quantity' column
SELECT quantity, COUNT(*) AS qty_count
  FROM coffee_sales
 GROUP BY quantity
 ORDER BY quantity;

-- update the 'quantity' column where values that are 'ERROR' or 'UNKNOWN' are now null
UPDATE coffee_sales
   SET quantity = NULL
 WHERE quantity = 'ERROR' OR quantity = 'UNKNOWN';

-- 341 rows updated
-- verify change
SELECT quantity, COUNT(*) AS qty_count
  FROM coffee_sales
 GROUP BY quantity
 ORDER BY quantity;

-- change 'quantity' datatype to be SMALLINT
ALTER TABLE coffee_sales ALTER COLUMN quantity SET DATA TYPE SMALLINT USING quantity::SMALLINT;


-- look at 'price_per_unit' column
SELECT price_per_unit, COUNT(*) AS qty_count
  FROM coffee_sales
 GROUP BY price_per_unit
 ORDER BY price_per_unit;

-- update the 'price_per_unit' column where values that are 'ERROR' or 'UNKNOWN' are now null
UPDATE coffee_sales
   SET price_per_unit = NULL
 WHERE price_per_unit = 'ERROR' OR price_per_unit = 'UNKNOWN';

-- 354 rows updated
-- verify change
SELECT price_per_unit, COUNT(*) AS qty_count
  FROM coffee_sales
 GROUP BY price_per_unit
 ORDER BY price_per_unit;

-- update 'price_per_unit' column data type to be MONEY
ALTER TABLE coffee_sales ALTER COLUMN price_per_unit SET DATA TYPE MONEY USING price_per_unit::MONEY;

-- look at 'total_spent' column
SELECT total_spent, COUNT(*) AS count
  FROM coffee_sales
 GROUP BY total_spent
 ORDER BY total_spent;

-- update the 'total_spent' column where values that are 'ERROR' or 'UNKNOWN' are now null
UPDATE coffee_sales
   SET total_spent = NULL
 WHERE total_spent = 'ERROR' OR total_spent = 'UNKNOWN';

-- 329 rows updated
-- verify change
SELECT total_spent, COUNT(*) AS count
  FROM coffee_sales
 GROUP BY total_spent
 ORDER BY total_spent;

-- update 'total_spent' column data type to be MONEY
ALTER TABLE coffee_sales ALTER COLUMN total_spent SET DATA TYPE MONEY USING total_spent::MONEY;

-- look at the 'payment_method' column
SELECT payment_method, COUNT(*) AS count
  FROM coffee_sales
 GROUP BY payment_method
 ORDER BY payment_method;

-- update the 'payment_method' column where values that are 'ERROR' or 'UNKNOWN' are now null
UPDATE coffee_sales
   SET payment_method = NULL
 WHERE payment_method = 'ERROR' OR payment_method = 'UNKNOWN';

-- 599 rows updated
-- verify change
SELECT payment_method, COUNT(*) AS count
  FROM coffee_sales
 GROUP BY payment_method
 ORDER BY payment_method;


-- look at the 'location' column
SELECT location, COUNT(*) AS count
  FROM coffee_sales
 GROUP BY location
 ORDER BY location;

-- update the 'location' column where values that are 'ERROR' or 'UNKNOWN' are now null
UPDATE coffee_sales
   SET location = NULL
 WHERE location = 'ERROR' OR location = 'UNKNOWN';

-- 696 rows updated
-- verify change
SELECT location, COUNT(*) AS count
  FROM coffee_sales
 GROUP BY location
 ORDER BY location;


-- look at the 'transaction_date' column
SELECT transaction_date, COUNT(*) AS count
  FROM coffee_sales
 GROUP BY transaction_date
 ORDER BY transaction_date;

-- update the 'transaction_date' column where values that are 'ERROR' or 'UNKNOWN' are now null
UPDATE coffee_sales
   SET transaction_date = NULL
 WHERE transaction_date = 'ERROR' OR transaction_date = 'UNKNOWN';

-- 301 rows updated
-- verify change
SELECT transaction_date, COUNT(*) AS count
  FROM coffee_sales
 GROUP BY transaction_date
 ORDER BY transaction_date;

-- update 'transaction_date' column data type to be DATE
ALTER TABLE coffee_sales ALTER COLUMN transaction_date SET DATA TYPE DATE USING transaction_date::DATE;


-- add category for menu items: Beverage, Sandwiches & Salads, Pastries
ALTER TABLE coffee_sales ADD COLUMN category VARCHAR(255);

UPDATE coffee_sales
SET category = 'Beverage'
WHERE item IN ('Juice', 'Coffee', 'Smoothie', 'Tea');

UPDATE coffee_sales
SET category = 'Sandwiches & Salads'
WHERE item IN ('Salad', 'Sandwich');

UPDATE coffee_sales
SET category = 'Pastries'
WHERE item IN ('Cake', 'Cookie');


-- confirming all changes
SELECT *
  FROM coffee_sales
 LIMIT 10;

