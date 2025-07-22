-- Database: Testdb

-- DROP DATABASE IF EXISTS "Testdb";

CREATE DATABASE "Testdb"
    WITH
    OWNER = pg_database_owner
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- COMMENT ON DATABASE "Testdb"
--     IS 'Testdb user 16385';



	
    
    
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY, -- Ensures unique and non-NULL UserID
    UserName VARCHAR(100)
);


ALTER TABLE Orders (
    OrderID INT PRIMARY KEY,
    UserID INT,
    OrderDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) -- Ensures UserID exists in Users table
);

-- Table: public.employees

-- DROP TABLE IF EXISTS public.employees;

CREATE TABLE IF NOT EXISTS public.employees
(
    id integer NOT NULL,
    name character varying(50) COLLATE pg_catalog."default",
    age integer,
    department character varying(50) COLLATE pg_catalog."default",
    phone_number numeric(12,0),
    hire_date date,
    manager_id integer,
    salary money,
    dept_id integer,
    CONSTRAINT employees_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.employees
    OWNER to postgres;
-- Index: idx_name

-- DROP INDEX IF EXISTS public.idx_name;

CREATE INDEX IF NOT EXISTS idx_name
    ON public.employees USING btree
    (name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Enforcing domain integrity (CHECK constraint for age)
ALTER TABLE Employees
ADD CONSTRAINT CHK_Age CHECK (age >= 18);

-- A fundamental SQL query
SELECT name FROM Employees WHERE department = 'Sales';




-- This is a single-line comment
SELECT
    id, -- Selects the employee ID
     name   -- Selects the first name
FROM
    Employees; -- From the Employees table
/* This is a
   multi-line comment */



-- DDL: Create a table
CREATE TABLE Products (ProductID INT PRIMARY KEY);
-- DML: Insert data
INSERT INTO Products (ProductID) VALUES (1);
-- DQL: Query data
SELECT * FROM Products;
-- DCL: Grant permission
GRANT SELECT ON Products TO public;
-- TCL: Commit transaction
COMMIT;





CREATE TABLE UserProfiles (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Age SMALLINT,
    RegistrationDate DATE,
    IsActive BOOLEAN,
    Balance DECIMAL(10, 2)
);


-- Good table name
CREATE TABLE customer_feedback (
    feedback_id INT PRIMARY KEY,
    comment TEXT
);



-- Bad table name (reserved keyword)
-- CREATE TABLE ORDER (order_id INT);

-- Bad table name (spaces)
-- CREATE TABLE My Table (id INT);
drop table Products Use DROP products_pkey CASCADE 
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL UNIQUE,
    Price DECIMAL(10, 2) DEFAULT 0.00,
    StockQuantity INT CHECK (StockQuantity >= 0)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    OrderDate DATE DEFAULT CURRENT_DATE,
    Quantity INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);




-- CREATE TABLE
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- ALTER TABLE: Add a new column
ALTER TABLE Customers ADD Email VARCHAR(100);

-- ALTER TABLE: Modify an existing column (syntax varies by DB)
-- For PostgreSQL/Oracle: ALTER TABLE Customers ALTER COLUMN Email TYPE VARCHAR(150);
-- For MySQL: ALTER TABLE Customers MODIFY COLUMN Email VARCHAR(150);
-- For SQL Server: ALTER TABLE Customers ALTER COLUMN Email VARCHAR(150);

-- ALTER TABLE: Drop a column
ALTER TABLE Customers DROP COLUMN LastName;

-- DROP TABLE
DROP TABLE Customers;

-- TRUNCATE TABLE
TRUNCATE TABLE Customers; -- Empties the table, but keeps structure



-- Creating a regular table
CREATE TABLE PermanentData (ID INT);

-- Creating a temporary table (syntax varies by DB)
-- SQL Server, Oracle:
CREATE TEMPORARY TABLE SessionData (ID INT); -- or GLOBAL/LOCAL TEMPORARY in some
-- MySQL:
CREATE TEMPORARY TABLE SessionData (ID INT);
-- PostgreSQL:
CREATE TEMPORARY TABLE SessionData (ID INT) ON COMMIT DROP; -- or ON COMMIT PRESERVE ROWS

/***************************************/

-- Create a sample table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Price DECIMAL(10, 2)
);

