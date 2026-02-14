# Query List
This document contains every SQL query used in the Superstore Analytics project.  
Queries are organized by analysis section for clarity, reproducibility, and auditability.

---
# 2026-2-13
```sql
-- ============================
--  QUERY LIST (SUPERSTORE)
--  One Continuous Markdown Block
-- ============================

-- 1. CORE METRICS
SELECT SUM(sales) AS total_sales
FROM staging.superstore;

SELECT SUM(profit) AS total_profit
FROM staging.superstore;

SELECT SUM(quantity) AS total_quantity
FROM staging.superstore;

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM staging.superstore;

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM staging.superstore;

SELECT AVG(discount) AS avg_discount
FROM staging.superstore;

SELECT SUM(profit) / SUM(sales) AS avg_profit_margin
FROM staging.superstore;


-- 2. CATEGORY ANALYSIS
SELECT
    category,
    SUM(sales) AS total_sales
FROM staging.superstore
GROUP BY category
ORDER BY total_sales DESC;

SELECT
    category,
    SUM(profit) AS total_profit
FROM staging.superstore
GROUP BY category
ORDER BY total_profit DESC;

SELECT
    category,
    SUM(profit) / SUM(sales) AS profit_margin
FROM staging.superstore
GROUP BY category
ORDER BY profit_margin DESC;
```
---
# 2026-2-13

```sql
-- 3. REGION ANALYSIS
SELECT
    region,
    SUM(sales) AS total_sales
FROM staging.superstore
GROUP BY region
ORDER BY total_sales DESC;

SELECT
    region,
    SUM(profit) AS total_profit
FROM staging.superstore
GROUP BY total_profit DESC;

SELECT
    region,
    SUM(profit) / SUM(sales) AS profit_margin
FROM staging.superstore
GROUP BY region
ORDER BY profit_margin DESC;


-- 4. SEGMENT ANALYSIS
SELECT
    segment,
    SUM(sales) AS total_sales
FROM staging.superstore
GROUP BY segment
ORDER BY total_sales DESC;

SELECT
    segment,
    SUM(profit) AS total_profit
FROM staging.superstore
GROUP BY segment
ORDER BY total_profit DESC;

SELECT
    segment,
    SUM(profit) / SUM(sales) AS profit_margin
FROM staging.superstore
GROUP BY segment
ORDER BY profit_margin DESC;

SELECT
    segment,
    SUM(sales) AS total_sales
FROM "STAGING".superstore
GROUP BY segment
ORDER BY total_sales DESC;

SELECT
    segment,
    SUM(profit) / SUM(sales) AS profit_margin
FROM "STAGING".superstore
GROUP BY segment
ORDER BY profit_margin DESC;

SELECT
    customer_name,
    SUM(sales) AS total_sales
FROM "STAGING".superstore
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

CREATE TABLE "CORE".dim_customers AS
SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM "STAGING".superstore;

CREATE TABLE "CORE".dim_products AS
SELECT DISTINCT
    product_id,
    product_name,
    category,
    sub_category
FROM "STAGING".superstore;

CREATE TABLE "CORE".fct_sales AS
SELECT
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    product_id,
    region,
    state,
    city,
    postal_code,
    sales,
    quantity,
    discount,
    profit
FROM "STAGING".superstore;

SELECT COUNT(*) FROM "STAGING".superstore;
SELECT COUNT(*) FROM "CORE".fct_sales;

SELECT customer_id, COUNT(*) 
FROM "CORE".dim_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*) 
FROM "CORE".dim_products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT MIN(date), MAX(date) FROM "CORE".dim_dates;

CREATE TABLE "ANALYTICS".sales_by_category AS
SELECT
    p.category,
    SUM(f.sales) AS total_sales,
    SUM(f.profit) AS total_profit,
    SUM(f.profit) / NULLIF(SUM(f.sales), 0) AS profit_margin
FROM "CORE".fct_sales f
JOIN "CORE".dim_products p
    ON f.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

CREATE TABLE "ANALYTICS".sales_by_region AS
SELECT
    f.region,
    SUM(f.sales) AS total_sales,
    SUM(f.profit) AS total_profit,
    SUM(f.profit) / NULLIF(SUM(f.sales), 0) AS profit_margin
FROM "CORE".fct_sales f
GROUP BY f.region
ORDER BY total_sales DESC;

CREATE TABLE "ANALYTICS".sales_by_segment AS
SELECT
    c.segment,
    SUM(f.sales) AS total_sales,
    SUM(f.profit) AS total_profit,
    SUM(f.profit) / NULLIF(SUM(f.sales), 0) AS profit_margin
FROM "CORE".fct_sales f
JOIN "CORE".dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY total_sales DESC;

CREATE TABLE "ANALYTICS".monthly_sales AS
SELECT
    DATE_TRUNC('month', f.order_date) AS month,
    SUM(f.sales) AS total_sales,
    SUM(f.profit) AS total_profit
FROM "CORE".fct_sales f
GROUP BY DATE_TRUNC('month', f.order_date)
ORDER BY month;

CREATE TABLE "ANALYTICS".monthly_profit AS
SELECT
    DATE_TRUNC('month', f.order_date) AS month,
    SUM(f.profit) AS total_profit,
    SUM(f.sales) AS total_sales,
    SUM(f.profit) / NULLIF(SUM(f.sales), 0) AS profit_margin
FROM "CORE".fct_sales f
GROUP BY DATE_TRUNC('month', f.order_date)
ORDER BY month;

CREATE TABLE "ANALYTICS".yoy_sales AS
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(sales) AS total_sales
    FROM "CORE".fct_sales
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT
    month,
    total_sales,
    LAG(total_sales, 12) OVER (ORDER BY month) AS sales_last_year,
    (total_sales - LAG(total_sales, 12) OVER (ORDER BY month)) AS yoy_change,
    (total_sales - LAG(total_sales, 12) OVER (ORDER BY month)) 
        / NULLIF(LAG(total_sales, 12) OVER (ORDER BY month), 0) AS yoy_growth_rate
FROM monthly
ORDER BY month;

```
