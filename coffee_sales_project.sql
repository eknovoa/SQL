-- Data Source: https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training


-- TABLE CREATION AND IMPORTING DATA

/*
Initially, I had to create the table and set all of the data types to be VARCHAR(255) so that I could import
the data into SQL without errors. After the data was cleaned, I used update queries to set the correct data types
to columns: quantity, price_per_unit, total_spent, and transaction_date.
*/

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

-- insert the location of this file on your local desktop
COPY coffee_sales FROM 'pathway_to_file/dirty_cafe_sales.csv'
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




-- DATA EXPLORATION QUESTIONS

-- Which transactions had the higest amount spent?
SELECT *
  FROM coffee_sales
 WHERE total_spent = (
	SELECT MAX(total_spent)
	  FROM coffee_sales
);

-- What is most common payment method used at the cafe?
SELECT payment_method, COUNT(*) AS count
  FROM coffee_sales
 WHERE payment_method IS NOT NULL
 GROUP BY payment_method
 ORDER BY count DESC;


-- Which month had the highest sales?
SELECT EXTRACT(MONTH FROM transaction_date) AS month,
	   SUM(total_spent) AS total_sales
  FROM coffee_sales
 WHERE transaction_date IS NOT NULL AND total_spent IS NOT NULL
 GROUP BY EXTRACT(MONTH FROM transaction_date)
 ORDER BY total_sales DESC;

-- Were there more takeaway orders or in-store?
SELECT location, COUNT(*) AS total_count
  FROM coffee_sales
 WHERE location IS NOT NULL
 GROUP BY location
 ORDER BY total_count DESC;


-- Did in-store or takeaway orderes have the highest sales?
SELECT location, SUM(total_spent) AS total_sales
  FROM coffee_sales
 WHERE location IS NOT NULL
 GROUP BY location
 ORDER BY total_sales DESC;

-- Combine the two queries above into one format
SELECT location,
	   COUNT(*) AS total_count,
	   SUM(total_spent) AS total_sales
  FROM coffee_sales
 WHERE location IS NOT NULL
 GROUP BY location
 ORDER BY total_count, total_sales DESC;

-- Which item sold the most?
SELECT item, COUNT(*)
  FROM coffee_sales
 WHERE item IS NOT NULL
 GROUP BY item
 ORDER BY COUNT(*) DESC;


-- Which category had the highest sales?
SELECT category, SUM(total_spent)
  FROM coffee_sales
 WHERE category IS NOT NULL
 GROUP BY category;


-- What was the average total spent amongst all transactions?
SELECT AVG(total_spent::NUMERIC)::MONEY
  FROM coffee_sales;


-- Observe the sales performance by the month and then net change from previous month
WITH monthly_sales AS (
	SELECT EXTRACT(MONTH FROM transaction_date) AS month, SUM(total_spent) AS total_sales
	  FROM coffee_sales
	 WHERE transaction_date IS NOT NULL AND total_spent IS NOT NULL
	 GROUP BY EXTRACT(MONTH FROM transaction_date)
), sales_changes_month AS (
	SELECT month,
		   total_sales,
		   -- gets previous month's sales
		   LAG(total_sales) OVER (ORDER BY month) AS previous_mth_sales,
		   -- calculates raw difference
		   (total_sales::NUMERIC - LAG(total_sales::NUMERIC) OVER (ORDER BY month))::MONEY AS net_change
	  FROM monthly_sales
	 ORDER BY month
)

SELECT *
FROM sales_changes_month;

-- Look at the net change of sales each month that were positive
SELECT *
FROM sales_changes_month
WHERE net_change > '0';



-- Rank most popular items using DENSE_RANK()
SELECT item,
	   SUM(quantity) AS total_qty_sold,
       DENSE_RANK() OVER (ORDER BY SUM(quantity) DESC) AS popularity_rank
  FROM coffee_sales
 WHERE item IS NOT NULL
 GROUP BY item
 ORDER BY popularity_rank;

-- Calculate a rolling 3-month average of sales to smooth out data spikes
WITH monthly_sales AS (
	SELECT EXTRACT(MONTH FROM transaction_date) AS month, SUM(total_spent) AS total_sales
	  FROM coffee_sales
	 WHERE transaction_date IS NOT NULL AND total_spent IS NOT NULL
	 GROUP BY EXTRACT(MONTH FROM transaction_date)
)

SELECT month,
	   total_sales AS current_mth_sales,
	   -- calculates average of current month + 2 prior months
	   AVG(total_sales::NUMERIC) OVER (
	     ORDER BY month
	     ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
	   )::MONEY AS rolling_3_mth_avg
  FROM monthly_sales
 ORDER BY month;

/*

In Month 6, our actual sales hit $7,071.50. However, our 3-month
rolling average sits slightly lower at $6,825.33. This rolling
average represents the smoothed-out performance across Months 4,
5, and 6 combined.

Why This Comparison Matters:

- Comparing these two specific numbers gives insight into our sales
momentum. It proves there is an upwards trend: Because our
current month’s sales ($7,071.50) at Month 6 are higher than the 3-month
average ($6,825.33), it tells us that Month 6 performed better
than the months leading up to it and momentum is building.

- It filters out short-term noise: If Month 6 spiked because of a single
massive corporate catering order, the rolling average cuts
through that "hype." It reminds us that the baseline
health over the last 90 days is closer to $6.8k, preventing the
team from over-expanding based on one really good/lucky month.

- It aids in inventory planning: If we only looked at Month 6's spike, we
might over-order coffee beans or another item for Month 7. Looking at the rolling
average gives us a safer, more stabilized demand number to base
supply orders on.

*/
