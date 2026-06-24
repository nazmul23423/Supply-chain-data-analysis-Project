-- Q1. How many total unique orders are in the dataset?
SELECT COUNT(DISTINCT "Order Id") AS Total_unique_order
FROM supply_chain

-- Q2. How many orders were placed under each Shipping Mode?
SELECT "Shipping Mode",
COUNT(*) AS Total_orders
FROM supply_chain
GROUP BY "Shipping Mode"

-- Q3. Which Customer Segment generated the highest total Sales?
SELECT "Customer Segment",
SUM("Sales") AS Total_Sales
FROM supply_chain
GROUP BY "Customer Segment"
ORDER BY Total_Sales DESC

-- Q4. What is the total count of late deliveries?
SELECT COUNT(*) AS Late_deliveries
FROM supply_chain
WHERE "Delivery Status"='Late delivery'

-- Q5. What are the Top 5 best-selling products by quantity?
SELECT "Product Name",
SUM("Order Item Quantity") AS Product_quantity
FROM supply_chain
GROUP BY "Product Name"
ORDER BY Product_quantity DESC
LIMIT 5

-- Q6. What is the total profit per Market?
SELECT "Market",
SUM("Order Profit Per Order") AS Total_profit
FROM supply_chain
GROUP BY "Market"

-- Q7. Show the breakdown of orders by Order Status with percentage share.
SELECT "Order Status",
COUNT(*) AS Order_Count,
   ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM supply_chain
GROUP BY "Order Status"
ORDER BY order_count DESC;

-- Q8. What is the average profit per order in each Department? (Only where Profit > 0)
SELECT "Department Name",
AVG("Order Profit Per Order") AS Average_profit,
COUNT(*) AS Total_orders
FROM supply_chain
WHERE "Order Profit Per Order">0
GROUP BY "Department Name"
ORDER BY Average_profit DESC