-- Insert a row with values for all columns
INSERT INTO Products (ProductID, ProductName, Price)
VALUES (1, 'Laptop', 1200.00);

-- Insert a row, specifying only some columns (others will be NULL or default)
INSERT INTO Products (ProductID, ProductName)
VALUES (2, 'Mouse');

-- Insert multiple rows in a single statement (supported by most modern DBs)
INSERT INTO Products (ProductID, ProductName, Price)
VALUES
    (3, 'Keyboard', 75.00),
    (4, 'Monitor', 300.00);




-- Delete a specific product by ID
DELETE FROM Products
WHERE ProductID = 1;

-- Delete all products with a price less than 100
DELETE FROM Products
WHERE Price < 100;

-- !!! DANGER ZONE: Delete all rows from the table (no WHERE clause) !!!
-- DELETE FROM Products;



-- Update the price of a specific product
UPDATE Products
SET Price = 1250.00
WHERE ProductID = 1;

-- Update the name for all products with a certain price
UPDATE Products
SET ProductName = 'Discounted Item'
WHERE Price < 100;

-- Update multiple columns for a specific product
UPDATE Products
SET
    ProductName = 'Gaming Laptop',
    Price = 1500.00
WHERE ProductID = 1;

-- !!! DANGER ZONE: Update all rows in the table (no WHERE clause) !!!
-- UPDATE Products SET Price = Price * 1.10; -- 10% price increase for ALL products

-- Create an index on the 'ProductName' column to speed up searches by name
CREATE INDEX idx_product_name ON Products (ProductName);

-- Create a unique index to enforce uniqueness (like a UNIQUE constraint)
CREATE UNIQUE INDEX idx_email_unique ON Users (Email);

-- Drop an index
DROP INDEX idx_product_name ON Products;


-- Create a synonym for a table (syntax varies slightly by DB, e.g., Oracle, SQL Server)
-- Oracle:
CREATE SYNONYM my_products FOR scott.products;

-- SQL Server:
CREATE SYNONYM my_products FOR database_name.schema_name.products;

-- Now you can query using the synonym
SELECT * FROM my_products;

-- Drop a synonym
DROP SYNONYM my_products;


-- Create a sequence (syntax varies by DB)
-- Oracle:
CREATE SEQUENCE product_id_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

-- PostgreSQL:
CREATE SEQUENCE product_id_seq START 1 INCREMENT 1;

-- Use the sequence to insert a new product (Oracle example)
INSERT INTO Products (ProductID, ProductName, Price)
VALUES (product_id_seq.NEXTVAL, 'New Gadget', 50.00);

-- Get current value (Oracle)
SELECT product_id_seq.CURRVAL FROM DUAL;

-- Drop a sequence
DROP SEQUENCE product_id_seq;


select * from Employees
select * from Departments
-- Create a view showing employee names and their department names
CREATE VIEW EmployeeDepartmentView AS
SELECT
    E.Name AS EmployeeName,
    D.DepartmentName
FROM
    Employees E
JOIN
    Departments D ON E.dept_id = D.DepartmentID;

-- Query the view just like a table
SELECT EmployeeName FROM EmployeeDepartmentView WHERE DepartmentName = 'HR';

-- Drop a view
DROP VIEW EmployeeDepartmentView;




SELECT * FROM Employees;

-- Select specific columns (Name, Salary) from the Employees table
SELECT Name, Salary FROM Employees;

-- Select with an alias for a column
SELECT Name AS EmployeeName, Salary FROM Employees;


-- Get all unique department names from the Employees table
SELECT DISTINCT department FROM Employees;

-- Get unique combinations of department and age
SELECT DISTINCT department, age FROM Employees;



