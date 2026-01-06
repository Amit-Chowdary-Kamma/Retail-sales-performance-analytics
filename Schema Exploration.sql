/* Schema Exploration */

-- Preview customer table
SELECT TOP 10 *
FROM g_dim_customers;

-- Preview product table
SELECT TOP 10 *
FROM g_dim_products;

-- Preview sales fact table
SELECT TOP 10 *
FROM g_fact_sales;

-- Row counts
SELECT COUNT(*) AS customer_count
FROM g_dim_customers;

SELECT COUNT(*) AS product_count
FROM g_dim_products;

SELECT COUNT(*) AS sales_count
FROM g_fact_sales;

-- Column metadata for customer table
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'g_dim_customers';

-- Column metadata for product table
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'g_dim_products';

-- Column metadata for sales table
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'g_fact_sales';