-- Q9. Which Order Region has the highest Late Delivery Rate?
SELECT "Order Region",
COUNT(*) AS Total_order,
SUM(CASE WHEN "Delivery Status" = 'Late Delivary' THEN 1 ELSE 0 END) AS Late_orders,
ROUND(
           SUM(CASE WHEN "Delivery Status" = 'Late delivery' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
           2
       ) AS late_delivery_rate
FROM supply_chain
GROUP BY "Order Region"
ORDER BY late_delivery_rate

-- Q10. What were the total Sales per month?
SELECT EXTRACT(MONTH FROM "order date") AS Monthly,
SUM("Sales") AS Total_Sales
FROM supply_chain
GROUP BY Monthly
ORDER BY Monthly ASC

-- Q11. What is the total Profit by Customer Segment and Shipping Mode combination?
SELECT "Customer Segment","Shipping Mode",
SUM("Order Profit Per Order") AS Total_Profit
FROM supply_chain
GROUP BY "Customer Segment","Shipping Mode"

-- Q12. Which products have made a net loss (total Profit < 0)?
SELECT "Product Name",
ROUND(SUM("Order Profit Per Order")::NUMERIC,2) AS Total_Profit
FROM supply_chain
GROUP BY "Product Name"
HAVING SUM("Order Profit Per Order")<0
ORDER BY Total_Profit ASC

-- Q13. What is the average delay (actual vs scheduled shipping days) per Shipping Mode?
SELECT "Shipping Mode",
ROUND(AVG("Days for shipping")::NUMERIC,2) AS avg_days_shipping,
ROUND(AVG("Days for shipment")::NUMERIC,2) AS avg_days_shipment,
ROUND(AVG("Days for shipping"-"Days for shipment")::NUMERIC,2) AS avg_dalevary_days
FROM supply_chain
GROUP BY "Shipping Mode"

-- Q14. What is the average discount rate per Category, and how does it relate to Sales and Profit?
SELECT "Category Name",
ROUND(AVG("Order Item Discount Rate")::NUMERIC,2) AS discount_rate,
ROUND(SUM("Sales")::NUMERIC,2) AS Total_Sales,
ROUND(SUM("Order Profit Per Order")::NUMERIC,2) AS Total_Profit
FROM supply_chain
GROUP BY "Category Name"
ORDER BY Total_Sales,Total_Profit DESC;

-- Q15. What is the top-selling product in each Order Region? (Window Function)
SELECT "Order Region","Product Name",
ROUND(SUM("Sales")::NUMERIC,2) AS Total_Sales,
DENSE_Rank() over(PARTITION BY "Order Region" ORDER BY SUM("Sales") DESC) AS rnk
FROM supply_chain
GROUP BY "Order Region","Product Name"
ORDER BY Total_Sales DESC;

-- Q16. What is the Month-over-Month Sales Growth? (LAG Function)
WITH monthly_sales AS (
    SELECT
        EXTRACT(MONTH FROM "order date") AS order_month,
        ROUND(SUM("Sales")::NUMERIC, 2) AS current_sales
    FROM supply_chain
    GROUP BY order_month
)
SELECT
    order_month,
    current_sales,
    LAG(current_sales) OVER (ORDER BY order_month)  AS prev_month_sales,
    ROUND(
        (current_sales - LAG(current_sales) OVER (ORDER BY order_month)) * 100.0
        / NULLIF(LAG(current_sales) OVER (ORDER BY order_month), 0),
        2
    ) AS mom_growth_pct
FROM monthly_sales
ORDER BY order_month;

-- Q17. Show the cumulative (running total) Sales per Market over time.
WITH market_monthly AS (
    SELECT "Market",
           EXTRACT(MONTH FROM "order date") AS order_month,
           SUM("Sales") AS monthly_sales
    FROM supply_chain
    GROUP BY "Market", order_month
)
SELECT "Market",
       order_month,
       ROUND(monthly_sales::NUMERIC, 2) AS monthly_sales,
       ROUND(SUM(monthly_sales) OVER (PARTITION BY "Market" ORDER BY order_month)::NUMERIC, 2) 
	   AS cumulative_sales
FROM market_monthly
ORDER BY order_month ASC;

-- Q18. Who are the Top 10 customers by total revenue? (Customer Lifetime Value)
SELECT "Customer Id","Customer fullname",
       COUNT(DISTINCT "Order Id") AS Total_orders,
       ROUND(SUM("Sales")::NUMERIC, 2) AS Total_revenue,
       ROUND(SUM("Order Profit Per Order")::NUMERIC, 2) AS Total_profit,
       ROUND(AVG("Sales")::NUMERIC, 2) AS avg_order_value
FROM supply_chain
GROUP BY "Customer Id", "Customer fullname"
ORDER BY Total_revenue DESC
LIMIT 10;

-- Q19. Among late delivery orders, which Shipping Mode lost the most profit? (Subquery)
SELECT "Shipping Mode",
       COUNT(*) AS late_order_count,
       ROUND(SUM("Order Profit Per Order")::NUMERIC, 2) AS total_profit_loss
FROM supply_chain s
WHERE "Order Id" IN (
    SELECT DISTINCT "Order Id"
    FROM supply_chain
    WHERE "Delivery Status" = 'Late delivery'
)
GROUP BY "Shipping Mode"
ORDER BY total_profit_loss ASC;

-- Q20. What is each Department's percentage contribution to total Sales?
WITH dept_sales AS (
    SELECT "Department Name",
           SUM("Sales") AS dept_total_sales
    FROM supply_chain
    GROUP BY "Department Name"
),
grand_total AS (
    SELECT SUM("Sales") AS overall_sales
    FROM supply_chain
)
SELECT d."Department Name",
       ROUND(d.dept_total_sales::NUMERIC, 2) AS dept_sales,
       ROUND(g.overall_sales::NUMERIC, 2) AS total_sales,
       (d.dept_total_sales * 100.0 / g.overall_sales, 2) AS contribution_pct
FROM dept_sales d
CROSS JOIN grand_total g
ORDER BY contribution_pct DESC;

