-- Top 5 revenue-generating products
SELECT TOP 5
    p.product_name,
    SUM(f.sales) AS total_revenue
FROM g_fact_sales f
LEFT JOIN g_dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Bottom 5 products by revenue
SELECT TOP 5
    p.product_name,
    SUM(f.sales) AS total_revenue
FROM g_fact_sales f
LEFT JOIN g_dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC;

-- Top 10 customers by revenue
SELECT TOP 10
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(f.sales) AS total_sales
FROM g_fact_sales f
LEFT JOIN g_dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_sales DESC;

-- 3 customers with the fewest orders
SELECT TOP 3
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT order_number) AS total_orders
FROM g_fact_sales f
LEFT JOIN g_dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_orders ASC;
