-- ============================================
-- AMAZON GLOBAL SALES ANALYTICS
-- SQL Analytical Queries for Portfolio
-- ============================================
-- Author: Johari Frias
-- Database: PostgreSQL / SQL Server
-- Dataset: Amazon Sales Data (50K+ records)
-- ============================================
-- =============================================
-- QUERY 1: REGIONAL MONTH-OVER-MONTH GROWTH
-- Technique: CTEs, Window Functions (LAG)
-- Business Question: Which regions are growing 
-- fastest and are there seasonal patterns?
-- =============================================
WITH monthly_revenue AS (
    SELECT Region,
        DATE_TRUNC('month', OrderDate) AS order_month,
        SUM(Revenue_USD) AS total_revenue,
        COUNT(DISTINCT "Order Id") AS order_count,
        SUM(Profit) AS total_profit
    FROM amazon_sales
    WHERE Order_Status = 'Completed'
    GROUP BY Region,
        DATE_TRUNC('month', OrderDate)
),
growth_analysis AS (
    SELECT Region,
        order_month,
        total_revenue,
        order_count,
        total_profit,
        LAG(total_revenue) OVER (
            PARTITION BY Region
            ORDER BY order_month
        ) AS prev_month_revenue,
        ROUND(
            (
                total_revenue - LAG(total_revenue) OVER (
                    PARTITION BY Region
                    ORDER BY order_month
                )
            ) / NULLIF(
                LAG(total_revenue) OVER (
                    PARTITION BY Region
                    ORDER BY order_month
                ),
                0
            ) * 100,
            2
        ) AS mom_growth_pct
    FROM monthly_revenue
)
SELECT Region,
    order_month,
    total_revenue,
    order_count,
    total_profit,
    prev_month_revenue,
    mom_growth_pct,
    AVG(mom_growth_pct) OVER (PARTITION BY Region) AS avg_regional_growth,
    SUM(total_revenue) OVER (
        PARTITION BY Region
        ORDER BY order_month
    ) AS cumulative_revenue
FROM growth_analysis
ORDER BY Region,
    order_month;
-- =============================================
-- QUERY 2: FBA vs FBM FULFILLMENT COMPARISON
-- Technique: CASE Statements, Aggregate Functions
-- Business Question: Does FBA outperform FBM
-- in delivery reliability and profit margins?
-- =============================================
WITH fulfillment_metrics AS (
    SELECT Fulfillment,
        Shipping_Method,
        COUNT(*) AS total_orders,
        SUM(
            CASE
                WHEN Delivery_Status = 'Delivered' THEN 1
                ELSE 0
            END
        ) AS delivered_orders,
        SUM(
            CASE
                WHEN "Late Deliveries?" = 'Late' THEN 1
                ELSE 0
            END
        ) AS late_orders,
        AVG(Days) AS avg_delivery_days,
        SUM(Revenue_USD) AS total_revenue,
        SUM(Profit) AS total_profit,
        AVG(Profit / NULLIF(Revenue_USD, 0) * 100) AS avg_profit_margin,
        SUM(Shipping_Cost) AS total_shipping_cost,
        AVG(Shipping_Cost) AS avg_shipping_cost
    FROM amazon_sales
    WHERE Order_Status = 'Completed'
    GROUP BY Fulfillment,
        Shipping_Method
)
SELECT Fulfillment,
    Shipping_Method,
    total_orders,
    ROUND(
        delivered_orders * 100.0 / NULLIF(total_orders, 0),
        2
    ) AS delivery_rate_pct,
    ROUND(late_orders * 100.0 / NULLIF(total_orders, 0), 2) AS late_delivery_pct,
    ROUND(avg_delivery_days, 1) AS avg_delivery_days,
    ROUND(total_revenue, 2) AS total_revenue_usd,
    ROUND(total_profit, 2) AS total_profit_usd,
    ROUND(avg_profit_margin, 2) AS avg_profit_margin_pct,
    ROUND(avg_shipping_cost, 2) AS avg_shipping_cost_per_order,
    ROUND(total_profit / NULLIF(total_orders, 0), 2) AS profit_per_order
FROM fulfillment_metrics
ORDER BY Fulfillment,
    total_profit DESC;
