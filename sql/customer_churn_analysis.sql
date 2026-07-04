-- ============================================================
-- AI-Powered Customer Churn Prediction & Retention Analytics
-- SQL Business Analysis
-- Author: Naveen Kollagunta
-- ============================================================

USE customer_churn;

-- ============================================================
-- SECTION 1 : CUSTOMER OVERVIEW
-- ============================================================

-- Query 1: Total Customers
SELECT COUNT(*) AS Total_Customers
FROM customer_churn_data;

-- Query 2: Total Churned Customers
SELECT COUNT(*) AS Churned_Customers
FROM customer_churn_data
WHERE Churn='Yes';

-- Query 3: Total Retained Customers
SELECT COUNT(*) AS Retained_Customers
FROM customer_churn_data
WHERE Churn='No';

-- Query 4: Churn Rate
SELECT
ROUND(
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),
2
) AS Churn_Rate
FROM customer_churn_data;

-- Query 5: Customers by Gender
SELECT gender,COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY gender;

-- ============================================================
-- SECTION 2 : DEMOGRAPHIC ANALYSIS
-- ============================================================

-- Query 6
SELECT SeniorCitizen,COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY SeniorCitizen;

-- Query 7
SELECT Partner,COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY Partner;

-- Query 8
SELECT Dependents,COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY Dependents;

-- Query 9
SELECT gender,Churn,COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY gender,Churn;

-- Query 10
SELECT SeniorCitizen,Churn,COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY SeniorCitizen,Churn;

-- ============================================================
-- SECTION 3 : CONTRACT ANALYSIS
-- ============================================================

-- Query 11
SELECT Contract,COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY Contract;

-- Query 12
SELECT Contract,Churn,COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY Contract,Churn;

-- Query 13
SELECT Contract,
ROUND(AVG(MonthlyCharges),2) AS Avg_Monthly_Charges
FROM customer_churn_data
GROUP BY Contract;

-- ============================================================
-- SECTION 4 : PAYMENT ANALYSIS
-- ============================================================

-- Query 14
SELECT PaymentMethod,COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY PaymentMethod;

-- Query 15
SELECT PaymentMethod,Churn,COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY PaymentMethod,Churn;

-- ============================================================
-- SECTION 5 : INTERNET SERVICES
-- ============================================================

-- Query 16
SELECT InternetService,COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY InternetService;

-- Query 17
SELECT InternetService,Churn,COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY InternetService,Churn;

-- ============================================================
-- SECTION 6 : TENURE ANALYSIS
-- ============================================================

-- Query 18
SELECT
MIN(tenure) AS Minimum_Tenure,
MAX(tenure) AS Maximum_Tenure,
ROUND(AVG(tenure),2) AS Average_Tenure
FROM customer_churn_data;

-- Query 19
SELECT
CASE
WHEN tenure<=12 THEN '0-12 Months'
WHEN tenure<=24 THEN '13-24 Months'
WHEN tenure<=48 THEN '25-48 Months'
ELSE '49+ Months'
END AS Tenure_Group,
COUNT(*) AS Customers
FROM customer_churn_data
GROUP BY Tenure_Group;

-- ============================================================
-- SECTION 7 : REVENUE ANALYSIS
-- ============================================================

-- Query 20
SELECT
ROUND(SUM(MonthlyCharges),2) AS Total_Monthly_Revenue
FROM customer_churn_data;

-- Query 21
SELECT
ROUND(SUM(TotalCharges),2) AS Total_Revenue
FROM customer_churn_data;

-- Query 22
SELECT
ROUND(SUM(MonthlyCharges),2) AS Monthly_Revenue_Lost
FROM customer_churn_data
WHERE Churn='Yes';

-- ============================================================
-- SECTION 8 : HIGH-RISK CUSTOMERS
-- ============================================================

-- Query 23
SELECT customerID,
Contract,
MonthlyCharges,
tenure
FROM customer_churn_data
WHERE
Churn='Yes'
ORDER BY MonthlyCharges DESC;

-- Query 24
SELECT customerID,
MonthlyCharges,
TotalCharges
FROM customer_churn_data
ORDER BY TotalCharges DESC
LIMIT 10;

-- ============================================================
-- SECTION 9 : BUSINESS KPIs
-- ============================================================

-- Query 25
SELECT
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned,
SUM(CASE WHEN Churn='No' THEN 1 ELSE 0 END) AS Retained,
ROUND(AVG(MonthlyCharges),2) AS Avg_Monthly_Charge,
ROUND(AVG(TotalCharges),2) AS Avg_Total_Charge
FROM customer_churn_data;

-- Query 26
SELECT
Contract,
ROUND(AVG(tenure),2) AS Avg_Tenure
FROM customer_churn_data
GROUP BY Contract;

-- Query 27
SELECT
PaymentMethod,
ROUND(AVG(MonthlyCharges),2) AS Avg_Monthly_Charge
FROM customer_churn_data
GROUP BY PaymentMethod;

-- Query 28
SELECT
InternetService,
ROUND(AVG(TotalCharges),2) AS Avg_Total_Charge
FROM customer_churn_data
GROUP BY InternetService;

-- Query 29
SELECT
Contract,
ROUND(SUM(MonthlyCharges),2) AS Revenue
FROM customer_churn_data
GROUP BY Contract;

-- Query 30
SELECT
Contract,
COUNT(*) AS Customers,
ROUND(AVG(MonthlyCharges),2) AS Avg_Monthly_Charges,
ROUND(AVG(tenure),2) AS Avg_Tenure
FROM customer_churn_data
GROUP BY Contract;
