# 📦 Amazon Global Sales Analytics

> **End-to-End Data Analytics Project: From Raw Data to Executive Dashboard**

[![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue?style=flat-square&logo=postgresql)](https://www.postgresql.org/)
[![Excel](https://img.shields.io/badge/Excel-Data%20Cleaning-green?style=flat-square&logo=microsoft-excel)](https://www.microsoft.com/excel)
[![Tableau](https://img.shields.io/badge/Tableau-Visualization-orange?style=flat-square&logo=tableau)](https://public.tableau.com/)

## 🎯 Project Overview

This project demonstrates a complete data analytics workflow analyzing **50,000+ Amazon e-commerce transactions** across multiple global regions. The analysis covers revenue trends, fulfillment optimization, product performance, and customer segmentation using industry-standard tools.

### 🔑 Key Insights Discovered

| Metric | Finding |
|--------|---------|
| 📈 **MoM Growth** | North America leads with 15% average monthly growth |
| 🚚 **FBA vs FBM** | FBA yields 23% higher profit margins |
| 📅 **Partial Data & Lower Volume** | Fourth quarter shows a reduced order volume of 15.06%. |
| 🏆 **Top Category** | Electronics consistently outperforms across all regions |

---

## 🛠️ Technology Stack

| Phase | Tool | Purpose |
|-------|------|---------|
| **Data Cleaning** | Microsoft Excel | Null handling, date standardization, feature engineering |
| **Analysis** | PostgreSQL/SQL Server | CTEs, window functions, complex aggregations |
| **Visualization** | Tableau Public | Interactive dashboards with drill-down capabilities |
| **Portfolio** | HTML/CSS/JS | Responsive web showcase |

---

## 📊 Dashboard Preview

![Dashboard Preview]
<div class='tableauPlaceholder' id='viz1770402170457' style='position: relative'><noscript><a href='#'><img alt='Dashboard 3 ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Am&#47;AmazonE-CommerceAnualDashboard&#47;Dashboard3&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='AmazonE-CommerceAnualDashboard&#47;Dashboard3' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Am&#47;AmazonE-CommerceAnualDashboard&#47;Dashboard3&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>

**🔗 [View Live Interactive Dashboard on Tableau Public](https://public.tableau.com/app/profile/johari.frias/vizzes)**

---

## 📁 Repository Structure

```
amazon-global-sales-analytics/
├── 📂 data/
│   ├── Amazon_Sales_Data_Raw.xlsx          # Original dataset
│   └── Amazon_Sales_Data_Cleaned.xlsx      # Cleaned dataset
├── 📂 sql-queries/
│   └── amazon_sales_analytics.sql          # All analytical queries
├── 📂 portfolio/
│   ├── index.html                          # Portfolio web page
│   ├── styles.css                          # Styling
│   └── script.js                           # Interactivity
├── 📂 tableau/
│   └── Amazon_Sales_Dashboard.twbx         # Tableau workbook
├── 📂 docs/
│   └── data_dictionary.md                  # Column descriptions
└── README.md
```

---

## 🔍 SQL Techniques Demonstrated

### 1. Common Table Expressions (CTEs)
```sql
WITH monthly_revenue AS (
    SELECT Region, DATE_TRUNC('month', OrderDate) AS order_month,
           SUM(Revenue_USD) AS total_revenue
    FROM amazon_sales
    GROUP BY Region, DATE_TRUNC('month', OrderDate)
)
SELECT * FROM monthly_revenue;
```

### 2. Window Functions
```sql
-- Month-over-Month Growth with LAG
LAG(total_revenue) OVER (PARTITION BY Region ORDER BY order_month)

-- Performance Ranking
RANK() OVER (PARTITION BY Region ORDER BY revenue DESC)

-- Running Totals
SUM(revenue) OVER (PARTITION BY Region ORDER BY order_month)
```

### 3. CASE Statements for Segmentation
```sql
CASE 
    WHEN DiscountRate = 0 THEN 'No Discount'
    WHEN DiscountRate <= 0.10 THEN 'Low (0-10%)'
    ELSE 'High (10%+)'
END AS discount_tier
```

---

## 📋 Data Cleaning Steps (Excel)

| Step | Action | Columns Affected |
|------|--------|-----------------|
| 1 | Handle NULL values | `FX_to_USD`, `Phone_E164`, `Refund_Amount` |
| 2 | Standardize dates to ISO format | `OrderDate`, `Shipping_Date`, `Expected_Delivery_Date` |
| 3 | Create calculated columns | `Order_Year`, `Order_Month`, `Order_Quarter` |
| 4 | Add delivery performance flag | `Delivery_Performance` (On-time/Late) |
| 5 | Create order tier segmentation | `Order_Tier` (Premium/Standard/Budget) |

---

## 📈 Business Questions Answered

1. **Regional Growth Analysis**
   - Which regions show the highest month-over-month revenue growth?
   - Are there seasonal patterns in different markets?

2. **Fulfillment Optimization**
   - Does FBA outperform FBM in delivery reliability?
   - What are the profit margin differences between fulfillment methods?

3. **Product Performance**
   - Which categories and brands are top performers by region?
   - How do discounts impact order volume and profitability?

4. **Customer Segmentation**
   - Who are the high-value customers?
   - What characterizes different customer segments?

---

## 🎨 Dashboard Features

- **KPI Cards**: Revenue, Orders, Profit, AOV, On-time Delivery %
- **Geographic Map**: Revenue distribution by region/country
- **Trend Charts**: Month-over-month growth visualization
- **Comparison Views**: FBA vs FBM performance metrics
- **Interactive Filters**: Date range, Region, Category, Fulfillment type

---


## 📬 Contact

**[Johari Frias]** - Data Analyst

[![LinkedIn](https://www.linkedin.com/in/johari-f-37baa5210/)
[![Portfolio](https://img.shields.io/badge/Portfolio-Visit-green?style=for-the-badge&logo=google-chrome)](https://YOUR_PORTFOLIO_URL)
[![Email](johari19@outlook.com)

---

## ⭐ Show Your Support

If you found this project helpful, please consider giving it a star! ⭐

---

*Built with ❤️ for data-driven decision making*




