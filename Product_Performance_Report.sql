-- Product Performance Report

CREATE OR ALTER VIEW g_product_report AS

WITH base_query AS (
    SELECT
        s.order_number,
        s.order_date,
        s.sales,
        s.quantity,
        p.product_key,
        p.product_id,
        p.product_name,
        p.category,
        p.sub_category
    FROM g_fact_sales s
    JOIN g_dim_products p
        ON s.product_key = p.product_key
    WHERE s.order_date IS NOT NULL
),

product_aggregation AS (
    SELECT
        product_key,
        product_id,
        product_name,
        category,
        sub_category,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT customer_key) AS total_customers,
        MAX(order_date) AS last_sale_date,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) + 1 AS time_spam
    FROM base_query
    GROUP BY
        product_key,
        product_id,
        product_name,
        category,
        sub_category
)

SELECT
    product_key,
    product_id,
    product_name,
    category,
    sub_category,
    total_orders,
    total_sales,
    total_quantity,
    total_customers,
    total_sales / NULLIF(total_quantity, 0) AS avg_selling_price,
    total_sales / NULLIF(total_orders, 0) AS avg_order_revenue,
    total_sales / NULLIF(time_spam, 0) AS avg_monthly_revenue,
    last_sale_date,
    DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency,
    CASE
        WHEN total_sales > 50000 THEN 'High Performer'
        WHEN total_sales > 10000 THEN 'Mid Performer'
        ELSE 'Low Performer'
    END AS product_segment,
    time_spam
FROM product_aggregation;
