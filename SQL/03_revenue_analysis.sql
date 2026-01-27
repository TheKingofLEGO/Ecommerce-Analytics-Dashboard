-- ============================================
-- REVENUE ANALYSIS
-- Purpose: Calculate key revenue metrics
-- ============================================

-- Overall revenue metrics
SELECT 
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    COUNT(DISTINCT CustomerID) AS total_customers,
    SUM(Revenue) AS total_revenue,
    AVG(Revenue) AS avg_transaction_value,
    SUM(Revenue) / COUNT(DISTINCT InvoiceNo) AS avg_order_value,
    SUM(Revenue) / COUNT(DISTINCT CustomerID) AS revenue_per_customer
FROM online_retail_clean;

-- Monthly revenue trend
SELECT 
    InvoiceYear,
    InvoiceMonth,
    COUNT(DISTINCT InvoiceNo) AS orders,
    COUNT(DISTINCT CustomerID) AS customers,
    SUM(Revenue) AS monthly_revenue,
    AVG(Revenue) AS avg_transaction_value
FROM online_retail_clean
GROUP BY InvoiceYear, InvoiceMonth
ORDER BY InvoiceYear, InvoiceMonth;

-- Revenue by country (top 10)
SELECT TOP 10
    Country,
    COUNT(DISTINCT CustomerID) AS customers,
    COUNT(DISTINCT InvoiceNo) AS orders,
    SUM(Revenue) AS total_revenue,
    AVG(Revenue) AS avg_transaction_value,
    RANK() OVER (ORDER BY SUM(Revenue) DESC) AS revenue_rank
FROM online_retail_clean
GROUP BY Country
ORDER BY total_revenue DESC;

-- Day of week analysis
SELECT 
    DayOfWeek,
    COUNT(*) AS transactions,
    SUM(Revenue) AS revenue,
    AVG(Revenue) AS avg_transaction
FROM online_retail_clean
GROUP BY DayOfWeek
ORDER BY 
    CASE DayOfWeek
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
    END;

-- Hour of day analysis
SELECT 
    InvoiceHour,
    COUNT(*) AS transactions,
    SUM(Revenue) AS revenue
FROM online_retail_clean
GROUP BY InvoiceHour
ORDER BY InvoiceHour;