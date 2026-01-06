--KPI Metrics

-- Total revenue
SELECT SUM(sales) AS total_sales
FROM g_fact_sales;

-- Total quantity sold
SELECT SUM(quantity) AS total_quantity
FROM g_fact_sales;

-- Average selling price
SELECT AVG(price) AS avg_price
FROM g_fact_sales;

-- Total number of products
SELECT COUNT(DISTINCT product_name) AS total_products
FROM g_dim_products;

-- Total number of customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM g_dim_customers;

-- Total number of orders
SELECT COUNT(DISTINCT order_number) AS total_orders
FROM g_fact_sales;
