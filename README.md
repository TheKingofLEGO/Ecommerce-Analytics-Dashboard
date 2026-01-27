E-Commerce Sales & Customer Analytics Dashboard

An interactive Power BI dashboard analyzing **£9.7M in online retail sales** across 541,000+ transactions, providing insights into revenue trends, customer behavior, and product performance for data-driven business decisions.

Project Overview

This end-to-end business intelligence project demonstrates the complete data analytics workflow—from raw data extraction and SQL transformation to interactive dashboard development in Power BI. Built to help e-commerce leadership understand sales patterns, identify high-value customers, and optimize product inventory.

Key Objectives
- Track revenue trends and identify seasonal patterns
- Segment customers by purchase behavior and value
- Identify top-performing and underperforming products
- Analyze geographic sales distribution across 38 countries
- Discover peak shopping hours and days for staffing optimization

Technologies & Skills Demonstrated

| Technology | Purpose |
|-----------|---------|
| **SQL Server** | Data storage, cleaning, and complex analytical queries |
| **Power BI Desktop** | Interactive dashboard development and data visualization |
| **DAX** | Calculated measures, time intelligence, and customer segmentation |
| **Power Query** | Data transformation and preparation |
| **Git/GitHub** | Version control and project documentation |

**Key Skills:**
- SQL window functions and CTEs for analytical queries
- Data cleaning and quality assurance
- Customer segmentation (RFM analysis)
- Time-series analysis and trend identification
- Dashboard UX design and storytelling with data


Dataset Information

Source: UCI Machine Learning Repository - Online Retail Dataset  
Link: [Online Retail Data](https://archive.ics.uci.edu/ml/datasets/online+retail)

Dataset Characteristics:
- 541,909 transactions from a UK-based online retailer
- Date Range: December 2010 - December 2011
- 4,372 unique customers across **38 countries**
- 4,070 unique products (gift-ware and homewares)
- Total Revenue: £9,747,747

Data Schema

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

---

Key Analysis & Insights

Revenue Analysis
- **Total Revenue:** £9.7M over 12 months
- **Average Order Value:** £489
- **Peak Month:** November 2011 (holiday shopping surge)
- **Top Country:** United Kingdom (83% of revenue)

Customer Insights
- 4,372 total customers with significant retention challenges
- Customer Segmentation:
  - 50% one-time purchasers
  - 30% occasional buyers (2-5 orders)
  - 15% regular customers (6-10 orders)
  - 5% high-frequency buyers (11+ orders)
- Top Customer Lifetime Value: £280K+ from single customer
- Average Revenue Per Customer: £2,229

Product Performance
- Top Product: "Paper Craft Little Birdie" (£168K revenue)
- 4,070 unique SKUs with high inventory diversity
- Best Sellers: Home décor and seasonal gift items
- Price-Quantity Insight: High-volume products typically priced £1-5

Behavioral Patterns
- **Peak Shopping Hours:** 10 AM - 3 PM GMT
- **Busiest Day:** Thursday
- **Seasonal Spike:** November-December (holiday shopping)

---

Dashboard Pages

Page 1: Revenue Overview 
Executive summary providing high-level business health metrics.

**Key Visualizations:**
- 5 KPI Cards: Total Revenue, Orders, Customers, AOV, Revenue/Customer
- Monthly revenue and order trend (12-month view)
- Top 10 countries by revenue (geographic distribution)
- Revenue by day of week (operational patterns)
- Hourly transaction volume (staffing insights)

**Business Value:** Quick 30-second health check for leadership

---

### Page 2: Customer Insights
Deep-dive into customer behavior and segmentation.

**Key Visualizations:**
- Customer segment KPI cards (total, one-time, repeat, retention %)
- Top 20 customers by revenue (VIP identification)
- Revenue per customer by country (market efficiency)
- Monthly customer acquisition trend
- Customer metrics matrix by country

**Business Value:** Identify high-value customers and retention opportunities

---

### Page 3: Product Performance
Product-level analysis for inventory and marketing decisions.

**Key Visualizations:**
- Product KPI cards (total products, items sold, avg price)
- Top 20 products by revenue (inventory prioritization)
- Items sold over time (demand forecasting)
- Price vs. quantity scatter plot (pricing strategy)
- Top 10 product summary with data bars

**Business Value:** Optimize inventory and identify cross-sell opportunities

![Product Performance](screenshots/page3_product_performance.png)

---

Key DAX Measures

### Revenue Metrics
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

### Customer Segmentation
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

### Time Intelligence
```dax
Revenue Previous Month = 
CALCULATE(
    [Total Revenue],
    DATEADD(online_retail_clean[InvoiceDate], -1, MONTH)
)
```

---

SQL Query Highlights

### Customer RFM Segmentation
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

### Product Basket Analysis
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

---

Learning Outcomes

Through this project, I demonstrated proficiency in:

**SQL Skills**
- Window functions (NTILE, RANK, LAG) for advanced analytics
- CTEs and subqueries for complex data transformations
- Data cleaning and quality assurance techniques
- Aggregations and GROUP BY for business metrics

**Power BI Skills**
- DAX measure creation and time intelligence
- Interactive dashboard design with cross-filtering
- Multiple visualization types and when to use each
- Data modeling and relationships
- User experience design for executive audiences

**Business Analytics**
- Customer segmentation and RFM analysis
- Revenue trend analysis and forecasting
- Product performance evaluation
- KPI definition and tracking
- Actionable insight generation

**Data Storytelling**
- Organizing insights by audience (executives vs. analysts)
- Visual hierarchy and information design
- Clear, concise metric presentation
- Narrative flow across dashboard pages

---

Business Recommendations

Based on the analysis, I recommend:

1. **Customer Retention Focus**
   - 50% of customers make only one purchase
   - Implement email marketing campaigns for repeat purchases
   - Create loyalty program for top 20% of customers

2. **Inventory Optimization**
   - Focus on top 100 products (80/20 rule applies)
   - Reduce SKU count for underperforming items
   - Increase stock for seasonal items in Q4

3. **Geographic Expansion**
   - UK dominates revenue (83%) - opportunity to grow other markets
   - Target European countries with similar customer profiles
   - Localize marketing for top 5 international markets

4. **Operational Efficiency**
   - Peak hours are 10 AM - 3 PM → optimize staffing
   - Thursday is busiest day → plan promotions accordingly
   - November surge → prepare inventory 2 months in advance

---

Author

**[William Fowler]**

📧 Email: [williamfowler002@gmail.com]  
💼 LinkedIn: (https://www.linkedin.com/in/william-fowler-276718136/)   
📂 GitHub: https://github.com/TheKingofLEGO

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Dataset License:** The Online Retail dataset is provided by UCI Machine Learning Repository under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).