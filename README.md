# Retail Sales Performance Analytics
SQL Server (T-SQL) | Business KPIs | Customer and Product Insights

---

## Project Overview

This project demonstrates how SQL can be used as a complete analytical tool, not only for querying data but for building analytical layers, defining business KPIs, and supporting data-driven decision-making.

Using a high-volume retail transactional dataset, the project implements a structured SQL-based analytics workflow to analyze sales performance, customer behavior, and product effectiveness. All analysis is performed entirely in SQL Server (T-SQL), reflecting how analytics is commonly conducted directly inside databases and data warehouses in real-world environments.

---

## Business Problem

Retail organizations often accumulate large volumes of transactional data but struggle to transform it into clear, actionable insights. Common challenges include:

- Lack of standardized KPIs for tracking business performance
- Limited visibility into customer value and purchasing behavior
- Difficulty evaluating product performance across categories and time
- Ad-hoc analysis that does not scale or support consistent decision-making

This project addresses these challenges by creating a repeatable, SQL-driven analytics framework that converts raw transactional data into structured insights.

---

## What This Project Solves

This project enables stakeholders to:

1. Track core business KPIs such as revenue, order volume, customer count, and product count
2. Analyze customer performance, including spending behavior, recency, and segmentation
3. Evaluate product performance using revenue, quantity sold, and customer reach
4. Identify trends over time through monthly and yearly analysis
5. Rank top and bottom performing customers and products
6. Perform part-to-whole analysis by category, country, and segment
7. Validate data quality through structured data exploration and sanity checks
8. Support business decisions using SQL-based analytical views rather than spreadsheets
9. Enable scalable and repeatable reporting logic within the database
10. Demonstrate how SQL alone can power meaningful business analytics

---

## Dataset

- Public retail dataset sourced from Kaggle
- Includes customer, product, and transactional sales tables
- Data is used locally to execute SQL scripts

Data Source

This project uses a synthetic retail dataset designed to resemble real-world
sales, customer, and product data. The data is assumed to be preloaded into a
relational database to focus on SQL-based analysis and business insights.

---

## Tech Stack

- Database: SQL Server
- Language: T-SQL

Core concepts used:
- Joins and aggregations
- Common Table Expressions (CTEs)
- Window functions
- Analytical views
- Time-based analysis
- Business KPI modeling

---

## Analytical Workflow

### 1. Schema and Data Exploration
- Review table structures and relationships
- Validate row counts and key distributions
- Identify date ranges, customer demographics, and product coverage
- Perform null checks, duplicate checks, and sanity validation

### 2. Data Exploration
- Analyze date coverage and data completeness
- Review customer age distribution and geographic spread
- Validate numeric fields and detect anomalies
- Establish baseline understanding of the dataset

### 3. KPI Definition
- Define reusable business KPIs such as:
  - Total sales
  - Total orders
  - Total customers
  - Total products
  - Average price and quantity

### 4. Business Summary Metrics
- Generate a consolidated snapshot of headline business metrics
- Support high-level performance reviews and executive summaries

### 5. Customer Performance Reporting
- Aggregate customer-level metrics including:
  - Total spend
  - Order frequency
  - Product diversity
  - Recency
- Segment customers into business-relevant categories such as VIP, Regular, and New

### 6. Product Performance Reporting
- Evaluate product effectiveness using:
  - Revenue
  - Quantity sold
  - Customer reach
  - Lifecycle duration
- Classify products based on performance tiers

### 7. Ranking and Magnitude Analysis
- Identify top and bottom performers across customers and products
- Analyze distributions by country, category, and demographic attributes
- Support prioritization and targeting strategies

### 8. Advanced Analytical Insights
- Perform time-series analysis at monthly and yearly levels
- Compute running totals and moving averages
- Compare performance against historical benchmarks
- Support trend and growth evaluation

---

## Repository Structure

```text
Retail-sales-performance-analytics/
├── Schema_Exploration.sql
├── Data_Exploration.sql
├── KPI_Metrics.sql
├── Business_Summary_Metrics.sql
├── Customer_Performance_Report.sql
├── Customer_Performance_Analysis.sql
├── Product_Performance_Report.sql
├── Ranking_Analysis.sql
├── Magnitude_Analysis.sql
└── Advanced_Analysis.sql
```

Each script focuses on a specific analytical objective, making the project modular, readable, and easy to extend.

---

## Why This Project Matters

- Demonstrates business-first SQL thinking, not just syntax
- Shows how analytics can be performed directly inside the database
- Reflects workflows used by Data Analysts, Business Analysts, and Analytics Engineers
- Scales beyond simple queries into structured decision-support analytics
- Highlights the power of SQL for building end-to-end analytical solutions

---

## Key Takeaway

This project illustrates how SQL can be used to transform raw transactional data into actionable business insights, enabling better understanding of customers, products, and performance without relying on external tools.
