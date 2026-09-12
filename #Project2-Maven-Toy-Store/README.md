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
