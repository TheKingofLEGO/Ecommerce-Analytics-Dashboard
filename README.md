**E-Commerce Sales & Customer Analytics Dashboard**
An interactive Power BI dashboard analyzing £8.91M in online retail sales across 19,000+ orders, providing insights into revenue trends, customer behavior, and product performance for data-driven business decisions.

**Project Overview**
This end-to-end business intelligence project demonstrates the complete data analytics workflow—from raw data extraction and SQL transformation to interactive dashboard development in Power BI. Built to help e-commerce leadership understand sales patterns, identify high-value customers, and optimize product inventory.

**Key Objectives**
Track revenue trends and identify seasonal patterns
Segment customers by purchase behavior and value
Identify top-performing and underperforming products
Analyze geographic sales distribution across 38 countries
Discover peak shopping hours and days for staffing optimization

**Technologies & Skills Demonstrated**
| Technology | Purpose |
|------------|---------|
| SQL Server | Data storage, cleaning, and complex analytical queries |
| Power BI Desktop | Interactive dashboard development and data visualization |
| DAX | Calculated measures, time intelligence, and customer segmentation |
| Power Query | Data transformation and preparation |
| Git/GitHub | Version control and project documentation |

**Key Skills:**
SQL window functions and CTEs for analytical queries
Data cleaning and quality assurance
Customer segmentation (RFM analysis)
Time-series analysis and trend identification
Dashboard UX design and storytelling with data

**Dataset Information**
Source: UCI Machine Learning Repository - Online Retail Dataset
Link: Online Retail Data

**Dataset Characteristics:**
541,909 transaction line items from a UK-based online retailer
19,000 unique orders (invoices)
Date Range: December 2010 - December 2011
4,338 unique customers across 38 countries
4,070 unique products (gift-ware and homewares)
Total Revenue: £8,910,000

**Data Schema**
| Column | Type | Description |
|--------|------|-------------|
| InvoiceNo | VARCHAR(20) | Unique transaction identifier |
| StockCode | VARCHAR(20) | Product code |
| Description | VARCHAR(500) | Product name |
| Quantity | INT | Number of items purchased |
| InvoiceDate | DATETIME | Transaction date and time |
| UnitPrice | DECIMAL(10,2) | Price per unit in GBP (£) |
| CustomerID | INT | Unique customer identifier |
| Country | VARCHAR(100) | Customer country |

**Key Analysis & Insights**
**Revenue Analysis:**
Total Revenue: £8.91M over 12 months
Total Orders: 19,000 unique invoices
Average Order Value: £480.87
Peak Month: November 2011 (holiday shopping surge)
Top Country: United Kingdom (7.3M, representing 82% of revenue)

**Customer Insights:**
4,338 total customers
Revenue Per Customer: £2,050
Top Customer Lifetime Value: £77,183.60 (Customer ID 12346, United Kingdom)
Second Highest Customer: £124,914.53 (Customer ID 12415, Australia, 21 orders)
High-value repeat customer: Customer 13089 with 97 orders totaling £58,825.83

**Customer Metrics by Country:**
EIRE has the highest revenue per customer at £88,515.30 with only 3 customers
Germany: 94 customers, £228,867.14 revenue, £2,434.76 per customer
France: 87 customers, £209,024.05 revenue, £2,402.58 per customer
Netherlands: 9 customers but high revenue of £285,446.34, averaging £31,716.26 per customer

**Product Performance**
Top Product: "PAPER CRAFT, LITTLE BIRDIE" (£168,469.60 revenue, 80,995 items sold)
4,070 unique SKUs with high inventory diversity
Total Items Sold: 488,497 units
Average Product Price: £8.62
Best Sellers: Home décor and seasonal gift items including:
  - REGENCY CAKESTAND 3 TIER: £142,592.95
  - WHITE HANGING HEART T-LIGHT HOLDER: £100,448.15
  - JUMBO BAG RED RETROSPOT: £85,220.78
  - MEDIUM CERAMIC TOP STORAGE JAR: £81,416.73

**Price-Quantity Insight**: High-volume products typically priced £1-5, with clear clustering of products under £50 selling in high quantities (20K-80K units)

**Behavioral Patterns**
Peak Shopping Hours: 10 AM - 3 PM GMT, with peak transaction volume around 12-2 PM (60K-70K transactions)
Busiest Day: Thursday (£1.98M revenue)
Second Busiest: Tuesday (£1.70M)
Slowest Day: Sunday (£0.79M)
Seasonal Spike: November-December (holiday shopping) with visible upward trend in items sold over time

**Dashboard Pages**
**Page 1**: Revenue Overview
Executive summary providing high-level business health metrics.

**Key Visualizations:**
5 KPI Cards: Total Revenue (£8.91M), Orders (19K), Customers (4,338), Average Order Value (£480.87), Revenue Per Customer (£2.05K)
Monthly revenue and order trend (12-month view) showing steady growth from January to November with peak in November
Top 10 countries by revenue (geographic distribution) with United Kingdom dominating at £7.3M
Revenue by day of week (operational patterns) with Thursday leading at £1.98M
Hourly transaction volume (staffing insights) showing bell curve peaking midday

Business Value: Quick 30-second health check for leadership

**Page 2:** Customer Insights
Deep-dive into customer behavior and segmentation.

