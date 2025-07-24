CREATE TABLE public.sales_1 (
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


INSERT INTO public.sales_1 (employee_id, customer_id, sales_date, amount, commission, product, region, notes) 
VALUES
(121, 221, '2025-03-05', 1800.00, NULL, 'Gaming Laptop', 'West', 'Priority customer');

(101, 201, '2025-01-05', 1200.50, 120.05, 'Laptop Model X', 'North', 'First sale of the year'),
(102, 202, '2025-01-10', 850.00, 85.00, 'Smartphone A1', 'South', 'Repeat customer'),
(103, 203, '2025-01-15', 400.75, 40.08, 'Wireless Headphones', 'East', NULL),
(104, 204, '2025-01-20', 2300.00, 230.00, '4K TV 55 inch', 'West', 'Special discount applied'),
(105, 205, '2025-01-22', 1500.00, 150.00, 'Gaming Console', 'North', 'Sold with extended warranty'),
(106, 206, '2025-01-25', 300.50, 30.05, 'Bluetooth Speaker', 'South', NULL),
(107, 207, '2025-01-28', 1250.00, 125.00, 'Smartwatch Series 5', 'East', NULL),
(108, 208, '2025-02-01', 600.00, 60.00, 'Tablet Z', 'West', 'Customer upgraded from previous model'),
(109, 209, '2025-02-03', 950.00, 95.00, 'DSLR Camera', 'North', NULL),
(110, 210, '2025-02-07', 780.00, 78.00, 'Home Security System', 'South', NULL),
(111, 211, '2025-02-10', 430.00, 43.00, 'E-Reader', 'East', 'Online order'),
(112, 212, '2025-02-12', 1120.00, 112.00, 'Laptop Model Y', 'West', NULL),
(113, 213, '2025-02-15', 670.50, 67.05, 'Smartphone B2', 'North', 'New customer'),
(114, 214, '2025-02-18', 880.00, 88.00, 'Smart TV 50 inch', 'South', 'Promotion sale'),
(115, 215, '2025-02-20', 540.00, 54.00, 'Wireless Mouse', 'East', NULL),
(116, 216, '2025-02-22', 720.00, 72.00, 'External Hard Drive', 'West', 'Bulk purchase'),
(117, 217, '2025-02-25', 1300.00, 130.00, 'Laptop Model Z', 'North', 'Business client'),
(118, 218, '2025-02-28', 210.00, 21.00, 'USB-C Hub', 'South', NULL),
(119, 219, '2025-03-02', 350.00, 35.00, 'Noise Cancelling Headphones', 'East', NULL),
(120, 220, '2025-03-05', 1800.00, 180.00, 'Gaming Laptop', 'West', 'Priority customer');











SELECT 
COALESCE(notes, 'This is null') AS ActualCommission 
FROM Sales_1; 

SELECT Name, Salary, 
CASE 
	WHEN Salary >= 100000 THEN 'High Earner' 
	WHEN Salary >= 50000 THEN 'Mid- Range' 
ELSE 'Junior' END AS SalaryBracket 
FROM Employees;



-- Start a transaction
BEGIN;

	-- Example operation: Insert a new sale record
	INSERT INTO public.sales_1 (employee_id, customer_id, sales_date, amount, commission, product, region, notes)
	VALUES (123, 223, '2025-03-10', 1450.00, 145.00, 'Smartwatch Series 6', 'North', 'Demo insert for transaction');
	
	-- Check the result before committing/rolling back
	SELECT * FROM public.sales_1 WHERE employee_id = 123;
	--DELETE FROM public.sales_1 WHERE employee_id = 123;

-- If everything is correct, commit the changes:
COMMIT;
-- The new record is now permanently saved to the database[3][1][8].

-- Or, if something is wrong, roll back the changes:
ROLLBACK;
-- The new record is undone, as if the insert never happened[1][3][9].


--select * from public.sales_1
BEGIN;

-- First insert: this will remain even if we roll back to the later savepoint
INSERT INTO public.sales_1 (employee_id, customer_id, sales_date, amount, commission, product, region, notes)
VALUES (125, 225, '2025-03-12', 1600.00, 160.00, 'Tablet Pro', 'East', 'Initial sale in transaction');

-- Create a SAVEPOINT
SAVEPOINT after_first_insert;

-- Second insert: this one may be undone
INSERT INTO public.sales_1 (employee_id, customer_id, sales_date, amount, commission, product, region, notes)
VALUES (126, 226, '2025-03-13', 500.00, 50.00, 'Bluetooth Speaker', 'West', 'Will roll back this insert');

-- Oops! Suppose we made a mistake, so we want to undo the second insert:
ROLLBACK TO SAVEPOINT after_first_insert;

-- The second insert is now undone, but the first remains.

-- Third insert: this one will now be included
INSERT INTO public.sales_1 (employee_id, customer_id, sales_date, amount, commission, product, region, notes)
VALUES (127, 227, '2025-03-14', 950.00, 95.00, 'DSLR Camera', 'North', 'This record stays');

-- Finish the transaction—now only the first and third inserts are saved
COMMIT;

