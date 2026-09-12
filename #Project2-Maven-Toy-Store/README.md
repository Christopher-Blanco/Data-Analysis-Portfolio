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
