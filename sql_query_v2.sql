SQL


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Price DECIMAL(10, 2)
);


CREATE TABLE Users (
    UserID INT PRIMARY KEY, -- Ensures unique and non-NULL UserID
    UserName VARCHAR(100)
);

DROP TABLE Orders
ALTER TABLE Orders ADD OrderDate1 DATE
    OrderID INT PRIMARY KEY,
    UserID INT,
    OrderDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) -- Ensures UserID exists in Users table
);

select * from public.products


CREATE INDEX idx_product_name ON Products (ProductName);
DROP INDEX idx_product_name;

CREATE SEQUENCE product_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE users_id_seq
INCREMENT BY 5
START WITH 100;

-- Get the next value from the sequence
SELECT nextval('users_id_seq');
SELECT nextval('users_id_seq');
-- Example of using a sequence in a table creation
CREATE TABLE users (
    id INTEGER PRIMARY KEY DEFAULT nextval('users_id_seq'),
    name VARCHAR(255)
);

SELECT mp.productname FROM products mp

/*______________________________________*/
--step 1
CREATE TABLE order_details(
    order_id SERIAL,
    item_id INT NOT NULL,
    product_id INT,
    product_name TEXT NOT NULL,
    price DEC(10, 2) NOT NULL,
    PRIMARY KEY(order_id, item_id)
);

--step 2
CREATE SEQUENCE order_item_id
START 10
INCREMENT 10
MINVALUE 10
OWNED BY order_details.item_id;

--step 3
INSERT INTO 
    order_details(order_id, item_id, product_name, price)
VALUES
    (100, nextval('order_item_id'), 'Laptop', 100),
    (100, nextval('order_item_id'), 'Mouse', 550),
    (100, nextval('order_item_id'), 'Keyboard', 250);
	
select * from order_details

CREATE TABLE employees_det (
    Employee_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(20),
    Manager_ID INT NULL,
    Salary INT
);

INSERT INTO employees_det (Employee_ID, Name, Department, Manager_ID, Salary)
VALUES
(1, 'Andy', 'Sales', 101, 20000),
(2, 'Biju', 'Sales', 101, 15000),
(3, 'Chinmayee', 'Sales', 102, 10000),
(4, 'Dhivya', 'HR', 201, 45000),
(5, 'Emliee', 'HR', NULL, 0);







CREATE TABLE employees_c (
    id INT,
    name VARCHAR(50),
    age INT,
    department VARCHAR(30),
    salary INT,
    bonus INT,
    manager_id INT
);

INSERT INTO employees_c VALUES
(1, 'Anna', 30, 'IT', 60000, 5000, 101),
(2, 'Harry', 30, 'Finance', 50000,4500, 103),
(3, 'Cloe', 35, 'HR', 55000, 4000, 102),
(4, 'David', 35, 'IT', 70000, 6000, 101),
(5, 'Eva', 25, 'Marketing', 45000, 3000, 104),
(6, 'Allen', 25, 'Marketing', 35000, 2000, 104),
(7, 'Harry', 30, 'Finance', 20000,1000, 103);

--Comparison Operators
-- 1. Equal to
SELECT * FROM employees WHERE department = 'IT';

-- 2. Not equal to (both versions)
SELECT * FROM employees WHERE age != 30;
SELECT * FROM employees WHERE age <> 30;

-- 3. Greater than
SELECT * FROM employees WHERE salary > 60000;

-- 4. Less than
SELECT * FROM employees WHERE age < 30;

-- 5. Greater than or equal to
SELECT * FROM employees WHERE age >= 35;

-- 6. Less than or equal to
SELECT * FROM employees WHERE salary <= 50000;

-- 7. BETWEEN (inclusive)
SELECT * FROM employees WHERE age BETWEEN 28 AND 35;

-- 8. LIKE
SELECT * FROM employees WHERE name LIKE 'A%';

-- 9. IN
SELECT * FROM employees WHERE department IN ('HR', 'IT');

-- 10. IS NULL
SELECT * FROM employees WHERE bonus IS NULL;


--Arithmetic Operators
-- 1. Addition: total compensation
SELECT name, salary + bonus AS total_compensation FROM employees WHERE bonus IS NOT NULL;

-- 2. Subtraction
SELECT name, salary - 10000 AS reduced_salary FROM employees;

-- 3. Multiplication
SELECT name, bonus * 2 AS double_bonus FROM employees WHERE bonus IS NOT NULL;

-- 4. Division
SELECT name, salary / 12 AS monthly_salary FROM employees;

-- 5. Modulo
SELECT name, age % 2 AS age_modulo_2 FROM employees;


-- Logical Operator

-- 1. AND
SELECT * FROM employees WHERE department = 'IT' AND salary > 60000;

-- 2. OR
SELECT * FROM employees WHERE department = 'Finance' OR age < 30;

-- 3. NOT
SELECT * FROM employees WHERE NOT department = 'IT';


--1. % as Modulo Operator (returns remainder)

-- Returns the remainder when 17 is divided by 5
SELECT 17 % 5 AS remainder;  -- Output: 2

--2. LIKE for pattern matching
-- Find all employees whose name starts with 'A'
SELECT * FROM employees
WHERE name LIKE 'A%';

-- Find all products with exactly 5 characters in name
SELECT * FROM products
WHERE name LIKE '_____';

-- Find all customers with names containing 'son'
SELECT * FROM customers
WHERE name LIKE '%son%';


