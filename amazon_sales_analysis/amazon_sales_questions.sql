-- Practice Questions

-- How many total rows (sales records) are in the dataset?
SELECT COUNT(*) AS total_sales_records
FROM amazon_sales;

-- Answer: 128,975 sales records


-- What is the total revenue generated across all sales?
SELECT ROUND(SUM(amount)) AS total_revenue
FROM amazon_sales;

-- Answer: around $78,592,678 of total revenue generated across all sales


-- Which product category had the highest total quantity sold?
SELECT category, SUM(qty) AS total_quantity
FROM amazon_sales
GROUP BY category
ORDER BY total_quantity DESC;

-- Answer: The Set category had the highest total quantity sold



-- What is the average sales amount per transaction?
SELECT ROUND(AVG(amount)) AS avg_sales
FROM amazon_sales;

-- Answer: around $649 average sales


-- How many unique SKUs were sold?
SELECT COUNT(DISTINCT sku) AS no_unique_skus
FROM amazon_sales;

-- Answer: 7,195 unique skus


-- What are the top 5 most sold SKUs based on quantity?
SELECT sku, SUM(qty) AS total_quantity
FROM amazon_sales
GROUP BY sku
ORDER BY total_quantity DESC
LIMIT 5;


-- Which month had the highest total sales revenue?
SELECT EXTRACT(MONTH FROM sale_date) AS month, ROUND(SUM(amount::numeric),2) AS total_sales
FROM amazon_sales
GROUP BY EXTRACT(MONTH FROM sale_date)
ORDER BY total_sales DESC;

-- Answer: April had the highest total sales revenue

SELECT * FROM amazon_sales LIMIT 1;
-- How many sales were B2B transactions vs non-B2B?
SELECT b2b, COUNT(*) AS total_sales
FROM amazon_sales
GROUP BY b2b;

-- Answer: 128,104 sales for non-b2b vs b2b had 871 sales


-- Which fulfillment method was used most frequently?
SELECT fulfillment, COUNT(*) AS total
FROM amazon_sales
GROUP BY fulfillment;

-- Amazon had the most frequently used fulfillment method with 89,698 transactions
-- compared to Merchant had 39,277 transactions.

-- How many sales were made for each product size?
SELECT size, COUNT(*) AS total
FROM amazon_sales
GROUP BY size
ORDER BY total DESC;