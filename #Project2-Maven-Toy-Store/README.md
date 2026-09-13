# Maven Fuzzy Factory E-Commerce Analysis

## Project Overview

This project analyzes e-commerce data from **Maven Fuzzy Factory**, an online retailer specializing in teddy bears. The dataset contains detailed information about website traffic, user sessions, pageviews, orders, products, and refunds between **March 2012 and March 2015**.

The goal of this project is to use **MySQL** to explore the company's website and sales performance, identify key business trends, and evaluate how effectively website traffic is converted into revenue.

The analysis focuses on four main business questions:

- How have website sessions and order volume evolved over time?
- How has the session-to-order conversion rate changed?
- Which marketing channels generated the most website traffic?
- How have revenue per order and revenue per session evolved?

Before performing the analysis, the dataset was reviewed and validated to ensure that the tables, data types, date ranges, and relationships between tables were correctly structured.

### Data Source

The dataset used in this project was provided by **Maven Analytics** as part of the **Maven Fuzzy Factory** e-commerce dataset. It includes website sessions, pageviews, orders, products, order items, and refunds covering the period from **March 2012 to March 2015**.
The original dataset and data dictionary were used as the reference for validating the database structure before analysis.

## Dataset & Database Structure

The dataset contains e-commerce, website traffic, product, and refund data from **March 2012 to March 2015**. It is organized into six relational tables that represent different stages of the customer journey, from visiting the website to completing an order and potentially requesting a refund.

### Database Tables

| Table | Description | Row Granularity |
|---|---|---|
| `website_sessions` | Contains information about each website visit, including traffic source, campaign, device type, and whether the visitor is a returning user. | One row per website session |
| `website_pageviews` | Records the pages viewed during each website session. | One row per pageview |
| `orders` | Contains completed customer orders, including total revenue, cost of goods sold, and number of items purchased. | One row per order |
| `order_items` | Provides item-level details for each order, including product, price, cost, and whether it was the primary product. | One row per item purchased |
| `products` | Contains the product catalog and product launch dates. | One row per product |
| `order_item_refunds` | Records refunds issued for individual order items. | One row per refunded item |

### Dataset Size

- **472,871** website sessions
- **1,188,124** website pageviews
- **32,313** orders
- **40,025** order items
- **1,731** refunds
- **4** products

### Table Relationships

The main relationships between the tables are:

- `website_sessions.website_session_id` → `website_pageviews.website_session_id`
- `website_sessions.website_session_id` → `orders.website_session_id`
- `orders.order_id` → `order_items.order_id`
- `products.product_id` → `order_items.product_id`
- `order_items.order_item_id` → `order_item_refunds.order_item_id`

The database structure follows the customer journey from website acquisition to purchase and post-purchase activity:

`Website Session → Pageviews → Order → Order Items → Refund`

The `products` table acts as a reference table for identifying the products associated with each order item.

## Data Preparation & Validation

Before starting the business analysis, the dataset was reviewed to verify that the imported tables matched the original CSV files and that the data was complete and usable.

Several validation steps were performed:

- Compared the imported MySQL tables against the original CSV files and the Maven Fuzzy Factory data dictionary.
- Identified that the original `orders` table had been created without the `user_id` column, which caused several fields to shift into the wrong columns during import.
- Recreated the `orders` table with the correct structure and re-imported the source data.
- Detected that `website_sessions` had only partially imported, containing just 601 rows instead of the full dataset.
- Re-imported `website_sessions` using `LOAD DATA LOCAL INFILE`, successfully loading **472,871 rows** with no skipped records or warnings.
- Corrected `website_sessions.created_at` from `TEXT` to `DATETIME` to support time-based analysis.
- Verified row counts, date ranges, distinct identifiers, and table relationships before beginning the analysis.
- Checked that all **32,313 orders** were represented in `order_items`.
- Confirmed that all **1,188,124 website pageview IDs** were unique.
- Confirmed that the website session and pageview data both covered the same analysis period from **March 2012 to March 2015**.

These checks helped ensure that the analysis was performed on a complete and correctly structured dataset.

### Validation Summary

| Validation Check | Result |
|---|---|
| Website sessions imported | 472,871 |
| Website pageviews imported | 1,188,124 |
| Orders imported | 32,313 |
| Orders represented in `order_items` | 32,313 |
| Unique pageview IDs | 1,188,124 |
| Distinct products | 4 |
| Analysis period | March 2012 – March 2015 |

### Large CSV Import

Because MySQL Workbench's Table Data Import Wizard struggled with the larger `website_sessions.csv` file, the dataset was imported using `LOAD DATA LOCAL INFILE`, which provided a faster and more reliable import process.

```sql
LOAD DATA LOCAL INFILE
'C:/path/to/website_sessions.csv'
INTO TABLE website_sessions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
```

## Business Analysis

The analysis focuses on four key business questions related to website growth, conversion performance, marketing acquisition, and revenue efficiency.

### 1. Website Sessions & Order Volume Trend

**Business Question:**  
How have website sessions and order volume evolved over time?

