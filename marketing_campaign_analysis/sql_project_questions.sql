-- Questions to Answer:

-- How many customer records are in the dataset?
SELECT COUNT(*)
FROM campaign_table;

-- Answer: 2,240 customer records in the dataset

-- How many customers accepted each of the five marketing campaigns?
SELECT COUNT(*)
FROM campaign_table
WHERE accepted_camp_1 = true 
AND accepted_camp_2 = true AND accepted_camp_3 = true 
AND accepted_camp_4 = true AND accepted_camp_5 = true; 

-- Answer: no customer accepted each of the 5 marketing campaigns


-- What is the overall acceptance rate across all marketing campaigns?
SELECT ROUND(((
	-- Numerator
	SUM(CASE WHEN accepted_camp_1 = TRUE THEN 1 ELSE 0 END) +
    SUM(CASE WHEN accepted_camp_2 = TRUE THEN 1 ELSE 0 END) +
    SUM(CASE WHEN accepted_camp_3 = TRUE THEN 1 ELSE 0 END) +
    SUM(CASE WHEN accepted_camp_4 = TRUE THEN 1 ELSE 0 END) +
    SUM(CASE WHEN accepted_camp_5 = TRUE THEN 1 ELSE 0 END)
	)
	/
	-- Denominator
	(COUNT(*)*5.0)
	)*100,2) AS overall_acceptance_rate
FROM campaign_table;

-- Answer: 5.96% is the overall acceptance rate across the 5 marketing campaigns

-- How many customers belong to each education level?
SELECT education, COUNT(*) AS total_customers
  FROM campaign_table
 GROUP BY education
 ORDER BY education;


-- What is the average income of customers who accepted the most recent campaign?
SELECT ROUND(AVG(income),2) AS avg_income_camp_5_accepted
FROM campaign_table
WHERE accepted_camp_5 = true;

-- Answer: The average income of customers who accepte the most recent campaign 5 is $82,352.83

-- Which purchase channel had the highest number of purchases?
SELECT SUM(num_discount_purch) AS total_purch_discount,
       SUM(num_web_purch) AS total_purch_web,
	   SUM(num_catalog_purch) AS total_purch_catalog
FROM campaign_table;

-- Answer: Web purchases had the highest number of purchases totaling 9,150


-- How many customers visited the website more than five times in the last month?
SELECT COUNT(*) AS total_customers_visit_more_than_5
FROM campaign_table
WHERE num_web_visits_mth > 5;

-- Answer: 1,170 customers visited the website more than 5 times in the last month and there were 2,240 customers


-- What is the average number of days since the last purchase across all customers?
SELECT ROUND(AVG(days_since_prev_purch)) AS avg_days_since_last_purch
FROM campaign_table;

-- Answer: an average of 49 days since the last purchase across all customers


-- How many customers made at least one purchase using a discount?
SELECT COUNT(*) AS num_customers_use_discount
FROM campaign_table
WHERE num_discount_purch >= 1;

-- Answer: 2,194 customers made at least one purchase using a discount and there were 2,240 customers
