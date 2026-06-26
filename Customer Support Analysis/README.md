# Customer Support Ticket Data Analysis

A SQL-based data exploratory analysis project from [InterviewMaster.ai](https://www.interviewmaster.ai/content/sql/projects/level1projects) using a real-world dataset from Kaggle. Built with PostgreSQL and pgAdmin4.

---

## Overview

In this SQL project from, I practiced creating a database and a table and imported a csv file into pgAdmin4. I did not have any data cleaning for this analysis and used SQL queries to analyze the customer support tickets data to understand common issues and how they were handled. I worked with real-world support data to surface patterns and trends that inform customer service operations.

**Dataset:** [Customer Support Ticket Dataset](https://www.kaggle.com/datasets/suraj520/customer-support-ticket-dataset) — Kaggle  
**Tools:** PostgreSQL, pgAdmin4  
**Skills practiced:** DDL, DQL

---

## Objectives

- Practice writing basic SQL queries using SELECT, FROM, and WHERE
- Learn how to clean and filter data using logical operators and keywords
- Aggregate and summarize data using common SQL functions
- Gain confidence exploring real-world datasets with simple analysis

---

## What I Did

### 1. Database Setup (DDL)
- Created a relational database and table in PostgreSQL using `CREATE` to define the schema structure for the café sales dataset

### 2. Data Ingestion
- Imported the raw CSV file into PostgreSQL using `COPY`

### 3. Exploratory Data Analysis (DQL)
- Wrote analytical SQL queries to explore the dataset and surface customer support insights
- Used **aggregations** (`GROUP BY`, `HAVING`) to summarize trends
- Filtered and sorted results using `WHERE`, `DISTINCT`, `ORDER BY`, and `LIMIT`

---

## Files in This Repo

| File | Description |
|------|-------------|
| `customer_support_tickets.csv` | Original dataset |
| `table_creation.sql` | Script to create the database schema |
| `questions.sql` | Script for querying data to answer questions |

---

## Questions Asked:
- How many support tickets are in the dataset?
- What are the most common issue types reported?
- How many tickets were submitted through each support channel?
- What is the average resolution time across all tickets?
- How many tickets were resolved on the same day they were submitted?
- How many tickets were submitted each month?
- What is the total number of unresolved tickets?
- Which ticket types have the highest number of unresolved tickets?
- From the unresolved tickets for cancellation requests are they because we have not gotten to them or are we waiting on a customer’s response?
- How many unresolved tickets do we have per ticket priority level and are not waiting for a customer response?
- How many tickets were submitted for each ticket channel?
- How many of the tickets submitted for each ticket channel are unresolved?
- Which ticket channel that has a better average ticket resolution time?
- What is the average customer satisfaction level by ticket_type?

---

*Part of my data science portfolio — [View Portfolio](#)*