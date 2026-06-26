-- Analysis Questions

-- How many support tickets are in the dataset?
SELECT COUNT(*) AS num_support_tickets
FROM customer_support_tickets;

-- Answer: There are 8,469 customer support_tickets


-- What are the most common issue types reported?
SELECT ticket_type, COUNT(*) AS total_tickets
FROM customer_support_tickets
GROUP BY ticket_type
ORDER BY total_tickets DESC;

-- Answer: Refund requests are the most common issue types however technical issues come in second with only having 5 less tickets.


-- How many tickets were submitted through each support channel?
SELECT ticket_channel, COUNT(*) AS total_tickets
  FROM customer_support_tickets
 GROUP BY ticket_channel
 ORDER BY total_tickets DESC;

-- Answer: Email - 2143, Phone - 2132, Social Media - 2121, Chat - 2073


-- What is the average resolution time across all tickets?
SELECT AVG(time_to_resolution - first_resp_time) AS average_timestamp
FROM customer_support_tickets
WHERE time_to_resolution IS NOT NULL OR first_resp_time IS NOT NULL;

-- Answer: the average resolution time across all tickets is about 3 minutes and 27 seconds.


-- How many tickets were resolved on the same day they were submitted?
SELECT COUNT(*)
  FROM customer_support_tickets
 WHERE (EXTRACT(YEAR FROM time_to_resolution) = EXTRACT(YEAR FROM first_resp_time))
       AND (EXTRACT(MONTH FROM time_to_resolution) = EXTRACT(MONTH FROM first_resp_time))
       AND (EXTRACT(DAY FROM time_to_resolution) = EXTRACT(DAY FROM first_resp_time));

-- Answer: 2,558 tickets were resolved on the same day they were submitted


-- How many tickets were submitted each month?
SELECT EXTRACT(MONTH FROM first_resp_time) AS month, COUNT(*) AS total_tickets
FROM customer_support_tickets
GROUP BY EXTRACT(MONTH FROM first_resp_time);

-- Answer: 175 tickets were submitted in May and 5,475 tickets were submitted in June. We have 2,819 tickets with unknown times.


-- What is the total number of unresolved tickets?
SELECT COUNT(*)
FROM customer_support_tickets
WHERE ticket_status = 'Open' OR ticket_status = 'Pending Customer Response';

-- Answer: There are 5700 total tickets considered to be unresolved with a ticket having a ticket status of 'Open' or 'Pending Customer Response'


-- Which ticket types have the highest number of unresolved tickets?
SELECT ticket_type, COUNT(*) AS total_unresolved_tickets
FROM customer_support_tickets
WHERE ticket_status = 'Open' OR ticket_status = 'Pending Customer Response'
GROUP BY ticket_type
ORDER BY total_unresolved_tickets DESC;

-- Answer: The unresolved tickets per ticket type are actually pretty evenly dispersed. However, cancellation requests still have the highest number of unresolved tickets.
-- But let's see if those unresolved tickets for cancellation requests are because we have not gotten to them or we are waiting on a customer's response

SELECT ticket_type, ticket_status, COUNT(*) AS total_unresolved_tickets
  FROM customer_support_tickets
 WHERE ticket_type = 'Cancellation request' AND (ticket_status = 'Open' or ticket_status = 'Pending Customer Response')
 GROUP BY ticket_type, ticket_status
 ORDER BY total_unresolved_tickets DESC;

 -- Answer: While over half of thse cancellation request tickets are still open because we are waiting for a pending customer response, there are
 -- still too many open tickets for cancellation requests.


-- How many unresolved tickets do we have per ticket priority level and are not waiting for a customer response?
 SELECT ticket_priority, COUNT(*) AS total_unresolved_tickets
   FROM customer_support_tickets
  WHERE ticket_status = 'Open'
  GROUP BY ticket_priority
  ORDER BY total_unresolved_tickets DESC;

 -- ANSWER: medium level tickets have highest number of open, unresolved tickets but the critical priority level still has 692.


-- How many tickets were submitted for each ticket channel?
 SELECT ticket_channel, COUNT(*) AS total_tickets
 FROM customer_support_tickets
 GROUP BY ticket_channel
 ORDER BY total_tickets DESC;

 -- How many of the tickets submitted for each ticket channel are unresolved?
 SELECT ticket_channel, COUNT(*) AS total_unresolved_tickets
 FROM customer_support_tickets
 WHERE ticket_status = 'Open' OR ticket_status = 'Pending Customer Response'
 GROUP BY ticket_channel
 ORDER BY total_unresolved_tickets DESC;

 -- Which ticket channel that has a better average ticket resolution time?
 SELECT ticket_channel, AVG(time_to_resolution - first_resp_time) AS avg_ticket_resolution_time
   FROM customer_support_tickets
  GROUP BY ticket_channel
  ORDER BY avg_ticket_resolution_time;

-- Looking at this query below we can see a data quality error with some of the time_to_resolution data fields being before the first_resp_time which is not possible
 SELECT *
   FROM customer_support_tickets
  WHERE time_to_resolution < first_resp_time;

-- Answering the previous question, while counting for the flaw in the data
SELECT ticket_channel, AVG(time_to_resolution - first_resp_time) AS avg_ticket_resolution_time
  FROM customer_support_tickets
 WHERE time_to_resolution > first_resp_time
 GROUP BY ticket_channel
 ORDER BY avg_ticket_resolution_time;

 -- Answer: all channels perform pretty evenly


 
-- What is the average customer satisfaction level by ticket_type?
 SELECT ticket_type, ROUND(AVG(customer_satisfaction)) AS avg_cust_satisfaction
   FROM customer_support_tickets
  GROUP BY ticket_type
  ORDER BY avg_cust_satisfaction DESC;

  -- Answer: the average customer satisfaction level for each ticket type is a 3

 