INSERT INTO public.employees
(id, name, age, department, phone_number, hire_date, manager_id, salary, dept_id)
VALUES
(1, 'Alice Johnson', 29, 'HR', 555-1234, '2018-03-15', 12, 60000, 101),
(2, 'Brian Smith', 35, 'Finance', 555-5678, '2016-07-20', 15, 75000, 102),
(3, 'Catherine Lee', 31, 'Engineering', 555-9101, '2019-01-08', 7, 95000, 103),
(4, 'David Kim', 28, 'Engineering', 555-1122, '2020-02-17', 3, 70000, 103),
(5, 'Emma Williams', 42, 'Marketing', 555-3344, '2012-11-30', 16, 80000, 104),
(6, 'Frank Miller', 38, 'Finance', 555-5566, '2015-06-11', 2, 82000, 102),
(7, 'Grace Chen', 39, 'Engineering', 555-7788, '2010-09-19', NULL, 110000, 103),
(8, 'Harry Davis', 27, 'HR', 555-9900, '2021-04-01', 1, 52000, 101),
(9, 'Irene Moore', 33, 'Sales', 555-2233, '2017-12-05', 17, 67000, 105),
(10, 'Jack Wilson', 36, 'Engineering', 555-4455, '2014-05-23', 3, 90000, 103),
(11, 'Karen Brown', 30, 'Marketing', 555-6677, '2019-08-10', 5, 63000, 104),
(12, 'Luke Anderson', 48, 'HR', 555-8899, '2008-01-20', NULL, 105000, 101),
(13, 'Maria Garcia', 26, 'Sales', 555-1212, '2022-07-13', 9, 54000, 105),
(14, 'Nathan Scott', 34, 'Finance', 555-2323, '2015-04-15', 6, 78000, 102),
(15, 'Olivia Martinez', 44, 'Finance', 555-3434, '2011-11-02', NULL, 120000, 102),
(16, 'Paul Robinson', 41, 'Marketing', 555-4545, '2013-03-19', NULL, 98000, 104),
(17, 'Quinn Turner', 38, 'Sales', 555-5656, '2016-09-07', NULL, 91000, 105),
(18, 'Rachel Evans', 29, 'HR', 555-6767, '2018-06-15', 1, 60000, 101),
(19, 'Samuel White', 25, 'Engineering', 555-7878, '2023-01-09', 4, 58000, 103),
(20, 'Teresa Harris', 32, 'Sales', 555-8989, '2017-03-06', 17, 66000, 105);




-- Comparison: Employees older than 30
SELECT Name, Age FROM Employees WHERE Age > 30;

-- Arithmetic: Calculate increased salary
SELECT Name, Salary, Salary * 1.05 AS NewSalary FROM Employees;

-- Logical: Employees in HR AND salary > 50000
SELECT Name, department, Salary FROM Employees

WHERE department = 'HR' AND Salary > 50000;

-- Combining logical (NOT) and comparison (IN)
SELECT Name, department FROM Employees
WHERE department NOT IN ('HR', 'IT');

-- Order employees by name alphabetically
SELECT Name, Department FROM Employees ORDER BY Name ASC;

-- Order employees by salary, highest first
SELECT Name, Salary FROM Employees ORDER BY Salary DESC;

-- Order by department (ASC) then by salary (DESC) within each department
SELECT Name, Department, Salary FROM Employees
ORDER BY Department ASC, Salary DESC;


-- Tip: Use aliases for table names for shorter, cleaner joins
SELECT E.Name, D.DepartmentName
FROM Employees AS E -- 'AS' is optional but good for clarity
JOIN Departments AS D ON E.dept_id = D.DepartmentID;

-- Trick: Use `LIKE` with wildcards (`%`, `_`) for pattern matching
SELECT ProductName FROM Products WHERE ProductName LIKE 'L%'; -- Starts with 'L'
SELECT ProductName FROM Products WHERE ProductName LIKE '%top'; -- Ends with 'top'
SELECT ProductName FROM Products WHERE ProductName LIKE '_ouse'; -- 5 letters, second to last is 's'

-- Tip: Use `IN` for multiple OR conditions
SELECT Name FROM Employees WHERE Department IN ('HR', 'Sales', 'Marketing');
-- Equivalent to: WHERE Department = 'HR' OR Department = 'Sales' OR Department = 'Marketing'