To evaluate overall business growth, website sessions and completed orders were aggregated by month. Monthly session volume was calculated from the `website_sessions` table, while order volume was calculated from the `orders` table.

```sql
WITH monthly_sessions AS (
    SELECT
        DATE_FORMAT(created_at, '%Y-%m') AS month,
        COUNT(*) AS sessions
    FROM website_sessions
    GROUP BY DATE_FORMAT(created_at, '%Y-%m')
),

monthly_orders AS (
    SELECT
        DATE_FORMAT(created_at, '%Y-%m') AS month,
        COUNT(*) AS orders
    FROM orders
    GROUP BY DATE_FORMAT(created_at, '%Y-%m')
)

SELECT
    s.month,
    s.sessions,
    COALESCE(o.orders, 0) AS orders
FROM monthly_sessions s
LEFT JOIN monthly_orders o
    ON s.month = o.month
ORDER BY s.month;
```

#### Key Findings

Website traffic and order volume showed a clear overall growth trend throughout the analysis period.

In 2012, monthly website traffic was relatively low, with **3,734 sessions and 99 orders in April**. By late 2014, the business had grown substantially. For example, **December 2014 recorded 29,722 sessions and 2,314 orders**.

The results also show noticeable increases in traffic and orders toward the end of several years, suggesting possible seasonal demand or increased marketing activity during those periods.

Overall, the company experienced significant growth in both website traffic and completed purchases between 2012 and 2015.

> **Note:** March 2012 and March 2015 contain partial-month data because the dataset begins on March 19, 2012 and ends on March 19, 2015.

### 2. Session-to-Order Conversion Rate

**Business Question:**  
What is the session-to-order conversion rate, and how has it changed over time?

The conversion rate measures the percentage of website sessions that resulted in a completed order.

The metric was calculated as:

`Conversion Rate = Orders / Sessions × 100`

```sql
WITH monthly_sessions AS (
    SELECT
        DATE_FORMAT(created_at, '%Y-%m') AS month,
        COUNT(*) AS sessions
    FROM website_sessions
    GROUP BY DATE_FORMAT(created_at, '%Y-%m')
),

monthly_orders AS (
    SELECT
        DATE_FORMAT(created_at, '%Y-%m') AS month,
        COUNT(*) AS orders
    FROM orders
    GROUP BY DATE_FORMAT(created_at, '%Y-%m')
)

SELECT
    s.month,
    s.sessions,
    o.orders,
    ROUND((o.orders / s.sessions) * 100, 2) AS conversion_rate
FROM monthly_sessions s
LEFT JOIN monthly_orders o
    ON s.month = o.month
ORDER BY s.month;
```

#### Key Findings

The session-to-order conversion rate showed a strong overall improvement during the analysis period.

In early 2012, monthly conversion rates were generally around **3% to 4%**. By 2013, the rate had increased to approximately **6% to 7%**, and by early 2015 it exceeded **8%**.

For example, the conversion rate increased from **2.65% in April *2012* to **8.70% in February 2015**.

Although there were month-to-month fluctuations, the long-term trend indicates that the website became significantly more effective at converting traffic into completed purchases.

This suggests that business growth was not driven only by increased website traffic; the quality and effectiveness of the customer journey also improved over time.

### 3. Marketing Channel Performance

**Business Question:**  
Which marketing channels generated the most website traffic?

Website sessions were grouped by acquisition channel using the `utm_source` and `http_referer` fields. Sessions with no UTM source were classified as direct or organic traffic based on the referring website.

```sql
SELECT
    CASE
        WHEN utm_source = 'gsearch' THEN 'Paid Search - gsearch'
        WHEN utm_source = 'bsearch' THEN 'Paid Search - bsearch'
        WHEN utm_source = 'socialbook' THEN 'Social'
        WHEN utm_source IS NULL
             AND http_referer = 'https://www.gsearch.com'
            THEN 'Organic Search - gsearch'
        WHEN utm_source IS NULL
             AND http_referer = 'https://www.bsearch.com'
            THEN 'Organic Search - bsearch'
        WHEN utm_source IS NULL
             AND http_referer IS NULL
            THEN 'Direct'
        ELSE 'Other'
    END AS channel,
    COUNT(*) AS sessions
FROM website_sessions
GROUP BY channel
ORDER BY sessions DESC;
```

#### Key Findings

Paid search was the dominant source of website traffic.

**Paid Search - gsearch** generated **316,035 sessions**, representing roughly **66.8% of all website sessions** during the analysis period.

The remaining channels contributed significantly less traffic:

- Paid Search - bsearch: **62,823 sessions**
- Direct: **39,917 sessions**
- Organic Search - gsearch: **35,202 sessions**
- Social: **10,685 sessions**
- Organic Search - bsearch: **8,209 sessions**

The results show that Maven Fuzzy Factory relied heavily on paid search, particularly gsearch, as its primary traffic acquisition channel.

This concentration suggests that paid search played a central role in the company's growth strategy, while direct, organic, and social traffic represented a much smaller share of total website sessions.

### 4. Revenue per Order & Revenue per Session

