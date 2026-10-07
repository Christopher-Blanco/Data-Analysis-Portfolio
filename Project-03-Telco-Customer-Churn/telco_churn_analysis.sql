-- TELCO CUSTOMER CHURN ANALYSIS
-- Requires the previously imported table:
-- telco_churn.telco_customer_churn_clean

USE telco_churn;

-- 1. Validate the imported data
SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT customerID) AS unique_customers,
    SUM(
        TotalCharges IS NULL
        OR TRIM(TotalCharges) = ''
    ) AS missing_total_charges
FROM telco_churn.telco_customer_churn_clean;

-- 2. Create the analysis view
-- Preserve missing total charges as NULL.
-- Rebuild tenure groups using English labels.

CREATE OR REPLACE VIEW telco_churn.customers AS
SELECT
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    CAST(MonthlyCharges AS DECIMAL(10,2)) AS MonthlyCharges,
    CAST(
        NULLIF(TRIM(TotalCharges), '')
        AS DECIMAL(10,2)
    ) AS TotalCharges,
    Churn,
    ChurnFlag,
    CASE
        WHEN tenure = 0 THEN '0 months'
        WHEN tenure BETWEEN 1 AND 12 THEN '1-12 months'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
        WHEN tenure BETWEEN 25 AND 48 THEN '25-48 months'
        WHEN tenure >= 49 THEN '49+ months'
        ELSE 'Unknown'
    END AS TenureGroup
FROM telco_churn.telco_customer_churn_clean;

-- 3. Overall churn metrics
SELECT
    COUNT(*) AS total_customers,
    SUM(TotalCharges IS NULL) AS missing_total_charges,
    SUM(ChurnFlag) AS churned_customers,
    ROUND(AVG(ChurnFlag) * 100, 2) AS churn_rate_pct
FROM telco_churn.customers;

-- 4. Churn by contract type
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(ChurnFlag) AS churned_customers,
    ROUND(AVG(ChurnFlag) * 100, 2) AS churn_rate_pct
FROM telco_churn.customers
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- 5. Churn by contract and internet service
SELECT
    Contract,
    InternetService,
    COUNT(*) AS total_customers,
    SUM(ChurnFlag) AS churned_customers,
    ROUND(AVG(ChurnFlag) * 100, 2) AS churn_rate_pct
FROM telco_churn.customers
GROUP BY Contract, InternetService
ORDER BY Contract, churn_rate_pct DESC;

-- 6. Churn by tenure among month-to-month fiber customers
SELECT
    TenureGroup,
    COUNT(*) AS total_customers,
    SUM(ChurnFlag) AS churned_customers,
    ROUND(AVG(ChurnFlag) * 100, 2) AS churn_rate_pct
FROM telco_churn.customers
WHERE Contract = 'Month-to-month'
    AND InternetService = 'Fiber optic'
GROUP BY TenureGroup
ORDER BY MIN(tenure);

-- 7. Technical support within the priority segment
-- Priority segment: month-to-month, fiber optic, tenure 1-12 months
SELECT
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(ChurnFlag) AS churned_customers,
    ROUND(AVG(ChurnFlag) * 100, 2) AS churn_rate_pct
FROM telco_churn.customers
WHERE Contract = 'Month-to-month'
    AND InternetService = 'Fiber optic'
    AND tenure BETWEEN 1 AND 12
GROUP BY TechSupport
ORDER BY churn_rate_pct DESC;

-- 8. Monthly charges within the priority segment
SELECT
    Churn,
    COUNT(*) AS total_customers,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge,
    MIN(MonthlyCharges) AS min_monthly_charge,
    MAX(MonthlyCharges) AS max_monthly_charge
FROM telco_churn.customers
WHERE Contract = 'Month-to-month'
    AND InternetService = 'Fiber optic'
    AND tenure BETWEEN 1 AND 12
GROUP BY Churn
ORDER BY Churn;

-- 9. Priority segment contribution to overall churn
WITH priority_segment AS (
    SELECT *
    FROM telco_churn.customers
    WHERE Contract = 'Month-to-month'
        AND InternetService = 'Fiber optic'
        AND tenure BETWEEN 1 AND 12
)
SELECT
    COUNT(*) AS segment_customers,
    SUM(ChurnFlag) AS segment_churned,
    ROUND(AVG(ChurnFlag) * 100, 2) AS segment_churn_rate_pct,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM telco_churn.customers),
        2
    ) AS share_of_all_customers_pct,
    ROUND(
        SUM(ChurnFlag) * 100.0 /
        (SELECT SUM(ChurnFlag) FROM telco_churn.customers),
        2
    ) AS share_of_all_churn_pct
FROM priority_segment;

-- Interpretation:
-- These comparisons describe associations, not causal effects.
-- Segment churn rates are not individual risk predictions.
-- 10. Export the complete dataset for Power BI
SELECT *
FROM telco_churn.customers;