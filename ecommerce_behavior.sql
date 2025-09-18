-- Create the database
DROP DATABASE IF EXISTS ecommerce_behavior;
CREATE DATABASE ecommerce_behavior;
USE ecommerce_behavior;

-- Create the table for the Online Retail dataset
CREATE TABLE online_retail (
    InvoiceNo VARCHAR(10),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10 , 3 ),
    CustomerID VARCHAR(10),
    Country VARCHAR(50)
);

-- Note: Import data using MySQL Workbench GUI
-- 1. Right-click the 'online_retail' table in the Schemas pane
-- 2. Select 'Table Data Import Wizard'
-- 3. Choose 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Online_Retail.csv'
-- 4. Configure CSV settings (delimiter: comma, header: yes, date format: DD-MM-YYYY HH:MM)
-- 5. Import to load 396,093 rows

-- Check row count to verify data
SELECT 
    COUNT(*)
FROM
    online_retail;

-- Verify first 10 rows of data
SELECT 
    *
FROM
    online_retail
LIMIT 10;

-- Query 1: Total Sales by Country
SELECT 
    Country, ROUND(SUM(Quantity * UnitPrice), 2) AS TotalSales
FROM
    online_retail
GROUP BY Country
ORDER BY TotalSales DESC;

-- Query 2: Top 5 Products by Quantity Sold
SELECT 
    StockCode, Description, SUM(Quantity) AS TotalQuantity
FROM
    online_retail
GROUP BY StockCode , Description
ORDER BY TotalQuantity DESC
LIMIT 5;

-- Query 3: Monthly Sales Summary
SELECT 
    YEAR(InvoiceDate) AS Year,
    MONTHNAME(InvoiceDate) AS Month,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders,
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalRevenue
FROM
    online_retail
GROUP BY YEAR(InvoiceDate) , MONTH(InvoiceDate) , MONTHNAME(InvoiceDate)
ORDER BY YEAR(InvoiceDate) , MONTH(InvoiceDate);

-- Query 4: Top Customers by Spending
SELECT 
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS PurchaseCount,
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalSpent
FROM
    online_retail
GROUP BY CustomerID
HAVING TotalSpent > 1000
ORDER BY TotalSpent DESC
LIMIT 10;