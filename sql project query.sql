TRUNCATE TABLE orders;

SELECT COUNT(*) FROM orders;

SELECT *
FROM orders
ORDER BY row_id DESC;

DELETE FROM orders
WHERE row_id IS NULL

SELECT COUNT(*) FROM orders;
SELECT * FROM orders LIMIT 10;

SELECT SUM(sales)AS total_sales FROM orders;

SELECT SUM(profit)AS total_profit FROM orders;
SELECT SUM(quantity)AS total_quantity FROM orders;
SELECT AVG(discount)AS average_discount FROM orders;
SELECT MAX(sales)AS highest_sales FROM orders;
SELECT MIN(sales)AS lowest_sales FROM orders;
-------------------------------------------------------------------------------------------------------
ANALYSIS 1: SALES ANALYSIS 
-------------------------------------------------------------------------------------------------------
1.TOTAL SALE BY REGION
SELECT region,
SUM(sales) AS total_sales
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

2.TOTAL SALE BY STATE
SELECT state,
       SUM(sales) AS total_sales
FROM orders
GROUP BY state
ORDER BY total_sales DESC;

3.TOTAL SALE BY CATEGORY 
SELECT category,
       SUM(sales) AS total_sales
FROM orders
GROUP BY category
ORDER BY total_sales DESC;
4.TOP 10 CUSTOMER BY SALE 
SELECT customer_name,
       SUM(sales) AS total_sales
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;
5.TOP 10 PRODUCT BY SALE 
SELECT product_name,
       SUM(sales) AS total_sales
FROM orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;
------------------------------------------------------------------------------------------------------------------
PROFIT ANALYSIS
------------------------------------------------------------------------------------------------------------------
  1.TOTAL PROFIT BY REGION 
 SELECT region,
       SUM(profit) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_profit DESC;

2.TOTAL PROFIT BY STATE
SELECT state,
       SUM(profit) AS total_profit
FROM orders
GROUP BY state
ORDER BY total_profit DESC;

3,TOTAL PROFIT BY CATEGORY
SELECT category,
       SUM(profit) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_profit DESC;

4.TOTAL PROFIT BY SUB CATEGORY
SELECT sub_category,
       SUM(profit) AS total_profit
FROM orders
GROUP BY sub_category
ORDER BY total_profit DESC;

5.top 10 customer by profit
SELECT customer_name,
       SUM(profit) AS total_profit
FROM orders
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 10;

 6.TOP 10 PRODUCT BY PROFIT
SELECT product_name,
       SUM(profit) AS total_profit
FROM orders
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

7.LOSS MAKING PRODUCT
SELECT product_name,
       SUM(profit) AS total_profit
FROM orders
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;
----------------------------------------------------------------------------------------------------------
 BASIC CUSTOMER SEGMENT ANALYSIS:
----------------------------------------------------------------------------------------------------------
 PROBLEM 1: WHICH CUTOMER SEGMENT GENERATES THE HIGHEST TOTAL SALE AND PROFIT?
 SELECT
    segment,
    SUM(sales) AS total_sale,
    SUM(profit) AS total_profit
FROM orders
GROUP BY segment
ORDER BY total_sale DESC, total_profit DESC;

PROBLEM 2:
Which customer segment has the highest average profit per order?

SELECT segment,AVG(profit) AS average_profit FROM orders GROUP BY segment ORDER BY average_profit DESC;

PROBLEM:3
Which customer segment has placed the highest number of orders?
SELECT segment, COUNT(*) AS total_order FROM orders GROUP BY segment ORDER BY total_order DESC;

PROBLEM 4:
Which customer segment has the highest average sales per order?
SELECT segment, AVG(sales) AS average_sales FROM orders GROUP BY segment ORDER BY average_sales DESC;

PROBLEM 5:
Which customer segment has sold the highest total quantity of products?
SELECT segment, SUM(quantity) AS total_quantity FROM orders GROUP BY segment ORDER BY total_quantity DESC;

PROBLEM 6:
Which customer segment receive the highest average profit ?
SELECT segment, AVG(discount) AS average_discount FROM orders GROUP BY segment ORDER BY average_discount DESC;
-------------------------------------------------------------------------------------------------------------------
 ADVANCED CUSTOMER SEGMENT ANALYSIS :
 PROBLEM 1:
 Business Scenario
The company wants to classify its customer segments based on total sales performance so that the marketing team can plan different strategies.

