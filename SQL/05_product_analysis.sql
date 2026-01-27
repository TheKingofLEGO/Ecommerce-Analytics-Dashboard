-- ============================================
-- PRODUCT ANALYSIS
-- Purpose: Identify top products and categories
-- ============================================

-- Top 20 products by revenue
SELECT TOP 20
    StockCode,
    Description,
    SUM(Quantity) AS total_units_sold,
    COUNT(DISTINCT InvoiceNo) AS times_ordered,
    SUM(Revenue) AS total_revenue,
    AVG(UnitPrice) AS avg_price
FROM online_retail_clean
GROUP BY StockCode, Description
ORDER BY total_revenue DESC;

-- Top 20 products by quantity sold
SELECT TOP 20
    StockCode,
    Description,
    SUM(Quantity) AS total_units_sold,
    SUM(Revenue) AS total_revenue
FROM online_retail_clean
GROUP BY StockCode, Description
ORDER BY total_units_sold DESC;

-- Product performance by month
SELECT 
    InvoiceYear,
    InvoiceMonth,
    COUNT(DISTINCT StockCode) AS unique_products_sold,
    SUM(Quantity) AS total_items,
    SUM(Revenue) AS total_revenue
FROM online_retail_clean
GROUP BY InvoiceYear, InvoiceMonth
ORDER BY InvoiceYear, InvoiceMonth;

-- Products bought together (basket analysis)
WITH product_pairs AS (
    SELECT 
        a.InvoiceNo,
        a.Description AS product_a,
        b.Description AS product_b
    FROM online_retail_clean a
    INNER JOIN online_retail_clean b 
        ON a.InvoiceNo = b.InvoiceNo 
        AND a.StockCode < b.StockCode
)
SELECT TOP 20
    product_a,
    product_b,
    COUNT(*) AS times_bought_together
FROM product_pairs
GROUP BY product_a, product_b
HAVING COUNT(*) >= 50
ORDER BY times_bought_together DESC;