-- =============================================
-- QUERY 3: PRODUCT CATEGORY PERFORMANCE RANKING
-- Technique: Window Functions (RANK, DENSE_RANK)
-- Business Question: Which categories and brands
-- are top performers by region?
-- =============================================
WITH category_performance AS (
    SELECT Region,
        Category,
        Brand,
        COUNT(*) AS orders,
        SUM(UnitsSold) AS units_sold,
        SUM(Revenue_USD) AS revenue,
        SUM(Profit) AS profit,
        AVG(DiscountRate) * 100 AS avg_discount_pct,
        AVG(UnitPrice) AS avg_unit_price
    FROM amazon_sales
    WHERE Order_Status = 'Completed'
    GROUP BY Region,
        Category,
        Brand
),
ranked_performance AS (
    SELECT Region,
        Category,
        Brand,
        orders,
        units_sold,
        revenue,
        profit,
        avg_discount_pct,
        avg_unit_price,
        RANK() OVER (
            PARTITION BY Region
            ORDER BY revenue DESC
        ) AS revenue_rank_in_region,
        RANK() OVER (
            PARTITION BY Region
            ORDER BY profit DESC
        ) AS profit_rank_in_region,
        DENSE_RANK() OVER (
            PARTITION BY Category
            ORDER BY revenue DESC
        ) AS brand_rank_in_category,
        PERCENT_RANK() OVER (
            PARTITION BY Region
            ORDER BY revenue
        ) AS revenue_percentile
    FROM category_performance
)
SELECT Region,
    Category,
    Brand,
    orders,
    units_sold,
    ROUND(revenue, 2) AS revenue_usd,
    ROUND(profit, 2) AS profit_usd,
    ROUND(avg_discount_pct, 2) AS avg_discount_pct,
    ROUND(avg_unit_price, 2) AS avg_unit_price,
    revenue_rank_in_region,
    profit_rank_in_region,
    brand_rank_in_category,
    ROUND(revenue_percentile * 100, 1) AS revenue_percentile
FROM ranked_performance
WHERE revenue_rank_in_region <= 10
ORDER BY Region,
    revenue_rank_in_region;
-- =============================================
-- QUERY 4: SEASONAL SALES PATTERNS
-- Technique: Date Functions, Aggregate Analysis
-- Business Question: What are the peak sales 
-- periods and day-of-week patterns?
-- =============================================
WITH daily_sales AS (
    SELECT EXTRACT(
            YEAR
            FROM OrderDate
        ) AS year,
        EXTRACT(
            MONTH
            FROM OrderDate
        ) AS month,
        EXTRACT(
            DOW
            FROM OrderDate
        ) AS day_of_week,
        CASE
            WHEN EXTRACT(
                MONTH
                FROM OrderDate
            ) IN (1, 2, 3) THEN 'Q1'
            WHEN EXTRACT(
                MONTH
                FROM OrderDate
            ) IN (4, 5, 6) THEN 'Q2'
            WHEN EXTRACT(
                MONTH
                FROM OrderDate
            ) IN (7, 8, 9) THEN 'Q3'
            ELSE 'Q4'
        END AS quarter,
        COUNT(*) AS order_count,
        SUM(Revenue_USD) AS revenue,
        SUM(Profit) AS profit,
        AVG(OrderTotal_USD) AS avg_order_value
    FROM amazon_sales
    WHERE Order_Status = 'Completed'
    GROUP BY EXTRACT(
            YEAR
            FROM OrderDate
        ),
        EXTRACT(
            MONTH
            FROM OrderDate
        ),
        EXTRACT(
            DOW
            FROM OrderDate
        )
)
SELECT year,
    quarter,
    month,
    CASE
        day_of_week
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END AS day_name,
    SUM(order_count) AS total_orders,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(avg_order_value), 2) AS avg_order_value
FROM daily_sales
GROUP BY year,
    quarter,
    month,
    day_of_week
ORDER BY year,
    month,
    day_of_week;
-- =============================================
-- QUERY 5: CUSTOMER SEGMENTATION BY VALUE
-- Technique: Window Functions, CASE, Subqueries
-- Business Question: Who are our high-value 
-- customers and what defines them?
-- =============================================
WITH customer_metrics AS (
    SELECT Buyer_Email,
        Buyer_Name,
        Region,
        COUNT(*) AS total_orders,
        SUM(Revenue_USD) AS lifetime_value,
        SUM(Profit) AS total_profit,
        AVG(OrderTotal_USD) AS avg_order_value,
        MAX(OrderDate) AS last_order_date,
        MIN(OrderDate) AS first_order_date,
        SUM(
            CASE
                WHEN Prime_Member = 1 THEN 1
                ELSE 0
            END
        ) AS prime_orders
    FROM amazon_sales
    WHERE Order_Status = 'Completed'
    GROUP BY Buyer_Email,
        Buyer_Name,
        Region
),
segmented_customers AS (
    SELECT *,
        NTILE(4) OVER (
            ORDER BY lifetime_value
        ) AS value_quartile,
        CASE
            WHEN lifetime_value >= (
                SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (
                        ORDER BY lifetime_value
                    )
                FROM customer_metrics
            ) THEN 'VIP'
            WHEN lifetime_value >= (
                SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (
                        ORDER BY lifetime_value
                    )
                FROM customer_metrics
            ) THEN 'High Value'
            WHEN lifetime_value >= (
                SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (
                        ORDER BY lifetime_value
                    )
                FROM customer_metrics
            ) THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customer_metrics
)
SELECT customer_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(lifetime_value), 2) AS avg_lifetime_value,
    ROUND(AVG(total_orders), 1) AS avg_orders_per_customer,
    ROUND(AVG(avg_order_value), 2) AS avg_order_value,
    ROUND(SUM(total_profit), 2) AS segment_total_profit
