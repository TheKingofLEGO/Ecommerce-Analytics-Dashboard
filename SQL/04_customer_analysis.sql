-- ============================================
-- CUSTOMER ANALYSIS
-- Purpose: Segment and analyze customer behavior
-- ============================================

-- Customer summary statistics
SELECT 
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    SUM(Quantity) AS total_items_purchased,
    SUM(Revenue) AS total_spent,
    AVG(Revenue) AS avg_transaction_value,
    MIN(InvoiceDate) AS first_purchase,
    MAX(InvoiceDate) AS last_purchase,
    DATEDIFF(DAY, MIN(InvoiceDate), MAX(InvoiceDate)) AS customer_lifetime_days
FROM online_retail_clean
GROUP BY CustomerID;

-- Top 20 customers by revenue
SELECT TOP 20
    CustomerID,
    Country,
    COUNT(DISTINCT InvoiceNo) AS orders,
    SUM(Revenue) AS total_revenue,
    AVG(Revenue) AS avg_order_value,
    MAX(InvoiceDate) AS last_purchase
FROM online_retail_clean
GROUP BY CustomerID, Country
ORDER BY total_revenue DESC;

-- Customer segmentation by purchase frequency
WITH customer_freq AS (
    SELECT 
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS order_count
    FROM online_retail_clean
    GROUP BY CustomerID
)
SELECT 
    CASE 
        WHEN order_count = 1 THEN 'One-time'
        WHEN order_count BETWEEN 2 AND 5 THEN 'Occasional (2-5)'
        WHEN order_count BETWEEN 6 AND 10 THEN 'Regular (6-10)'
        ELSE 'Frequent (11+)'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct_of_customers
FROM customer_freq
GROUP BY 
    CASE 
        WHEN order_count = 1 THEN 'One-time'
        WHEN order_count BETWEEN 2 AND 5 THEN 'Occasional (2-5)'
        WHEN order_count BETWEEN 6 AND 10 THEN 'Regular (6-10)'
        ELSE 'Frequent (11+)'
    END
ORDER BY customer_count DESC;

-- RFM Analysis (Recency, Frequency, Monetary)
WITH rfm_calc AS (
    SELECT 
        CustomerID,
        DATEDIFF(DAY, MAX(InvoiceDate), (SELECT MAX(InvoiceDate) FROM online_retail_clean)) AS recency,
        COUNT(DISTINCT InvoiceNo) AS frequency,
        SUM(Revenue) AS monetary
    FROM online_retail_clean
    GROUP BY CustomerID
),
rfm_scores AS (
    SELECT 
        CustomerID,
        recency,
        frequency,
        monetary,
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM rfm_calc
)
SELECT 
    CustomerID,
    recency,
    frequency,
    ROUND(monetary, 2) AS monetary,
    r_score,
    f_score,
    m_score,
    (r_score + f_score + m_score) AS rfm_total,
    CASE 
        WHEN (r_score + f_score + m_score) >= 13 THEN 'Champions'
        WHEN (r_score + f_score + m_score) >= 10 THEN 'Loyal'
        WHEN (r_score + f_score + m_score) >= 7 THEN 'Potential'
        ELSE 'At Risk'
    END AS customer_category
FROM rfm_scores
ORDER BY rfm_total DESC;