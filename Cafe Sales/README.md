# Café Sales — Data Cleaning & Exploration

A SQL-based data cleaning and exploratory analysis project using a synthetic dirty dataset from Kaggle. Built with PostgreSQL and pgAdmin4.

---

## Overview

This project uses a intentionally messy café sales dataset to practice core database and SQL skills — from building and structuring a database, to cleaning inconsistent data, to writing queries that surface meaningful business insights.

**Dataset:** [Café Sales Dirty Data for Cleaning Training](https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training) — Kaggle  
**Tools:** PostgreSQL, pgAdmin4  
**Skills practiced:** Using these DDL, DML, DQL SQL commands for data wrangling and exploration

---

## Objectives

- Practice **DDL (Data Definition Language)** commands: `CREATE`, `ALTER`
- Practice **DML (Data Manipulation Language)** commands: `COPY`, `UPDATE`
- Practice **DQL (Data Query Language)** commands: `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `DISTINCT`, `ORDER BY`, `LIMIT`, CTEs, and Window Functions

---

## What I Did

### 1. Database Setup (DDL)
- Created a relational database and table in PostgreSQL using `CREATE` to define the schema structure for the café sales dataset
- Used `ALTER` to modify the table structure as needed during the cleaning process

### 2. Data Ingestion & Cleaning (DML)
- Imported the raw CSV file into PostgreSQL using `COPY`
- Used `UPDATE` statements to standardize inconsistencies across the dataset, including fixing null values, correcting formatting issues, and standardizing categorical fields

### 3. Exploratory Data Analysis (DQL)
- Wrote SQL queries to explore the dataset and surface business insights
- Used **CTEs (Common Table Expressions)** to break down complex logic into readable steps
- Applied **window functions** to perform calculations across partitions of data
- Used **aggregations** (`GROUP BY`, `HAVING`) to summarize sales trends
- Filtered and sorted results using `WHERE`, `DISTINCT`, `ORDER BY`, and `LIMIT`

---

## Key Insights

- Identified top-selling menu items and peak sales periods through aggregation queries
- Used window functions to rank products and compare performance across categories
- Surfaced patterns in transaction data that could inform inventory and staffing decisions

---

## Files in This Repo

| File | Description |
|------|-------------|
| `dirty_cafe_sales.csv` | Original dirty dataset downloaded from Kaggle |
| `create_table.sql` | DDL script to create the database schema |
| `data_cleaning.sql` | DML script with all cleaning and standardization steps |
| `exploration_queries.sql` | DQL queries used for exploratory analysis |

---

## Future Ideas

One opportunity identified during the cleaning process: the `location` column contains two values — `In-store` and `Takeaway`. This could be encoded as a single binary feature:

```sql
ALTER TABLE cafe_sales ADD COLUMN take_out INT;

UPDATE cafe_sales
SET take_out = CASE
    WHEN location = 'Takeaway' THEN 1
    ELSE 0
END;
```

A single binary column (`take_out`: 1 = take-out, 0 = in-store) avoids multicollinearity and could be used as a feature in future regression or machine learning models.

---

## What I Learned

- How to structure and load data into PostgreSQL from a CSV file
- The importance of a cleaning process before any analysis
- How CTEs improve query readability for complex, multi-step logic
- How window functions enable powerful row-level calculations without collapsing data like `GROUP BY` does
- How to think ahead about feature engineering opportunities while working with data

---

*Part of my data science portfolio — [View Portfolio](#)*