-- Count the number of employees in each department
SELECT department, COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY department;

-- Calculate the average salary for each department
SELECT department, (SUM(Salary)/count(*)) AS AverageSalary
FROM Employees
GROUP BY department;

-- Count employees per department and manager
SELECT department, manager_id, COUNT(*)
FROM Employees
GROUP BY department, manager_id;

-- Find departments with more than 5 employees
SELECT department, COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY department
HAVING COUNT(*) > 5;

-- Find departments where the average salary is above 60000
SELECT department, (SUM(Salary)/count(*)) AS AverageSalary
FROM Employees
GROUP BY department
HAVING (money(SUM(Salary)/count(*))) > money(60000);

-- Calculate sum of salaries by department, then by department and manager, and a grand total.
SELECT department, manager_id, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY ROLLUP(department, manager_id);
-- Output might look like:
-- Department | Manager_ID | TotalSalary
-- Sales      | 101        | 50000
-- Sales      | 102        | 70000
-- Sales      | NULL       | 120000 (Subtotal for Sales)
-- HR         | 201        | 45000
-- HR         | NULL       | 45000  (Subtotal for HR)
-- NULL       | NULL       | 165000 (Grand Total)



-- Calculate sum of salaries for all possible combinations of department and manager
SELECT department, manager_id, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY CUBE(department, manager_id);
-- Output will include:
-- (department, manager_id) totals
-- (department, NULL) totals (subtotal for each department)
-- (NULL, manager_id) totals (subtotal for each manager)
-- (NULL, NULL) grand total

-- Tip: Use COUNT(DISTINCT column) to count unique values in a group
SELECT department, COUNT(DISTINCT manager_id) AS UniqueManagers
FROM Employees
GROUP BY department;


-- Trick: Be careful with NULLs in aggregate functions
-- COUNT(*) counts all rows. COUNT(column_name) counts non-NULL values in that column.
SELECT COUNT(*), COUNT(manager_id) FROM Employees;

