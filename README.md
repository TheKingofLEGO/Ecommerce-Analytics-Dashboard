# E-Commerce Sales & Customer Analytics Dashboard

An interactive Power BI dashboard analyzing **£8.91M** in online retail sales across **19,000+ orders**, providing insights into revenue trends, customer behavior, and product performance for data-driven business decisions.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Key Objectives](#key-objectives)
- [Technologies & Skills](#technologies--skills)
- [Dataset Information](#dataset-information)
- [Key Analysis & Insights](#key-analysis--insights)
- [Dashboard Pages](#dashboard-pages)
- [DAX Measures](#dax-measures)
- [SQL Query Highlights](#sql-query-highlights)
- [Learning Outcomes](#learning-outcomes)
- [Business Recommendations](#business-recommendations)

---

## Project Overview

This end-to-end business intelligence project demonstrates the complete data analytics workflow—from raw data extraction and SQL transformation to interactive dashboard development in Power BI. 

Built to help e-commerce leadership:
- Understand sales patterns
- Identify high-value customers
- Optimize product inventory

---

## Key Objectives

- Track revenue trends and identify seasonal patterns
- Segment customers by purchase behavior and value
- Identify top-performing and underperforming products
- Analyze geographic sales distribution across 38 countries
- Discover peak shopping hours and days for staffing optimization

---

## Technologies & Skills

### Technologies Used

| Technology | Purpose |
|------------|---------|
| **SQL Server** | Data storage, cleaning, and complex analytical queries |
| **Power BI Desktop** | Interactive dashboard development and data visualization |
| **DAX** | Calculated measures, time intelligence, and customer segmentation |
| **Power Query** | Data transformation and preparation |
| **Git/GitHub** | Version control and project documentation |

### Key Skills Demonstrated

- SQL window functions and CTEs for analytical queries
- Data cleaning and quality assurance
- Customer segmentation (RFM analysis)
- Time-series analysis and trend identification
- Dashboard UX design and storytelling with data

---

## Dataset Information

**Source:** UCI Machine Learning Repository - [Online Retail Dataset](https://archive.ics.uci.edu/ml/datasets/Online+Retail)

### Dataset Characteristics

- **541,909** transaction line items from a UK-based online retailer
- **19,000** unique orders (invoices)
- **Date Range:** December 2010 - December 2011
- **4,338** unique customers across 38 countries
- **4,070** unique products (gift-ware and homewares)
- **Total Revenue:** £8,910,000

### Data Schema

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

## Key Analysis & Insights

### Revenue Analysis

- **Total Revenue:** £8.91M over 12 months
- **Total Orders:** 19,000 unique invoices
- **Average Order Value:** £480.87
- **Peak Month:** November 2011 (holiday shopping surge)
- **Top Country:** United Kingdom (£7.3M, representing 82% of revenue)

### Customer Insights

**Total Customers:** 4,338

**Top Customers by Lifetime Value:**
- **Customer 12346 (UK):** £77,183.60 in a single high-value order
- **Customer 12415 (Australia):** £124,914.53 across 21 orders
- **Customer 13089 (UK):** £58,825.83 across 97 orders

**Revenue Per Customer:** £2,050

**Geographic Performance:**
- **EIRE:** Highest revenue per customer at £88,515.30 (only 3 customers)
- **Netherlands:** £31,716.26 per customer (9 customers, £285,446.34 total)
- **Germany:** 94 customers, £228,867.14 revenue, £2,434.76 per customer
- **France:** 87 customers, £209,024.05 revenue, £2,402.58 per customer

### Product Performance

**Total Products:** 4,070 unique SKUs  
**Total Items Sold:** 488,497 units  
**Average Product Price:** £8.62

**Top 5 Products by Revenue:**

1. **PAPER CRAFT, LITTLE BIRDIE** - £168,469.60 (80,995 items sold)
2. **REGENCY CAKESTAND 3 TIER** - £142,592.95 (12,402 items sold)
3. **WHITE HANGING HEART T-LIGHT HOLDER** - £100,448.15 (36,725 items sold)
4. **JUMBO BAG RED RETROSPOT** - £85,220.78 (46,181 items sold)
5. **MEDIUM CERAMIC TOP STORAGE JAR** - £81,416.73 (77,916 items sold)

**Key Insight:** High-volume products are typically priced £1-5, with clear clustering of products under £50 selling in high quantities (20K-80K units).

### Behavioral Patterns

- **Peak Shopping Hours:** 10 AM - 3 PM GMT (60K-70K transactions during peak)
- **Busiest Day:** Thursday (£1.98M revenue)
- **Second Busiest:** Tuesday (£1.70M)
- **Slowest Day:** Sunday (£0.79M)
- **Seasonal Trend:** Items sold increased from ~300K in January to ~700K by December
- **Holiday Surge:** November-December shows significant spike in customer acquisition and sales

---

## Dashboard Pages

### Page 1: Revenue Overview

**Purpose:** Executive summary providing high-level business health metrics

**Key Visualizations:**

- **5 KPI Cards:**
  - Total Revenue: £8.91M
  - Total Orders: 19K
  - Total Customers: 4,338
  - Average Order Value: £480.87
  - Revenue Per Customer: £2.05K

- **Monthly Revenue & Order Trend** - 12-month view showing steady growth with November peak
- **Top 10 Countries by Revenue** - Geographic distribution with UK dominating at £7.3M
- **Revenue by Day of Week** - Operational patterns with Thursday leading
- **Transactions by Hour of Day** - Bell curve peaking at midday for staffing insights

**Business Value:** Quick 30-second health check for leadership

---

### Page 2: Customer Insights

**Purpose:** Deep-dive into customer behavior and segmentation

**Key Visualizations:**

- **Top 20 Customers by Revenue** - VIP identification with Customer 12346 leading at £77,183.60
- **Revenue Per Customer by Country** - Market efficiency analysis showing EIRE at £89K, Netherlands at £32K
- **Monthly Customer Count Trend** - Growth from ~800 in January to peak of ~1,600 in November
- **Customer Metrics Matrix by Country** - Comprehensive table showing total customers, revenue, revenue per customer, and average orders per customer

**Summary Metrics:** 301 customers across top countries generating £1,429,602.70 in revenue

**Business Value:** Identify high-value customers and retention opportunities

---

### Page 3: Product Performance

**Purpose:** Product-level analysis for inventory and marketing decisions

**Key Visualizations:**

- **Top 20 Products by Revenue** - Complete breakdown with stock codes, descriptions, items sold, revenue, and average price
- **Items Sold Over Time** - Trend showing steady increase from ~300K to ~700K items
- **Product Price vs Quantity Analysis** - Scatter plot revealing pricing strategy with most products clustered under £50 and between 0-20K items sold
- **Top 10 Product Summary** - Data bars showing revenue and order count, totaling £886,502.97 across 7,771 orders

**Business Value:** Optimize inventory and identify cross-sell opportunities

---

## DAX Measures

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

## SQL Query Highlights

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

## Learning Outcomes

Through this project, I demonstrated proficiency in:

### SQL Skills

- Window functions (NTILE, RANK, LAG) for advanced analytics
- CTEs and subqueries for complex data transformations
- Data cleaning and quality assurance techniques
- Aggregations and GROUP BY for business metrics

### Power BI Skills

- DAX measure creation and time intelligence
- Interactive dashboard design with cross-filtering
- Multiple visualization types and when to use each
- Data modeling and relationships
- User experience design for executive audiences

### Business Analytics

- Customer segmentation and RFM analysis
- Revenue trend analysis and forecasting
- Product performance evaluation
- KPI definition and tracking
- Actionable insight generation

### Data Storytelling

- Organizing insights by audience (executives vs. analysts)
- Visual hierarchy and information design
- Clear, concise metric presentation
- Narrative flow across dashboard pages

---

## Business Recommendations

Based on the analysis, I recommend:

### 1. Customer Retention Focus

**Challenge:** High concentration of revenue from top customers

**Recommendations:**
- Implement VIP customer program for top 50 customers (Customer 12346 alone generated £77K)
- Create email marketing campaigns targeting customers with high average order values
- Focus on international markets with high revenue per customer (EIRE at £88K, Netherlands at £31K per customer)
- Develop loyalty rewards program to encourage repeat purchases

---

### 2. Inventory Optimization

**Challenge:** Managing 4,070 SKUs with varying performance levels

**Recommendations:**
- Focus on top 100 products following the 80/20 rule
- Top 10 products alone generated £886,502.97 (nearly 10% of total revenue)
- Reduce SKU count for underperforming items to improve cash flow
- Increase stock for seasonal items in Q4 (items sold increased from 300K to 700K throughout the year)
- Monitor "Paper Craft Little Birdie" closely - single highest revenue generator at £168K

---

### 3. Geographic Expansion

**Challenge:** Over-reliance on UK market (82% of revenue)

**Recommendations:**
- Target European countries with similar customer profiles (Germany, France, Netherlands)
- Netherlands shows exceptionally high revenue per customer (£31,716) despite only 9 customers - indicates strong opportunity for targeted expansion
- Localize marketing for top 5 international markets
- Investigate why EIRE has only 3 customers but £88K per customer - untapped market potential

---

### 4. Operational Efficiency

**Challenge:** Optimizing staffing and inventory based on transaction patterns

**Recommendations:**
- Peak hours are 10 AM - 3 PM with maximum transaction volume around noon - optimize staffing accordingly
- Thursday is busiest day (£1.98M) - plan promotions and ensure adequate inventory
- Sunday generates lowest revenue (£0.79M) - consider reduced staffing or special promotions to boost sales
- November surge visible in data - prepare inventory 2 months in advance for holiday season
- Customer acquisition peaked in November (1,600 customers) - replicate successful marketing strategies from this period

---

## Author

**William Fowler**

- Email: williamfowler003@gmail.com
- LinkedIn: [linkedin.com/in/william-fowler-27B7181364](https://www.linkedin.com/in/william-fowler-27B7181364)
- GitHub: [github.com/TheUnguidedECG](https://github.com/TheUnguidedECG)

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Dataset License:** The Online Retail dataset is provided by UCI Machine Learning Repository under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

---

**Last Updated:** January 2026
