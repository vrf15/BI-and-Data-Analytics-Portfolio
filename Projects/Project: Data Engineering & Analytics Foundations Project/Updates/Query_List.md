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
```