-- Tip: Filtering with WHERE before GROUP BY for efficiency
SELECT department,  (money(SUM(Salary))//(count(*))) as Average
FROM Employees
WHERE Salary > 40000 -- Filter out low earners before grouping
GROUP BY department
HAVING COUNT(*) > 2; -- Then filter groups




-- UPPER: Convert to uppercase
SELECT UPPER(Name) AS UppercaseName FROM Employees;

-- LOWER: Convert to lowercase
SELECT LOWER(Department) AS LowercaseDept FROM Employees;

-- LENGTH (or LEN): Get length of string
SELECT Name, LENGTH(Name) AS NameLength FROM Employees;

-- SUBSTR (or SUBSTRING): Extract a part of a string
SELECT SUBSTR(Email, 1, INSTR(Email, '@') - 1) AS Username FROM Employees; -- Oracle/PostgreSQL INSTR
-- SQL Server: SELECT SUBSTRING(Email, 1, CHARINDEX('@', Email) - 1) AS Username FROM Employees;

-- CONCAT: Combine strings (syntax varies)
-- SQL Standard: SELECT CONCAT(FirstName, ' ', LastName) FROM Employees;
-- Or using || (PostgreSQL, Oracle): SELECT FirstName || ' ' || LastName FROM Employees;
-- ROUND: Round a number to a specified number of decimal places
SELECT ROUND(123.456, 2) AS RoundedNumber; -- Output: 123.46
-- TRUNC (or TRUNCATE): Truncate a number to a specified number of decimal places
SELECT TRUNC(123.456, 2) AS TruncatedNumber; -- Output: 123.45 (Oracle/PostgreSQL)
-- MySQL: SELECT TRUNCATE(123.456, 2);

-- ABS: Absolute value
SELECT ABS(-10) AS AbsoluteValue; -- Output: 10

-- CEIL (or CEILING): Round up to the nearest integer
SELECT CEIL(12.1) AS CeilValue; -- Output: 13

-- FLOOR: Round down to the nearest integer
SELECT FLOOR(12.9) AS FloorValue; -- Output: 12

-- MOD (or %): Modulo (remainder of a division)
SELECT MOD(10, 3) AS Remainder; -- Output: 1 (Oracle/PostgreSQL)
-- SQL Server, MySQL: SELECT 10 % 3;


-- TO_CHAR (Oracle/PostgreSQL): Convert number or date to string
SELECT TO_CHAR(12345, 'FM99,999') AS FormattedNumber; -- Output: "12,345"
SELECT TO_CHAR(CURRENT_DATE, 'YYYY-MM-DD') AS FormattedDate; -- Output: "2023-10-26" (example date)

-- TO_NUMBER (Oracle/PostgreSQL): Convert string to number
SELECT TO_NUMBER('123.45') + 10 AS ConvertedNumber; -- Output: 133.45

-- TO_DATE (Oracle/PostgreSQL): Convert string to date
SELECT TO_DATE('2023-10-26', 'YYYY-MM-DD') AS ConvertedDate;

-- CAST (SQL Standard - widely supported):
SELECT CAST('123' AS INT) + 10 AS ConvertedInt; -- Output: 133
SELECT CAST(456.78 AS DECIMAL(5,1)) AS ConvertedDecimal; -- Output: 456.8

-- CONVERT (SQL Server):
SELECT CONVERT(bigint, '123') + 10;
SELECT CONVERT(character , GETDATE(), 120); -- YYYY-MM-DD format


-- Common Date/Time Format Elements (examples, specific to Oracle/PostgreSQL TO_CHAR/TO_DATE):
-- YYYY: 4-digit year (e.g., 2023)
-- MM: 2-digit month (01-12)
-- DD: 2-digit day (01-31)
-- HH24: 2-digit hour (00-23)
-- MI: 2-digit minute (00-59)
-- SS: 2-digit second (00-59)
-- MON: Abbreviated month name (e.g., OCT)
-- MONTH: Full month name (e.g., OCTOBER)
-- DY: Abbreviated day of week (e.g., THU)
-- DAY: Full day of week (e.g., THURSDAY)

-- Example using CURRENT_DATE (PostgreSQL)
SELECT TO_CHAR(CURRENT_DATE, 'Day, Month DD, YYYY') AS FormattedDate;
-- Output: "Thursday, October 26, 2023" (example)

-- Example using TO_DATE (Oracle)
SELECT TO_DATE('26-OCT-2023 14:30:00', 'DD-MON-YYYY HH24:MI:SS') AS DateTimeValue;

-- CURRENT_DATE / GETDATE() / NOW(): Get current date/time
SELECT CURRENT_DATE; -- PostgreSQL, Oracle
-- SQL Server: SELECT GETDATE();
-- MySQL: SELECT NOW();

-- EXTRACT (PostgreSQL, Oracle): Extract part of a date/time
SELECT EXTRACT(YEAR FROM hire_date) AS HireYear FROM Employees;
SELECT EXTRACT(MONTH FROM hire_date) AS HireMonth FROM Employees;
SELECT EXTRACT(DAY FROM hire_date) AS HireDay FROM Employees;

-- DATEDIFF (SQL Server, MySQL): Calculate difference between dates
-- SQL Server: SELECT DATEDIFF(year, hire_date, GETDATE()) AS YearsSinceHire FROM Employees;
-- MySQL: SELECT DATEDIFF(NOW(), hire_date) AS DaysSinceHire FROM Employees;

-- DATE_ADD / DATE_SUB (MySQL): Add/subtract intervals
-- MySQL: SELECT DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY); -- Add 7 days
-- PostgreSQL: SELECT CURRENT_DATE + INTERVAL '7 days';
-- Oracle: SELECT SYSDATE + 7;

CREATE TABLE public.sales (
    sale_id      serial PRIMARY KEY,
    employee_id  integer NOT NULL,
    customer_id  integer NOT NULL,
    sales_date   date NOT NULL,
    amount       numeric(10,2) NOT NULL,
    commission   numeric(10,2) NOT NULL,
    product      varchar(100) NOT NULL,
    region       varchar(50),
    notes        text
);

