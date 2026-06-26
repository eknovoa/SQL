CREATE TABLE customer_support_tickets (
	id TEXT,
	name TEXT,
	email TEXT,
	age SMALLINT,
	gender TEXT,
	product_purchased TEXT,
	date_purchase DATE,
	ticket_type TEXT,
	ticket_subject TEXT,
	ticket_descr TEXT,
	ticket_status TEXT,
	resolution TEXT,
	ticket_priority TEXT,
	ticket_channel TEXT,
	first_resp_time TIMESTAMP,
	time_to_resolution TIMESTAMP,
	customer_satisfaction SMALLINT
);

-- import data
COPY customer_support_tickets FROM '/Users/erinnovoa/Desktop/Projects/github/eknovoa/SQL/Customer Support Analysis/customer_support_tickets.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

-- View Data
SELECT *
FROM customer_support_tickets
LIMIT 5;
