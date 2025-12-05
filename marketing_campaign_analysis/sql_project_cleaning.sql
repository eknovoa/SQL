-- CREATE backup copy of table so that I can make changes
CREATE TABLE campaign_table_Original AS TABLE campaign_table;

-- View Data
SELECT *
FROM campaign_table
LIMIT 5;

-- Data Cleaning

SELECT DISTINCT birth_year
FROM campaign_table
ORDER BY birth_year DESC;

SELECT DISTINCT education
FROM campaign_table;

SELECT education, COUNT(*)
FROM campaign_table
WHERE education = 'Basic' or education = '2n Cycle'
GROUP BY education;

SELECT DISTINCT marital_status
FROM campaign_table;
-- questions about YOLO, Alone and Absurd to dive into more

SELECT marital_status, COUNT(*)
FROM campaign_table
WHERE marital_status IN ('YOLO', 'Alone', 'Absurd')
GROUP BY marital_status;
-- todos: change Alone to Single & change Absurd and YOLO to ''

UPDATE campaign_table
SET marital_status = ''
WHERE marital_status = 'Absurd' OR marital_status = 'YOLO';

UPDATE campaign_table
SET marital_status = 'Single'
WHERE marital_status = 'Alone';

-- Fix table name
ALTER TABLE campaign_table
RENAME COLUMN num_web_vists_mth TO num_web_visits_mth;

