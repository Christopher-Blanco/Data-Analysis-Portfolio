# Project 03 — Telco Customer Churn Analysis

## Overview

An analysis of customer churn using Python, MySQL, and Power BI to identify customer segments with higher observed churn and propose retention experiments.

**Business question:** Which customer groups should be prioritized for further investigation and retention initiatives?

## Tools

- Python: pandas and matplotlib
- Google Colab
- MySQL: data validation, views, aggregations, and CTEs
- Power BI: Power Query, DAX measures, and interactive visualizations

## Dataset and Preparation

The dataset contains 7,043 customers and 21 original columns.

- Checked customer IDs: no duplicates found.
- Converted TotalCharges from text to numeric.
- Preserved 11 missing TotalCharges values associated with zero-month tenure.
- Retained all 7,043 customer records.
- Created ChurnFlag and TenureGroup.
- Rebuilt tenure labels in English in the SQL view.

Source: [IBM Telco Customer Churn dataset](https://github.com/IBM/telco-customer-churn-on-icp4d/blob/master/data/Telco-Customer-Churn.csv).

## Key Results

| Metric | Result |
|---|---:|
| Total customers | 7,043 |
| Churned customers | 1,869 |
| Overall churn rate | 26.54% |
| Month-to-month contract churn | 42.71% |
| One-year contract churn | 11.27% |
| Two-year contract churn | 2.83% |

Customers with 1–12 months of tenure had a 47.68% churn rate, compared with 9.51% among customers with 49+ months.

### Priority Segment

Customers with fiber-optic service, month-to-month contracts, and 1–12 months of tenure:

- 916 customers, including 643 who churned.
- 70.20% observed churn rate.
- 13.01% of all customers.
- 34.40% of all churned customers.

This concentration makes the segment a useful starting point for customer research and retention experiments.

## Recommendations

- Investigate cancellation reasons and service experiences within the priority segment.
- Test onboarding improvements and proactive support.
- Test voluntary incentives for longer-term plans.
- Compare pilot outcomes with a control group and evaluate retention costs before expanding.

These are proposed actions, not interventions evaluated in this project.

## Dashboard

The Power BI report contains two pages:

1. Customer Overview: overall metrics, contract and internet-service filters, tenure comparisons, and a churn matrix.
2. Key Findings: findings, proposed actions, and interpretation notes.

[View the report PDF](Telco_Churn_Report.pdf)

## Project Files

| File | Purpose |
|---|---|
| telco_churn_analysis.ipynb | Python cleaning, exploration, charts, and conclusions |
| telco_churn_analysis.sql | SQL validation, analysis view, and segment comparisons |
| Telco_Churn_Analysis.pbix | Interactive Power BI report |
| Telco_Churn_Report.pdf | Static report |
| telco_customer_churn.csv | Original dataset |
| telco_customer_churn_clean.csv | Python output for SQL import |
| telco_churn_powerbi.csv | SQL view exported for Power BI |

## How to Reproduce

1. Open the notebook in Google Colab. Update the input CSV path to match your Google Drive location; the notebook currently expects `/content/drive/MyDrive/Telco-Customer-Churn.csv`.
2. Run the cells in order to generate the cleaned CSV. Adjust the output path if needed.
3. Create a MySQL database named `telco_churn`. Import the cleaned CSV as `telco_customer_churn_clean`, preserving blank TotalCharges values. Importing TotalCharges as text allows the SQL view to convert blanks to NULL.
4. Run the SQL script using MySQL 8.0 or later. It assumes the source table has already been imported.
5. Export the final query's complete result to `telco_churn_powerbi.csv`.
6. Open the PBIX file in Power BI Desktop and update its CSV source path before refreshing.

## Limitations

- This is a sample dataset representing a fictional telecommunications company.
- Associations do not establish causation or predict individual customer behavior.
- Churn rates by tenure are not cumulative probabilities of leaving during those months.
- The Key Findings page contains static text based on the full dataset.
- The PDF is a static export; interactive filtering is available in the PBIX report.