Business Rules:
High Sales → Total Sales ≥ 700000
Medium Sales → Total Sales between 500000 and 699999
Low Sales → Total Sales < 500000
QUERY:
SELECT segment, SUM(sales) AS total_sales,
CASE
WHEN SUM(sales) > 700000 THEN 'Highest Sale'
WHEN SUM(sales) BETWEEN 500000 AND 699999 THEN 'Medium Sale'
ELSE 'lowest sale'
END AS sale_category
FROM orders
GROUP BY segment
ORDER BY total_sales DESC;

PROBLEM 2:
Rank the customer segments based on their total sales from highest to lowest.
QUERY:
SELECT segment,
SUM(sales) AS total_sales,
RANK() OVER (ORDER BY SUM(sales) DESC) AS segment_rank 
FROM orders
GROUP BY segment
ORDER BY segment_rank;

 PROBLEM 3:
 The management wants to identify only the customer segments whose total sales are greater than ₹500,000.
 QUERY:
 WITH segment_sale AS (
    SELECT
        segment,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY segment
)
SELECT *
FROM segment_sale
WHERE total_sales > 500000
ORDER BY total_sales DESC;

PROBLEM 4:
Find the customer segments whose total sales are greater than the average total sales of all customer segments.
SELECT
    segment,
    SUM(sales) AS total_sales
FROM orders
GROUP BY segment
HAVING SUM(sales) >
(
    SELECT AVG(total_sales)
    FROM
    (
     SELECT segment,
     SUM(sales) AS total_sales
     FROM orders
     GROUP BY segment
    ) AS segment_totals
);  
-----------------------------------------------------------------------------------------------------------------------
Regional Analysis - Basic Business Analysis:

PROBLEM 1:
Which region generates the highest total sales and total profit for the company?
QUERY:
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_sales DESC, total_profit DESC;

PROBLEM 2:
Which region has the highest average profit per order?
QUERY:
SELECT region,
    AVG(profit) AS average_profit
FROM orders
GROUP BY region
ORDER BY average_profit DESC;

PROBLEM 3:
Which region has the highest number of orders?
QUERY:
SELECT region,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY region
ORDER BY total_orders DESC;

Problem 4

Which region has the highest average sales per order?
SELECT region,
    AVG(sales) AS average_sales
FROM orders
GROUP BY region
ORDER BY average_sales DESC;

Problem 5

Which region sold the highest total quantity of products?
QUERY:
SELECT region,
    SUM(quantity) AS total_quantity
FROM orders
GROUP BY region
ORDER BY total_quantity DESC;

Problem 6

Which region offers the highest average discount to customers?
QUERY:
SELECT region,
    AVG(discount) AS average_discount
FROM orders
GROUP BY region
ORDER BY average_discount DESC;


ADVANCED BUSINESS ANALYSIS:
PRONBLEM 1:
Classify each region based on total sales.

Business Rules
High Sales → Total Sales ≥ 700,000
Medium Sales → Total Sales between 500,000 and 699,999
Low Sales → Total Sales < 500,000
QUERY:
SELECT region,
    SUM(sales) AS total_sales,
    CASE
        WHEN SUM(sales) >= 700000 THEN 'High Sales'
        WHEN SUM(sales) BETWEEN 500000 AND 699999 THEN 'Medium Sales'
        ELSE 'Low Sales'
    END AS sales_category
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

PROBLEM 2:
Rank the regions based on total sales from highest to lowest?