**Key Visualizations:**
Top 20 customers by revenue showing Customer 12346 leading with £77,183.60
Revenue per customer by country with EIRE at £89K, Netherlands at £32K
Monthly customer acquisition trend showing growth from ~800 in January to peak of ~1,600 in November, dropping to ~1,300 in December
Customer metrics matrix by country displaying total customers, total revenue, revenue per customer, and average orders per customer
Summary showing 301 customers across top countries with £1,429,602.70 in revenue

Business Value: Identify high-value customers and retention opportunities

**Page 3:** Product Performance
Product-level analysis for inventory and marketing decisions.

**Key Visualizations:**
Top 20 products by revenue with stock codes, descriptions, items sold, revenue, and average price
Items sold over time showing steady increase from ~300K in January to ~700K items by December
Price vs. quantity scatter plot revealing pricing strategy with most products clustered under £50 and between 0-20K items sold, with notable outliers at 80K items
Top 10 product summary with data bars showing revenue and order count, totaling £886,502.97 across 7,771 orders

Business Value: Optimize inventory and identify cross-sell opportunities

**Key DAX Measures**

**Revenue Metrics**

```dax
Total Revenue = SUM(online_retail_clean[Revenue])

Avg Order Value = DIVIDE([Total Revenue], [Total Orders], 0)

Revenue MoM Growth = 
DIVIDE(
    [Total Revenue] - [Revenue Previous Month],
    [Revenue Previous Month],
    0
)
```

**Customer Segmentation**

```dax
One-Time Customers = 
CALCULATE(
    DISTINCTCOUNT(online_retail_clean[CustomerID]),
    FILTER(
        SUMMARIZE(
            online_retail_clean,
            online_retail_clean[CustomerID],
            "OrderCount", DISTINCTCOUNT(online_retail_clean[InvoiceNo])
        ),
        [OrderCount] = 1
    )
)

Repeat Customer % = DIVIDE([Repeat Customers], [Total Customers], 0)
```

**Time Intelligence**

```dax
Revenue Previous Month = 
CALCULATE(
    [Total Revenue],
    DATEADD(online_retail_clean[InvoiceDate], -1, MONTH)
)
```

**SQL Query Highlights**

**Customer RFM Segmentation**

```sql
WITH rfm_calc AS (
    SELECT 
        CustomerID,
        DATEDIFF(DAY, MAX(InvoiceDate), '2011-12-31') AS recency,
        COUNT(DISTINCT InvoiceNo) AS frequency,
        SUM(Revenue) AS monetary
    FROM online_retail_clean
    GROUP BY CustomerID
),
rfm_scores AS (
    SELECT 
        CustomerID,
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM rfm_calc
)
SELECT 
    CustomerID,
    CASE 
        WHEN (r_score + f_score + m_score) >= 13 THEN 'Champions'
        WHEN (r_score + f_score + m_score) >= 10 THEN 'Loyal'
        WHEN (r_score + f_score + m_score) >= 7 THEN 'Potential'
        ELSE 'At Risk'
    END AS customer_category
FROM rfm_scores;
```

**Product Basket Analysis**

```sql
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
```

**Learning Outcomes**
Through this project, I demonstrated proficiency in:

**SQL Skills**
Window functions (NTILE, RANK, LAG) for advanced analytics
CTEs and subqueries for complex data transformations
Data cleaning and quality assurance techniques
Aggregations and GROUP BY for business metrics

**Power BI Skills**
DAX measure creation and time intelligence
Interactive dashboard design with cross-filtering
Multiple visualization types and when to use each
Data modeling and relationships
User experience design for executive audiences

**Business Analytics**
Customer segmentation and RFM analysis
Revenue trend analysis and forecasting
Product performance evaluation
KPI definition and tracking
Actionable insight generation

**Data Storytelling**
Organizing insights by audience (executives vs. analysts)
Visual hierarchy and information design
Clear, concise metric presentation
Narrative flow across dashboard pages

**Business Recommendations**
Based on the analysis, I recommend:

**Customer Retention Focus**
High concentration of revenue from top customers (Customer 12346 alone generated £77K)
Implement VIP customer program for top 50 customers
Create email marketing campaigns targeting customers with high average order values
Focus on international markets with high revenue per customer (EIRE, Netherlands)

**Inventory Optimization**
Focus on top 100 products following the 80/20 rule
Top 10 products alone generated £886,502.97 (nearly 10% of total revenue)
Reduce SKU count for underperforming items
Increase stock for seasonal items in Q4 (Items sold increased from 300K to 700K throughout the year)

**Geographic Expansion**
UK dominates revenue (82%) - opportunity to grow other markets
Target European countries with similar customer profiles (Germany, France, Netherlands)
Netherlands shows exceptionally high revenue per customer (£31,716) despite only 9 customers - indicates opportunity for targeted expansion
Localize marketing for top 5 international markets

**Operational Efficiency**
Peak hours are 10 AM - 3 PM with maximum transaction volume around noon - optimize staffing accordingly
Thursday is busiest day (£1.98M) - plan promotions and ensure adequate inventory
Sunday generates lowest revenue (£0.79M) - consider reduced staffing or special promotions
November surge visible in data - prepare inventory 2 months in advance for holiday season
Customer acquisition peaked in November (1,600 customers) - replicate successful marketing strategies from this period

---

**Author**

**[William Fowler]**

Email: [williamfowler002@gmail.com]  
LinkedIn: (https://www.linkedin.com/in/william-fowler-276718136/)   
GitHub: https://github.com/TheKingofLEGO

---

**License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Dataset License:** The Online Retail dataset is provided by UCI Machine Learning Repository under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
