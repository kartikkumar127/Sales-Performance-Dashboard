-- SALES PERFORMANCE ANALYSIS

-- Database : sales_db
-- Table    : sales
-- Tool     : MySQL
-- Purpose  : Analyze sales, profit, customers, products,
--            regions, categories, discounts and shipping

USE sales_db;


-- 1. BASIC DATA CHECKS

-- Check number of records

SELECT COUNT(*) AS total_rows
FROM sales;

-- Preview the data

SELECT *
FROM sales
LIMIT 10;

-- Check table structure

DESCRIBE sales;



-- 2. OVERALL BUSINESS KPIs

SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales;


-- 3. SALES BY CATEGORY

SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity
FROM sales
GROUP BY category
ORDER BY total_sales DESC;


-- 4. SALES BY REGION

SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY region
ORDER BY total_sales DESC;


-- 5. SALES BY SUB-CATEGORY

SELECT
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity
FROM sales
GROUP BY sub_category
ORDER BY total_sales DESC;



-- 6. TOP 10 PRODUCTS BY SALES

SELECT
    product_name,
    SUM(sales) AS total_sales
FROM sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;



-- 7. TOP 10 PRODUCTS BY PROFIT

SELECT
    product_name,
    SUM(profit) AS total_profit
FROM sales
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;



-- 8. LOSS-MAKING PRODUCTS

SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit ASC
LIMIT 10;



-- 9. SALES BY CUSTOMER SEGMENT

SELECT
    segment,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY segment
ORDER BY total_sales DESC;



-- 10. MONTHLY SALES TREND

SELECT
    year_month,
    SUM(sales) AS total_sales
FROM sales
GROUP BY year_month
ORDER BY year_month;



-- 11. MONTHLY PROFIT TREND

SELECT
    year_month,
    SUM(profit) AS total_profit
FROM sales
GROUP BY year_month
ORDER BY year_month;



-- 12. YEARLY SALES PERFORMANCE

SELECT
    year AS order_year,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY year
ORDER BY order_year;



-- 13. YEAR + MONTH SALES TREND

SELECT
    year AS order_year,
    month AS order_month,
    SUM(sales) AS total_sales
FROM sales
GROUP BY year, month
ORDER BY order_year, order_month;



-- 14. DISCOUNT VS PROFIT

SELECT
    discount,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY discount
ORDER BY discount;



-- 15. DISCOUNT LEVEL PROFITABILITY

SELECT
    discount,
    COUNT(*) AS number_of_records,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales
GROUP BY discount
ORDER BY discount;



-- 16. SHIPPING MODE PERFORMANCE

SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(shipping_days), 2) AS average_shipping_days
FROM sales
GROUP BY ship_mode
ORDER BY average_shipping_days;



-- 17. SHIPPING MODE + PROFITABILITY

SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(AVG(shipping_days), 2) AS average_shipping_days
FROM sales
GROUP BY ship_mode
ORDER BY total_sales DESC;



-- 18. TOP 10 CUSTOMERS BY SALES

SELECT
    customer_id,
    customer_name,
    SUM(sales) AS total_sales
FROM sales
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 10;



-- 19. TOP 10 CUSTOMERS BY PROFIT

SELECT
    customer_id,
    customer_name,
    SUM(profit) AS total_profit
FROM sales
GROUP BY customer_id, customer_name
ORDER BY total_profit DESC
LIMIT 10;



-- 20. LOSS-MAKING CUSTOMERS

SELECT
    customer_id,
    customer_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY customer_id, customer_name
HAVING SUM(profit) < 0
ORDER BY total_profit ASC
LIMIT 10;



-- 21. CITY PERFORMANCE

SELECT
    city,
    state,
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY city, state, region
ORDER BY total_sales DESC
LIMIT 10;



-- 22. STATE PERFORMANCE

SELECT
    state,
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY state, region
ORDER BY total_sales DESC
LIMIT 10;



-- 23. PROFITABLE SUB-CATEGORIES

SELECT
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY sub_category
HAVING SUM(profit) > 0
ORDER BY total_profit DESC;



-- 24. LOSS-MAKING SUB-CATEGORIES

SELECT
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;



-- 25. CATEGORY + REGION ANALYSIS

SELECT
    category,
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY category, region
ORDER BY total_sales DESC;



-- 26. SEGMENT + CATEGORY ANALYSIS

SELECT
    segment,
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY segment, category
ORDER BY total_sales DESC;



-- 27. PRODUCT PROFIT MARGIN

SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2)
        AS profit_margin_percentage
FROM sales
GROUP BY product_name
ORDER BY profit_margin_percentage DESC
LIMIT 10;



-- 28. ORDERS BY SHIPPING DAYS

SELECT
    shipping_days,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY shipping_days
ORDER BY shipping_days;



-- 29. SALES BY SHIP MODE AND REGION

SELECT
    ship_mode,
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY ship_mode, region
ORDER BY total_sales DESC;



-- 30. HIGH DISCOUNT ORDERS

SELECT
    order_id,
    product_name,
    discount,
    sales,
    profit
FROM sales
WHERE discount >= 0.50
ORDER BY discount DESC;



-- 31. NEGATIVE PROFIT TRANSACTIONS

SELECT
    order_id,
    product_name,
    sales,
    discount,
    profit
FROM sales
WHERE profit < 0
ORDER BY profit ASC
LIMIT 20;



-- 32. SALES AND PROFIT BY YEAR

SELECT
    year AS order_year,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2)
        AS profit_margin_percentage
FROM sales
GROUP BY year
ORDER BY order_year;



-- 33. SALES BY REGION AND SEGMENT

SELECT
    region,
    segment,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY region, segment
ORDER BY total_sales DESC;



-- 34. PRODUCT COUNT BY CATEGORY

SELECT
    category,
    COUNT(DISTINCT product_id) AS unique_products
FROM sales
GROUP BY category
ORDER BY unique_products DESC;


-- 35. CUSTOMER COUNT BY SEGMENT

SELECT
    segment,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM sales
GROUP BY segment
ORDER BY unique_customers DESC;