FROM segmented_customers
GROUP BY customer_segment
ORDER BY avg_lifetime_value DESC;
-- =============================================
-- QUERY 6: SHIPPING LOGISTICS ANALYSIS
-- Technique: Joins, Aggregates, Performance Metrics
-- Business Question: Which couriers and methods 
-- provide the best service?
-- =============================================
SELECT Courier,
    Shipping_Method,
    Region,
    COUNT(*) AS total_shipments,
    ROUND(AVG(Days), 1) AS avg_delivery_days,
    SUM(
        CASE
            WHEN "Late Deliveries?" = 'Late' THEN 1
            ELSE 0
        END
    ) AS late_shipments,
    ROUND(
        SUM(
            CASE
                WHEN "Late Deliveries?" = 'Late' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS late_pct,
    ROUND(AVG(Shipping_Cost), 2) AS avg_shipping_cost,
    ROUND(SUM(Shipping_Cost), 2) AS total_shipping_cost,
    ROUND(
        SUM(
            CASE
                WHEN Delivery_Status = 'Delivered' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS delivery_success_rate
FROM amazon_sales
WHERE Order_Status = 'Completed'
GROUP BY Courier,
    Shipping_Method,
    Region
HAVING COUNT(*) >= 100
ORDER BY late_pct ASC,
    avg_delivery_days ASC;
-- =============================================
-- QUERY 7: PAYMENT METHOD ANALYSIS
-- Technique: Aggregations, Financial Metrics
-- Business Question: Which payment methods are 
-- most popular and profitable?
-- =============================================
SELECT Payment_Method,
    Region,
    COUNT(*) AS transaction_count,
    ROUND(SUM(OrderTotal_USD), 2) AS total_transaction_value,
    ROUND(AVG(OrderTotal_USD), 2) AS avg_transaction_value,
    ROUND(SUM(Payment_Fees), 2) AS total_payment_fees,
    ROUND(AVG(Payment_Fee_Rate) * 100, 3) AS avg_fee_rate_pct,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        (SUM(Profit) - SUM(Payment_Fees)) / NULLIF(SUM(OrderTotal_USD), 0) * 100,
        2
    ) AS net_profit_margin_pct
FROM amazon_sales
WHERE Order_Status = 'Completed'
GROUP BY Payment_Method,
    Region
ORDER BY total_transaction_value DESC;
-- =============================================
-- QUERY 8: DISCOUNT IMPACT ANALYSIS
-- Technique: CASE, Correlation Analysis
-- Business Question: How do discounts affect 
-- order volume and profit margins?
-- =============================================
WITH discount_bands AS (
    SELECT *,
        CASE
            WHEN DiscountRate = 0 THEN 'No Discount'
            WHEN DiscountRate <= 0.05 THEN '0-5%'
            WHEN DiscountRate <= 0.10 THEN '5-10%'
            WHEN DiscountRate <= 0.20 THEN '10-20%'
            ELSE '20%+'
        END AS discount_band
    FROM amazon_sales
    WHERE Order_Status = 'Completed'
)
SELECT discount_band,
    Category,
    COUNT(*) AS order_count,
    ROUND(AVG(UnitsSold), 2) AS avg_units_per_order,
    ROUND(SUM(Revenue_USD), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Profit / NULLIF(Revenue_USD, 0)) * 100, 2) AS avg_profit_margin_pct,
    ROUND(SUM(DiscountAmount), 2) AS total_discount_given
FROM discount_bands
GROUP BY discount_band,
    Category
ORDER BY CASE
        discount_band
        WHEN 'No Discount' THEN 1
        WHEN '0-5%' THEN 2
        WHEN '5-10%' THEN 3
        WHEN '10-20%' THEN 4
        ELSE 5
    END,
    total_revenue DESC;
-- =============================================
-- END OF ANALYTICAL QUERIES