QUERY:
SELECT region,
    SUM(sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_segment
FROM orders
GROUP BY region
ORDER BY sales_segment;

PROBLEM :3
Management wants to identify only those regions whose total sales are greater than ₹500,000.
QUERY:
WITH region_sales AS (
    SELECT
        region,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY region
)
SELECT *
FROM region_sales
WHERE total_sales > 500000
ORDER BY total_sales DESC;
PROBLEM 4:
Find the regions whose total sales are greater than the average total sales of all regions.
QUERY:
SELECT
    region,
    SUM(sales) AS total_sales
FROM orders
GROUP BY region
HAVING SUM(sales) >
(
    SELECT AVG(total_sales)
    FROM
    (
        SELECT
            region,
            SUM(sales) AS total_sales
        FROM orders
        GROUP BY region
    ) AS region_totals
)
ORDER BY total_sales DESC;
---------------------------------------------------------------------------------------------
CATEGORY ANALYSIS

PROBLEM 1:
Which product category generated the highest total sales and total profit?
QUERY:
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_sales DESC, total_profit DESC;

PROBLEM 2:
Classify each category based on total profit.

Business Rules
High Profit → Profit ≥ 130000
Medium Profit → Profit between 50000 and 129999
Low Profit → Profit < 50000
QUERY:
SELECT
    category,
    SUM(profit) AS total_profit,
    CASE
        WHEN SUM(profit) >= 130000 THEN 'High Profit'
        WHEN SUM(profit) BETWEEN 50000 AND 129999 THEN 'Medium Profit'
        ELSE 'Low Profit'
    END AS profit_category
FROM orders
GROUP BY category
ORDER BY total_profit DESC;

PROBLEM 3:
Rank the product categories based on total profit from highest to lowest.
QUERY:
SELECT
    category,
    SUM(profit) AS total_profit,
    RANK() OVER (ORDER BY SUM(profit) DESC) AS profit_rank
FROM orders
GROUP BY category
ORDER BY profit_rank;

PROBLEM 4:
Find the categories whose total profit is greater than the average total profit of all categories.
QUERY:
SELECT
    category,
    SUM(profit) AS total_profit
FROM orders
GROUP BY category
HAVING SUM(profit) >
(
    SELECT AVG(total_profit)
    FROM
    (
        SELECT
            category,
            SUM(profit) AS total_profit
        FROM orders
        GROUP BY category
    ) AS category_totals
)
ORDER BY total_profit DESC;
-----------------------------------------------------------------------------------------------------------
SUB_CATEGORY ANALYSIS 
PROBLEM 1:
Which are the Top 5 sub-categories based on total sales?
QUERY:
SELECT
    sub_category,
    SUM(sales) AS total_sales
FROM orders
GROUP BY sub_category
ORDER BY total_sales DESC
LIMIT 5;

PROBLEM 2:
Rank all sub-categories based on total profit from highest to lowest.
QUERY:
SELECT
    sub_category,
    SUM(profit) AS total_profit,
    RANK() OVER (ORDER BY SUM(profit) DESC) AS subcategory_rank
FROM orders
GROUP BY sub_category
ORDER BY subcategory_rank;

PROBLEM 3:
Find the sub-categories whose total profit is greater than ₹30,000.
QUERY:
SELECT
    sub_category,
    SUM(profit) AS total_profit
FROM orders
GROUP BY sub_category
HAVING SUM(profit) > 30000
ORDER BY total_profit DESC;

PROBLEM 4:
Find the sub-categories whose total sales exceed ₹200,000 using a CTE.
QUERY:
WITH sub_category_sales AS (
    SELECT
        sub_category,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY sub_category
)
SELECT *
FROM sub_category_sales
WHERE total_sales > 200000
ORDER BY total_sales DESC;
-----------------------------------------------------------------------------------------------------------------
CUSTOMER ANALYSIS 

PROBLEM 1:
Who are the Top 10 customers based on total sales?
QUERY:
SELECT
    customer_name,
    SUM(sales) AS total_sales
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

PROBLEM 2:
Rank customers based on their total sales from highest to lowest.
QUERY:
SELECT
    customer_name,
    SUM(sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS customer_rank
FROM orders
GROUP BY customer_name
ORDER BY customer_rank;

PROBLEM 3:
Find customers whose total sales are greater than ₹10,000.
QUERY:
SELECT
    customer_name,
    SUM(sales) AS total_sales
FROM orders
GROUP BY customer_name
HAVING SUM(sales) > 10000
ORDER BY total_sales DESC;

PROBLEM 4:
Classify customers based on their total sales.

Business Rules
 Premium Customer → Total Sales ≥ 15,000
 Regular Customer → Total Sales between 8,000 and 14,999
 Standard Customer → Total Sales < 8,000
QUERY:
SELECT
    customer_name,
    SUM(sales) AS total_sales,
    CASE
        WHEN SUM(sales) >= 15000 THEN 'Premium Customer'
        WHEN SUM(sales) BETWEEN 8000 AND 14999 THEN 'Regular Customer'
        ELSE 'Standard Customer'
    END AS customer_range
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC;
-----------------------------------------------------------

SHIPPING ANALYSIS:

PROBLEM 1:
Which shipping mode generated the highest total sales and total profit?
QUERY:
SELECT
    ship_mode,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY ship_mode
ORDER BY total_sales DESC, total_profit DESC;

PROBLEM 2:
Find the average sales for each shipping mode and rank them from highest to lowest.
QUERY:
SELECT
    ship_mode,
    AVG(sales) AS average_sales,
    RANK() OVER (ORDER BY AVG(sales) DESC) AS ship_mode_rank
FROM orders
GROUP BY ship_mode
ORDER BY ship_mode_rank;




