# 📦 Amazon Global Sales Analytics

> **End-to-End Data Analytics Project: From Raw Data to Executive Insights Across 5 Strategic Dashboards**

[![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue?style=flat-square&logo=postgresql)](https://www.postgresql.org/)
[![Excel](https://img.shields.io/badge/Excel-Data%20Cleaning-green?style=flat-square&logo=microsoft-excel)](https://www.microsoft.com/excel)
[![Tableau](https://img.shields.io/badge/Tableau-Visualization-orange?style=flat-square&logo=tableau)](https://public.tableau.com/)

---

## 🎯 Project Overview

An Amazon global e-commerce marketplace generates millions of dollars in cross-border revenue, yet hidden inefficiencies in logistics, pricing, and inventory quietly erode profitability. This project analyzes **50,000+ transactions across 14 countries** to answer one core question: **where is the business leaking value, and how do we fix it?**

Through a five-dashboard analytical suite, the analysis systematically dissects the operation—from supply chain bottlenecks and margin-destroying payment methods, to discount strategies that fail and inventory capital misallocated to low-margin products. The result is a data-driven action plan that identifies **$978K in recoverable hidden costs** and provides a roadmap for optimizing every layer of the business.

---

## 🛠️ Tools & Technologies

- **Microsoft Excel** — Data cleaning, null handling, date standardization, and feature engineering (calculated columns for delivery performance, order tiers, and date hierarchies)
- **PostgreSQL / SQL Server** — Analytical queries using CTEs, window functions (RANK, LAG, running totals), CASE-based segmentation, and multi-table aggregations
- **Tableau** — 5 interactive dashboards with KPI cards, heatmaps, Pareto charts, scatter quadrants, waterfall charts, dumbbell charts, and geographic treemaps
- **HTML / CSS / JavaScript** — Responsive portfolio website with animated UI, intersection observers, and glassmorphism design

---

## 📊 Key Dashboards & Insights

### Dashboard 4 — Logistics & Supply Chain Command Center

**Purpose:** Identify delivery bottlenecks across couriers, fulfillment types, shipping methods, and countries.

**KPIs Tracked:** Late Delivery Rate, Avg. Delivery Days, On-Time %, Shipping Cost vs. Promise

**Critical Insight:** Expedited shipping—the most expensive option—has the **highest late delivery rate (12–19%)**, with FBM Expedited in the US failing on nearly 1 in 5 orders. Meanwhile, FBA vs. FBM performance is nearly identical in standard tiers, contradicting conventional assumptions. UPS (8.75% late) and USPS (7.73%) are the worst-performing couriers.

---

### Dashboard 5 — Global Profitability & Margin Erosion

**Purpose:** Trace the path from gross revenue to true net profit, exposing hidden cost layers.

**KPIs Tracked:** Revenue vs. True Profit, Shipping Cost, Payment Fees, Refund Amount, Margin by Category × Region

**Critical Insight:** $9.25M in revenue is reduced to $8.27M true profit by **$978K in hidden costs**—shipping ($346K), payment fees ($233K), and refunds ($399K). Catastrophic regional losses exist in South America (Books: -231.8% margin) and Asia (Books: -167.8%). UPI and NetBanking payment methods cost **more than they generate** (203.7% and 152.4% fee rates).

---

### Dashboard 6 — Global Sales & Revenue Optimization

**Purpose:** Identify the most profitable markets, evaluate discount effectiveness, and map seasonal purchasing patterns.

**KPIs Tracked:** Revenue by Channel/Country, Profit Margin %, Discount Rate vs. Volume, Day-of-Week Revenue, Monthly Trends

**Critical Insight:** Amazon.com (US) generates 29.6% of revenue but operates at only **9.1% profit margin**—less than half of European markets (21–24%). The 5–10% discount tier delivers **identical margins to full price** with no incremental volume—proving these discounts are unnecessary and waste an estimated $100K–150K annually. Order volume drops 49% from August to September.

---

### Dashboard 7 — Customer Behavior & Loyalty Command Center

**Purpose:** Quantify the value gap between Prime and Non-Prime customers and optimize checkout experiences across 14 markets.

**KPIs Tracked:** AOV by Cohort, Units Per Transaction, Refund Rate by Cohort × Category, Payment Method Share by Country

**Critical Insight:** Prime members spend **18.6% more per order** ($261 vs. $220) by buying higher-value products, not more items (UPT is identical at 1.7). Return rates are virtually identical (Prime 3.01% vs. Non-Prime 2.99%)—meaning every Prime conversion is **pure upside with zero refund penalty**. Three distinct checkout profiles exist globally: Credit Card-dominant (65–75%), Cash-on-Delivery markets (14–24%), and Regional Digital Payment markets (India: UPI 24%, Brazil: Pix 25%).

---

### Dashboard 8 — Product & Inventory Strategy Command Center

**Purpose:** Classify SKUs into performance quadrants to optimize inventory capital allocation.

**KPIs Tracked:** Units Sold, Profit, Profit/Unit, Defect Rate, Variant Popularity by Brand

**Critical Insight:** Of 198 products analyzed, **74.7% are classified as "Bleeders"** (high volume, low profit). Only 35 qualify as "Heroes"—and **22 of those are Gaming products**, creating dangerous category concentration. Five entire categories (Books, Beauty, Clothing, Toys, Home & Kitchen) have **zero Hero products**. Pink is the #1 selling color variant across 6 of 10 brands.

---

## 💡 Business Impact & Recommendations

The analysis surfaces **5 high-priority actions** that a stakeholder should take immediately:

| Priority | Action | Quantified Impact |
|:---:|---|---|
| 🔴 P0 | **Renegotiate or exit UPI & NetBanking** — these payment methods cost 203.7% and 152.4% of transaction value | Save $10.8K in direct losses |
| 🔴 P0 | **Eliminate the 5–10% discount tier** — provides zero incremental volume at identical margins to full price | Recover $100K–150K in wasted margin |
| 🟡 P1 | **Restructure Expedited shipping for FBM** — 19% late rate in the US is unacceptable for a premium service | Reduce refund exposure from $398K pool |
| 🟡 P1 | **Shift inventory capital from Bleeders to Heroes** — 74.7% of products underperform; reallocate to Gaming's 22 Hero SKUs | Improve portfolio margin from 17.7% |
| 🟢 P2 | **Scale European channels** — Italy, Germany, UK deliver 21–24% margins vs. US at 9.1% | Each € of European revenue worth 2.6× a US $ |

> *This analysis demonstrates that the difference between a $9.25M revenue business and a $9.8M+ profit-optimized operation lies not in selling more, but in eliminating the hidden costs already embedded in the existing data.*

---

## 📁 Repository Structure

```
amazon-global-sales-analytics/
├── 📂 sql-queries/
│   └── amazon_sales_analytics.sql          # 15+ analytical queries (CTEs, window functions)
├── 📂 portfolio/
│   ├── index.html                          # Portfolio web page
│   ├── styles.css                          # Dark theme with glassmorphism
│   └── script.js                           # Scroll animations & interactivity
├── Amazon_Sales_Data_50k_Enhanced.xlsx     # Source dataset (50K+ records)
└── README.md
```

---

## 📬 Contact

**[Your Name]** — Data Analyst

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=for-the-badge&logo=linkedin)](https://linkedin.com/in/YOUR_PROFILE)
[![Portfolio](https://img.shields.io/badge/Portfolio-Visit-green?style=for-the-badge&logo=google-chrome)](https://YOUR_PORTFOLIO_URL)
[![Email](https://img.shields.io/badge/Email-Contact-red?style=for-the-badge&logo=gmail)](mailto:your.email@example.com)

---

*Built with ❤️ for data-driven decision making*
