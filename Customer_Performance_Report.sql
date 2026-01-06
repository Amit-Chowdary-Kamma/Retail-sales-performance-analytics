-- Customer Performance Report

CREATE OR ALTER VIEW g_customer_report AS

WITH base_query AS (
    SELECT
        s.order_number,
        s.order_date,
        s.sales,
        s.quantity,
        c.customer_key,
        c.customer_id,
        c.first_name,
        c.last_name,
        c.gender,
        c.country,
        c.birth_date
    FROM g_fact_sales s
    JOIN g_dim_customers c
        ON s.customer_key = c.customer_key
    WHERE s.order_date IS NOT NULL
),

customer_aggregation AS (
    SELECT
        customer_key,
        customer_id,
        first_name,
        last_name,
        gender,
        country,
        birth_date,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT product_key) AS total_products,
        MAX(order_date) AS last_order_date,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) + 1 AS time_spam
    FROM base_query
    GROUP BY
        customer_key,
        customer_id,
        first_name,
        last_name,
        gender,
        country,
        birth_date
)

SELECT
    customer_key,
    customer_id,
    first_name,
    last_name,
    gender,
    country,
    birth_date,
    total_orders,
    total_sales,
    total_quantity,
    total_products,
    total_sales / NULLIF(total_orders, 0) AS avg_order_value,
    total_sales / NULLIF(time_spam, 0) AS avg_monthly_value,
    last_order_date,
    DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency,
    CASE
        WHEN DATEDIFF(YEAR, birth_date, GETDATE()) < 30 THEN 'Under 30'
        WHEN DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 30 AND 50 THEN '30-50'
        ELSE '50+'
    END AS age_group,
    CASE
        WHEN time_spam >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN time_spam >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS cust_segmentation,
    time_spam
FROM customer_aggregation;
