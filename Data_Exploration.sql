-- ================== Data Exploration ==================

-- Row counts
SELECT COUNT(*) AS sales_rows FROM g_fact_sales;
SELECT COUNT(*) AS customer_rows FROM g_dim_customers;
SELECT COUNT(*) AS product_rows FROM g_dim_products;

-- Distinct entity counts
SELECT COUNT(DISTINCT customer_key) AS distinct_customers_in_sales FROM g_fact_sales;
SELECT COUNT(DISTINCT product_key) AS distinct_products_in_sales FROM g_fact_sales;
SELECT COUNT(DISTINCT order_number) AS distinct_orders FROM g_fact_sales;

-- Null checks in fact table (key fields)
SELECT
  SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS null_order_date,
  SUM(CASE WHEN order_number IS NULL THEN 1 ELSE 0 END) AS null_order_number,
  SUM(CASE WHEN customer_key IS NULL THEN 1 ELSE 0 END) AS null_customer_key,
  SUM(CASE WHEN product_key IS NULL THEN 1 ELSE 0 END) AS null_product_key,
  SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS null_sales,
  SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
  SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price
FROM g_fact_sales;

-- Basic sanity checks for numeric fields
SELECT
  SUM(CASE WHEN sales < 0 THEN 1 ELSE 0 END) AS negative_sales_rows,
  SUM(CASE WHEN quantity <= 0 THEN 1 ELSE 0 END) AS non_positive_quantity_rows,
  SUM(CASE WHEN price < 0 THEN 1 ELSE 0 END) AS negative_price_rows
FROM g_fact_sales;

-- Find the range of available order dates
SELECT 
  MIN(order_date) AS first_order_date,
  MAX(order_date) AS last_order_date,
  DATEDIFF(DAY, MIN(order_date), MAX(order_date)) AS total_days
FROM g_fact_sales;

-- Monthly coverage (how many orders per month)
SELECT
  CONVERT(date, DATEADD(month, DATEDIFF(month, 0, order_date), 0)) AS order_month,
  COUNT(DISTINCT order_number) AS total_orders,
  COUNT(DISTINCT customer_key) AS distinct_customers,
  SUM(quantity) AS total_quantity,
  SUM(sales) AS total_sales
FROM g_fact_sales
WHERE order_date IS NOT NULL
GROUP BY CONVERT(date, DATEADD(month, DATEDIFF(month, 0, order_date), 0))
ORDER BY order_month;

-- Identify youngest and oldest customers
SELECT 
  MAX(DATEDIFF(YEAR, birth_date, GETDATE())) AS oldest_age,
  MIN(DATEDIFF(YEAR, birth_date, GETDATE())) AS youngest_age,
  MAX(birth_date) AS youngest_birth_date,
  MIN(birth_date) AS oldest_birth_date
FROM g_dim_customers
WHERE birth_date IS NOT NULL;

-- Age distribution buckets (quick profile)
SELECT
  CASE
    WHEN DATEDIFF(YEAR, birth_date, GETDATE()) < 25 THEN 'Under 25'
    WHEN DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 25 AND 34 THEN '25-34'
    WHEN DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 35 AND 44 THEN '35-44'
    WHEN DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 45 AND 54 THEN '45-54'
    ELSE '55+'
  END AS age_group,
  COUNT(*) AS customer_count
FROM g_dim_customers
WHERE birth_date IS NOT NULL
GROUP BY
  CASE
    WHEN DATEDIFF(YEAR, birth_date, GETDATE()) < 25 THEN 'Under 25'
    WHEN DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 25 AND 34 THEN '25-34'
    WHEN DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 35 AND 44 THEN '35-44'
    WHEN DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 45 AND 54 THEN '45-54'
    ELSE '55+'
  END
ORDER BY customer_count DESC;

-- Top countries by customer count
SELECT TOP 10
  country,
  COUNT(DISTINCT customer_id) AS total_customers
FROM g_dim_customers
GROUP BY country
ORDER BY total_customers DESC;

-- Top product categories by product count
SELECT
  category,
  COUNT(*) AS total_products
FROM g_dim_products
GROUP BY category
ORDER BY total_products DESC;

-- Check for duplicate customer_id records
SELECT
  customer_id,
  COUNT(*) AS duplicate_count
FROM g_dim_customers
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- Check for duplicate product_id records
SELECT
  product_id,
  COUNT(*) AS duplicate_count
FROM g_dim_products
GROUP BY product_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;
