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