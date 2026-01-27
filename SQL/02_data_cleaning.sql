-- ============================================
-- DATA CLEANING
-- Purpose: Create clean table for analysis
-- ============================================

-- Create clean table with proper data types
CREATE TABLE online_retail_clean (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(500),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(100),
    -- Calculated columns
    Revenue DECIMAL(10,2),
    InvoiceYear INT,
    InvoiceMonth INT,
    InvoiceDay INT,
    InvoiceHour INT,
    DayOfWeek VARCHAR(10)
);
GO

-- Insert cleaned data
INSERT INTO online_retail_clean
SELECT 
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    -- Convert string date to proper DATETIME
    CAST(InvoiceDate AS DATETIME) AS InvoiceDate,
    UnitPrice,
    -- Convert CustomerID to INT (nulls become NULL)
    TRY_CAST(CustomerID AS INT) AS CustomerID,
    Country,
    -- Calculate revenue
    ROUND(Quantity * UnitPrice, 2) AS Revenue,
    -- Extract date parts
    YEAR(CAST(InvoiceDate AS DATETIME)) AS InvoiceYear,
    MONTH(CAST(InvoiceDate AS DATETIME)) AS InvoiceMonth,
    DAY(CAST(InvoiceDate AS DATETIME)) AS InvoiceDay,
    DATEPART(HOUR, CAST(InvoiceDate AS DATETIME)) AS InvoiceHour,
    DATENAME(WEEKDAY, CAST(InvoiceDate AS DATETIME)) AS DayOfWeek
FROM OnlineRetail
WHERE 
    -- Remove rows with missing critical data
    InvoiceNo IS NOT NULL
    AND Quantity > 0  -- Remove returns (negative quantities)
    AND UnitPrice > 0  -- Remove zero/negative prices
    AND CustomerID IS NOT NULL  -- Keep only customers we can track
    AND Description IS NOT NULL;  -- Remove items without description
GO

-- Verify cleaning
SELECT 
    COUNT(*) AS clean_records,
    MIN(InvoiceDate) AS first_date,
    MAX(InvoiceDate) AS last_date,
    COUNT(DISTINCT CustomerID) AS unique_customers,
    COUNT(DISTINCT StockCode) AS unique_products,
    COUNT(DISTINCT Country) AS unique_countries,
    SUM(Revenue) AS total_revenue
FROM online_retail_clean;

-- Check for any remaining issues
SELECT 
    SUM(CASE WHEN Revenue < 0 THEN 1 ELSE 0 END) AS negative_revenue,
    SUM(CASE WHEN Quantity < 0 THEN 1 ELSE 0 END) AS negative_quantity,
    SUM(CASE WHEN UnitPrice < 0 THEN 1 ELSE 0 END) AS negative_price
FROM online_retail_clean;