INSERT INTO public.sales
(employee_id, customer_id, sales_date, amount, commission, product, region, notes)
VALUES
(9, 2, '2024-04-02', 1500.00, 150.00, 'Laptop', 'West', 'Repeat customer'),
(13, 5, '2024-04-15', 850.00, 85.00, 'Tablet', 'North', NULL),
(17, 13, '2024-05-01', 2500.00, 375.00, 'Enterprise License', 'East', 'Bulk order'),
(9, 11, '2024-05-09', 1200.00, 120.00, 'Laptop', 'West', ''),
(20, 18, '2024-05-18', 499.99, 50.00, 'Router', 'South', NULL),
(13, 3, '2024-05-20', 2200.00, 330.00, 'Workstation', 'North', ''),
(17, 15, '2024-05-25', 780.50, 78.05, 'Monitor', 'East', ''),
(20, 14, '2024-05-27', 1300.00, 130.00, 'Tablet', 'South', ''),
(9, 8, '2024-06-02', 900.00, 90.00, 'Phone', 'West', ''),
(13, 12, '2024-06-07', 1450.00, 217.50, 'Laptop', 'North', ''),
(17, 7, '2024-06-11', 3150.75, 472.61, 'Server', 'East', 'Priority delivery'),
(20, 17, '2024-06-16', 650.00, 65.00, 'Monitor', 'South', ''),
(9, 9, '2024-06-21', 1000.00, 100.00, 'Tablet', 'West', 'Customer demo'),
(13, 20, '2024-06-24', 1750.00, 175.00, 'Laptop', 'North', ''),
(17, 10, '2024-06-28', 2300.00, 230.00, 'Desktop', 'East', NULL),
(20, 6, '2024-07-01', 1200.25, 120.03, 'Phone', 'South', ''),
(9, 4, '2024-07-03', 900.00, 90.00, 'Monitor', 'West', ''),
(13, 16, '2024-07-10', 1999.99, 300.00, 'Workstation', 'North', ''),
(17, 1, '2024-07-13', 2750.00, 412.50, 'Enterprise License', 'East', ''),
(20, 19, '2024-07-16', 1050.00, 105.00, 'Router', 'South', NULL);


-- NVL (Oracle) / ISNULL (SQL Server) / COALESCE (SQL Standard):
-- Replace NULL values with a specified value
SELECT NVL(commission, 0) AS ActualCommission FROM Sales; -- Oracle
SELECT ISNULL(commission, 0) AS ActualCommission FROM Sales; -- SQL Server
SELECT COALESCE(commission, 0) AS ActualCommission FROM Sales; -- Standard SQL, widely supported

-- CASE Statement: Conditional logic
SELECT
    Name,
    Salary,
    CASE
        WHEN Salary >= 100000 THEN 'High Earner'
        WHEN Salary >= 50000 THEN 'Mid-Range'
        ELSE 'Junior'
    END AS SalaryBracket
FROM Employees;


-- Tip: Chain functions for complex transformations
SELECT UPPER(SUBSTR(ProductName, 1, 3)) AS AbbrName
FROM Products; -- Gets first 3 chars, then converts to uppercase

-- Trick: Use `NULLIF` to avoid division by zero
SELECT TotalSales / NULLIF(NumberOfOrders, 0) AS AvgSalePerOrder
FROM SalesData; -- If NumberOfOrders is 0, it becomes NULL, avoiding error

-- Tip: Understand the distinction between single-row functions and aggregate functions.
-- Single-row functions operate on each row independently.
-- Aggregate functions operate on a set of rows and return a single summary value.

-- Start a transaction (syntax varies, AUTOCOMMIT is often on by default)
-- SQL Server, PostgreSQL, Oracle:
BEGIN TRANSACTION; -- or START TRANSACTION (MySQL)

-- Perform multiple DML operations within the transaction
UPDATE Accounts SET Balance = Balance - 100 WHERE AccountID = 1;
UPDATE Accounts SET Balance = Balance + 100 WHERE AccountID = 2;

-- If both updates succeed, commit the transaction
COMMIT;

-- If an error occurs, rollback (undo) the transaction
-- ROLLBACK;