--3. IS NULL to check missing/unknown values
-- Find all orders where shipping_date is not set
SELECT * FROM orders
WHERE shipping_date IS NULL;


--4. IN to check against a list of values
-- Find all employees who are in departments 1, 3, or 5
SELECT * FROM employees
WHERE department_id IN (1, 3, 5);

--5. BETWEEN is inclusive of both boundary values
-- Select products priced between 100 and 200 inclusive
SELECT * FROM products
WHERE price BETWEEN 100 AND 200;

-- Find orders placed between '2023-01-01' and '2023-12-31'
SELECT * FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31';




--ORDER BY
-- Order by name alphabetically: 
SELECT Name, Department FROM Employees ORDER BY Name ASC;
--Order by salary, highest first: 
SELECT Name, Salary FROM Employees ORDER BY Salary DESC;`
-- Order by department (ASC) then by salary (DESC): 
SELECT Name, Department, Salary FROM Employees ORDER BY Department ASC, Salary DESC;

--Count

SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department;

--. SUM() – Total salary per department
--Count
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

--3. AVG() – Average bonus per department
SELECT department, AVG(bonus) AS average_bonus
FROM employees
GROUP BY department;


--. MIN() – Minimum salary per department
SELECT department, MIN(salary) AS min_salary
FROM employees
GROUP BY department;

--MAX() – Maximum salary per department
SELECT department, MAX(salary) AS max_salary
FROM employees
GROUP BY department;

-- Combine multiple aggregate functions
SELECT department,
       COUNT(*) AS total_employees,
       SUM(salary) AS total_salary,
       AVG(salary) AS avg_salary,
       MIN(salary) AS min_salary,
       MAX(salary) AS max_salary
FROM employees
GROUP BY department;


--1. Using WHERE to filter rows before GROUP BY
-- Only include employees with salary above 50000
SELECT department, COUNT(*) AS employee_count
FROM employees
WHERE salary > 50000
GROUP BY department;

-- 2. Using HAVING to filter groups after aggregation
-- Only include departments where total salary exceeds 110000
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 110000;

--COUNT() with HAVING
-- Departments with more than 1 employee
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;


--SUM() with HAVING
-- Departments with total bonus more than 8000
SELECT department, SUM(bonus) AS total_bonus
FROM employees
GROUP BY department
HAVING SUM(bonus) > 8000;



--AVG() with HAVING
-- Departments where average salary is over 55000
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 55000;


-- MIN() with HAVING
-- Departments where the minimum salary is at least 50000
SELECT department, MIN(salary) AS min_salary
FROM employees
GROUP BY department
HAVING MIN(salary) >= 50000;
--MAX() with HAVING
-- Departments where the maximum salary is over 60000
SELECT department, MAX(salary) AS max_salary
FROM employees
GROUP BY department
HAVING MAX(salary) > 60000;
-- Bonus: Combine WHERE and HAVING

-- Employees older than 25, grouped by department, where total salary > 100000
SELECT department, SUM(salary) AS total_salary
FROM employees
WHERE age > 25
GROUP BY department
HAVING SUM(salary) > 100000;
Would you like the following?



--Solution: 
SELECT department, COUNT(*) AS NumberOfEmployees
FROM Employees GROUP BY department HAVING COUNT(*) > 5;


--Roll up
CREATE TABLE sales (
    region VARCHAR(20),
    department VARCHAR(20),
    revenue INT
);

INSERT INTO sales VALUES
('North', 'IT', 10000),
('North', 'HR', 7000),
('South', 'IT', 12000),
('South', 'HR', 6000),
('South', 'Marketing', 8000);

--Roll up
SELECT 
    region,
    department,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY ROLLUP(region, department);





--3. ROLLUP with three levels: Region → Department → NULL
SELECT 
    region,
    department,
    COUNT(*) AS count,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY ROLLUP(region, department);

SELECT department, manager_id, SUM(Salary) AS TotalSalary FROM Employees_det GROUP BY ROLLUP(department, manager_id);
select * from Employees_det
select * from Employees
SELECT 
    Department  ,
   Manager_ID,
    SUM(Salary) AS TotalSalary
FROM employees
GROUP BY ROLLUP (Department,Manager_ID); --, Manager_ID

select * from Employees 
select sum(salary) from Employees -- 280000
--Marketing 45000 --Finance 50000 / 80000 --HR 55000 / 95000

INSERT INTO employees VALUES
--(1, 'John', 30, 'IT', 60000, 5000, 101),
(6, 'John', 28, 'Finance', 30000, NULL, NULL),
(7, 'Ben', 35, 'HR', 40000, 4000, 102)
--(4, 'David', 40, 'IT', 70000, 6000, 101),
--(5, 'Eva', 25, 'Marketing', 45000, 3000, NULL);

select * from Employees
update Employees set age=30 where id=4

SELECT 
department, 
manager_id, 
age,
SUM(Salary) AS TotalSalary 
FROM Employees_c 
GROUP BY CUBE(department, manager_id,age) ;
--ORDER BY department 
select * from Employees_c order by department

--drop table Employees_c

SELECT UPPER('hello')-- Convert to uppercase.
select LOWER('HellO') -- Convert to lowercase.
LENGTH() (or `LEN()`)--: Get length of string.
--SUBSTR() (or `SUBSTRING()--`): Extract a part of a string.
--CONCAT()`: Combine strings (syntax varies, e.g., `||`).