**Business Question:**  
How has revenue per order evolved over time, and how much revenue is generated per website session?

Revenue per order measures the average value of each completed transaction, while revenue per session measures how much revenue is generated, on average, from each website visit.

#### Revenue per Order

```sql
SELECT
    DATE_FORMAT(created_at, '%Y-%m') AS month,
    COUNT(*) AS orders,
    ROUND(SUM(price_usd), 2) AS total_revenue,
    ROUND(AVG(price_usd), 2) AS revenue_per_order
FROM orders
GROUP BY DATE_FORMAT(created_at, '%Y-%m')
ORDER BY month;
```

#### Revenue per Session

```sql
WITH monthly_sessions AS (
    SELECT
        DATE_FORMAT(created_at, '%Y-%m') AS month,
        COUNT(*) AS sessions
    FROM website_sessions
    GROUP BY DATE_FORMAT(created_at, '%Y-%m')
),

monthly_revenue AS (
    SELECT
        DATE_FORMAT(created_at, '%Y-%m') AS month,
        SUM(price_usd) AS total_revenue
    FROM orders
    GROUP BY DATE_FORMAT(created_at, '%Y-%m')
)

SELECT
    s.month,
    s.sessions,
    ROUND(COALESCE(r.total_revenue, 0), 2) AS total_revenue,
    ROUND(
        COALESCE(r.total_revenue, 0) / s.sessions,
        2
    ) AS revenue_per_session
FROM monthly_sessions s
LEFT JOIN monthly_revenue r
    ON s.month = r.month
ORDER BY s.month;
```

#### Key Findings

Revenue per order increased steadily over the analysis period.

In 2012, average revenue per order was approximately **$49.99**, reflecting a period when the business had a smaller product catalog. By 2014 and early 2015, average revenue per order had increased to roughly **$63–$65**.

This increase likely reflects the expansion of the product catalog and the growing presence of multi-item orders.

Revenue per session also showed strong growth. In early 2012, each website session generated roughly **$1–$2 in revenue**, while by early 2015 this had increased to more than **$5 per session**.

For example, revenue per session reached approximately **$5.43 in February 2015**.

This improvement was driven by two factors working together:

- A higher session-to-order conversion rate
- A higher average revenue per order

As a result, website traffic became significantly more valuable over time.

## Key Findings

- **Website traffic and order volume grew substantially over time.** Monthly sessions increased from fewer than 4,000 in early 2012 to nearly 30,000 by late 2014, while monthly orders grew from fewer than 100 to more than 2,000.

- **The website became significantly more effective at converting visitors into customers.** The session-to-order conversion rate increased from roughly **3% in early 2012** to more than **8% by early 2015**.

- **Paid search was the primary traffic acquisition channel.** Paid Search through `gsearch` generated **316,035 sessions**, accounting for approximately **66.8% of all website traffic**.

- **Average revenue per order increased as the business matured.** Revenue per order grew from approximately **$49.99 in 2012** to around **$63–$65 by 2014–2015**, likely supported by product expansion and multi-item purchases.

- **Website traffic became much more valuable over time.** Revenue per session increased from roughly **$1–$2 in 2012** to more than **$5 by early 2015**, driven by both stronger conversion rates and higher order values.

- Overall, Maven Fuzzy Factory demonstrated growth not only in traffic and sales volume, but also in **conversion efficiency and revenue generation per visitor**.

## Tools & Skills Used

### Tools

- **MySQL / MySQL Workbench** — Database creation, data validation, SQL analysis, joins, aggregations, and KPI calculations
- **GitHub** — Project documentation and portfolio presentation
- **CSV / Maven Analytics Dataset** — Source data and data dictionary

### SQL Skills Demonstrated

- Data validation and quality checks
- `JOIN` operations
- Common Table Expressions (`CTEs`)
- `CASE` statements
- `GROUP BY` and aggregations
- `COUNT`, `SUM`, and `AVG`
- `DATE_FORMAT` for time-based analysis
- `COALESCE` for handling missing values
- Conversion rate calculations
- Revenue and traffic KPI analysis
- Working with relational data at different levels of granularity

### Analytical Skills Demonstrated

- Understanding database relationships and row granularity
- Translating business questions into SQL queries
- E-commerce performance analysis
- Marketing channel analysis
- Conversion funnel reasoning
- Trend analysis
- Data quality validation
- Interpreting results and communicating business insights

## Conclusion

This project provided a technical analysis of Maven Fuzzy Factory's e-commerce performance using SQL.

The analysis showed that the company experienced strong growth between 2012 and 2015, with increasing website traffic, order volume, conversion rates, and revenue efficiency. Paid search, particularly gsearch, was the primary source of website traffic, while improvements in both conversion rate and average order value made each website session increasingly valuable over time.

Beyond answering the main business questions, the project also involved validating the database structure, identifying data import issues, and working with multiple related tables at different levels of granularity.

Overall, this project strengthened my ability to use SQL not only to query data, but also to understand a relational database, validate data quality, calculate business KPIs, and translate results into actionable insights.
