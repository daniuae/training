-- =======================
-- 1. Drop existing tables if any (for demo only)
-- =======================
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS inventory CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

-- =======================
-- 2. Create departments table
-- =======================
CREATE TABLE departments (
  dept_id    SERIAL PRIMARY KEY,
  dept_name  VARCHAR(50) NOT NULL
);

-- =======================
-- 3. Create employees table
-- =======================
CREATE TABLE employees (
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(100) NOT NULL,
  age         INT NOT NULL,
  department  VARCHAR(50) NOT NULL,
  phone_number VARCHAR(20),
  hire_date   DATE,
  manager_id  INT REFERENCES employees(id) ON DELETE SET NULL,
  salary      NUMERIC(10,2),
  dept_id     INT REFERENCES departments(dept_id) ON DELETE SET NULL
);

-- =======================
-- 4. Create customers table
-- =======================
CREATE TABLE customers (
  customerid  SERIAL PRIMARY KEY,
  firstname   VARCHAR(50) NOT NULL,
  lastname    VARCHAR(50) NOT NULL,
  email       VARCHAR(100) NOT NULL UNIQUE
);

-- =======================
-- 5. Create products table
-- =======================
CREATE TABLE products (
  product_id   SERIAL PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  description  TEXT,
  price        NUMERIC(10,2) NOT NULL,
  created_at   DATE NOT NULL
);

-- =======================
-- 6. Create inventory table
-- =======================
CREATE TABLE inventory (
  inventory_id SERIAL PRIMARY KEY,
  product_id   INT NOT NULL REFERENCES products(product_id) ON DELETE CASCADE,
  quantity     INT NOT NULL,
  last_updated DATE NOT NULL
);

-- =======================
-- 7. Create orders table
-- =======================
CREATE TABLE orders (
  order_id     SERIAL PRIMARY KEY,
  customer_id  INT NOT NULL REFERENCES customers(customerid) ON DELETE CASCADE,
  employee_id  INT NOT NULL REFERENCES employees(id) ON DELETE SET NULL,
  order_date   DATE NOT NULL,
  status       VARCHAR(20) NOT NULL
);

-- =======================
-- 8. Create order_items table
-- =======================
CREATE TABLE order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id     INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
  product_id   INT NOT NULL REFERENCES products(product_id) ON DELETE CASCADE,
  quantity     INT NOT NULL,
  price        NUMERIC(10,2) NOT NULL -- price at order time
);

-- =======================
-- 9. Create sales table
-- =======================
CREATE TABLE sales (
  sale_id      SERIAL PRIMARY KEY,
  employee_id  INT NOT NULL REFERENCES employees(id) ON DELETE SET NULL,
  customer_id  INT NOT NULL REFERENCES customers(customerid) ON DELETE SET NULL,
  sales_date   DATE NOT NULL,
  amount       NUMERIC(10,2) NOT NULL,
  commission   NUMERIC(10,2) NOT NULL,
  product_id   INT NOT NULL REFERENCES products(product_id) ON DELETE SET NULL,
  region       VARCHAR(50),
  notes        TEXT
);

-- =======================
-- 10. Insert Departments
-- =======================
INSERT INTO departments (dept_name) VALUES
('HR'), ('Finance'), ('Engineering'), ('Marketing'), ('Sales');

-- =======================
-- 11. Insert Employees
-- =======================
INSERT INTO employees (name, age, department, phone_number, hire_date, manager_id, salary, dept_id) VALUES
('Alice Johnson', 29, 'HR', '555-1234', '2018-03-15', NULL, 60000, 1),
('Brian Smith', 35, 'Finance', '555-5678', '2016-07-20', NULL, 75000, 2),
('Catherine Lee', 31, 'Engineering', '555-9101', '2019-01-08', 7, 95000, 3),
('David Kim', 28, 'Engineering', '555-1122', '2020-02-17', 3, 70000, 3),
('Emma Williams', 42, 'Marketing', '555-3344', '2012-11-30', NULL, 80000, 4),
('Frank Miller', 38, 'Finance', '555-5566', '2015-06-11', 2, 82000, 2),
('Grace Chen', 39, 'Engineering', '555-7788', '2010-09-19', NULL, 110000, 3),
('Harry Davis', 27, 'HR', '555-9900', '2021-04-01', 1, 52000, 1),
('Irene Moore', 33, 'Sales', '555-2233', '2017-12-05', 17, 67000, 5),
('Jack Wilson', 36, 'Engineering', '555-4455', '2014-05-23', 3, 90000, 3),
('Karen Brown', 30, 'Marketing', '555-6677', '2019-08-10', 5, 63000, 4),
('Luke Anderson', 48, 'HR', '555-8899', '2008-01-20', NULL, 105000, 1),
('Maria Garcia', 26, 'Sales', '555-1212', '2022-07-13', 9, 54000, 5),
('Nathan Scott', 34, 'Finance', '555-2323', '2015-04-15', 6, 78000, 2),
('Olivia Martinez', 44, 'Finance', '555-3434', '2011-11-02', NULL, 120000, 2),
('Paul Robinson', 41, 'Marketing', '555-4545', '2013-03-19', NULL, 98000, 4),
('Quinn Turner', 38, 'Sales', '555-5656', '2016-09-07', NULL, 91000, 5),
('Rachel Evans', 29, 'HR', '555-6767', '2018-06-15', 1, 60000, 1),
('Samuel White', 25, 'Engineering', '555-7878', '2023-01-09', 4, 58000, 3),
('Teresa Harris', 32, 'Sales', '555-8989', '2017-03-06', 17, 66000, 5);

-- =======================
-- 12. Insert Customers
-- =======================
INSERT INTO customers (firstname, lastname, email) VALUES
('John', 'Doe', 'john.doe@email.com'),
('Jane', 'Smith', 'jane.smith@email.com'),
('Michael', 'Johnson', 'michael.j@email.com'),
('Emily', 'Brown', 'emily.brown@email.com'),
('David', 'Williams', 'david.w@email.com'),
('Sarah', 'Miller', 'sarah.m@email.com'),
('Chris', 'Davis', 'chris.d@email.com'),
('Jessica', 'Garcia', 'jess.garcia@email.com'),
('Matthew', 'Martinez', 'matthew.m@email.com'),
('Ashley', 'Rodriguez', 'ashley.r@email.com'),
('Brian', 'Hernandez', 'brian.h@email.com'),
('Amanda', 'Lopez', 'amanda.l@email.com'),
('Kevin', 'Gonzalez', 'kevin.g@email.com'),
('Melissa', 'Clark', 'melissa.c@email.com'),
('Joshua', 'Lewis', 'joshua.l@email.com'),
('Rachel', 'Walker', 'rachel.w@email.com'),
('Justin', 'Young', 'justin.y@email.com'),
('Lauren', 'Hall', 'lauren.h@email.com'),
('Daniel', 'Allen', 'daniel.a@email.com'),
('Nicole', 'King', 'nicole.k@email.com');

-- =======================
-- 13. Insert Products
-- =======================
INSERT INTO products (product_name, description, price, created_at) VALUES
('Laptop', '15.6" laptop, 16GB RAM, 512GB SSD', 1500.00, '2024-04-01'),
('Tablet', '10" tablet, 64GB storage', 850.00, '2024-04-01'),
('Enterprise License', 'Corporate software license', 2500.00, '2024-04-10'),
('Workstation', 'High-performance desktop', 2200.00, '2024-05-05'),
('Monitor', '27" 4K monitor', 780.50, '2024-05-10'),
('Router', 'WiFi 6 router', 499.99, '2024-05-15'),
('Phone', '5G smartphone, 128GB', 900.00, '2024-06-01'),
('Server', '1U rack server, dual CPU', 3150.75, '2024-06-10'),
('Desktop', 'Standard office desktop', 2300.00, '2024-06-15');

-- =======================
-- 14. Insert Inventory for Products
-- =======================
INSERT INTO inventory (product_id, quantity, last_updated) VALUES
(1, 35, '2024-07-01'),
(2, 58, '2024-07-01'),
(3, 10, '2024-07-01'),
(4, 14, '2024-07-01'),
(5, 28, '2024-07-01'),
(6, 26, '2024-07-01'),
(7, 40, '2024-07-01'),
(8, 8,  '2024-07-01'),
(9, 18, '2024-07-01');

-- =======================
-- 15. Insert Orders
-- =======================
INSERT INTO orders (customer_id, employee_id, order_date, status) VALUES
(2, 9, '2024-04-02', 'Completed'),
(5, 13, '2024-04-15', 'Completed'),
(13, 17, '2024-05-01', 'Completed'),
(11, 9, '2024-05-09', 'Completed'),
(18, 20, '2024-05-18', 'Pending'),
(3, 13, '2024-05-20', 'Completed'),
(15, 17, '2024-05-25', 'Completed'),
(14, 20, '2024-05-27', 'Completed'),
(8, 9, '2024-06-02', 'Returned'),
(12, 13, '2024-06-07', 'Completed'),
(7, 17, '2024-06-11', 'Completed'),
(17, 20, '2024-06-16', 'Pending'),
(9, 9, '2024-06-21', 'Completed'),
(20, 13, '2024-06-24', 'Completed'),
(10, 17, '2024-06-28', 'Completed'),
(6, 20, '2024-07-01', 'Pending'),
(4, 9, '2024-07-03', 'Completed'),
(16, 13, '2024-07-10', 'Completed'),
(1, 17, '2024-07-13', 'Completed'),
(19, 20, '2024-07-16', 'Pending');

-- =======================
-- 16. Insert Order Items
-- =======================
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1500.00),
(2, 2, 2, 1700.00),
(3, 3, 1, 2500.00),
(4, 1, 1, 1500.00),
(5, 6, 1, 499.99),
(6, 4, 1, 2200.00),
(7, 5, 1, 780.50),
(8, 2, 1, 850.00),
(9, 7, 1, 900.00),
(10, 1, 1, 1500.00),
(11, 8, 2, 6301.50),
(12, 5, 1, 780.50),
(13, 2, 2, 1700.00),
(14, 1, 1, 1500.00),
(15, 9, 1, 2300.00),
(16, 7, 2, 1800.00),
(17, 5, 1, 780.50),
(18, 4, 1, 2200.00),
(19, 3, 2, 5000.00),
(20, 6, 1, 499.99);

-- =======================
-- 17. Insert Sales
-- =======================
INSERT INTO sales (employee_id, customer_id, sales_date, amount, commission, product_id, region, notes) VALUES
(9, 2, '2024-04-02', 1500.00, 150.00, 1, 'West', 'Repeat customer'),
(13, 5, '2024-04-15', 850.00, 85.00, 2, 'North', NULL),
(17, 13, '2024-05-01', 2500.00, 375.00, 3, 'East', 'Bulk order'),
(9, 11, '2024-05-09', 1200.00, 120.00, 1, 'West', ''),
(20, 18, '2024-05-18', 499.99, 50.00, 6, 'South', NULL),
(13, 3, '2024-05-20', 2200.00, 330.00, 4, 'North', ''),
(17, 15, '2024-05-25', 780.50, 78.05, 5, 'East', ''),
(20, 14, '2024-05-27', 1300.00, 130.00, 2, 'South', ''),
(9, 8, '2024-06-02', 900.00, 90.00, 7, 'West', ''),
(13, 12, '2024-06-07', 1450.00, 217.50, 1, 'North', ''),
(17, 7, '2024-06-11', 3150.75, 472.61, 8, 'East', 'Priority delivery'),
(20, 17, '2024-06-16', 650.00, 65.00, 5, 'South', ''),
(9, 9, '2024-06-21', 1000.00, 100.00, 2, 'West', 'Customer demo'),
(13, 20, '2024-06-24', 1750.00, 175.00, 1, 'North', ''),
(17, 10, '2024-06-28', 2300.00, 230.00, 9, 'East', NULL),
(20, 6, '2024-07-01', 1200.25, 120.03, 7, 'South', ''),
(9, 4, '2024-07-03', 900.00, 90.00, 5, 'West', ''),
(13, 16, '2024-07-10', 1999.99, 300.00, 4, 'North', ''),
(17, 1, '2024-07-13', 2750.00, 412.50, 3, 'East', ''),
(20, 19, '2024-07-16', 1050.00, 105.00, 6, 'South', NULL);

-- =======================
-- All done!
-- =======================

-- You can now query any table and see the relationships, constraints, and sample data.

CREATE TABLE suppliers (
  supplier_id   SERIAL PRIMARY KEY,
  supplier_name VARCHAR(100) NOT NULL,
  contact_name  VARCHAR(100),
  contact_email VARCHAR(100) NOT NULL,
  phone         VARCHAR(30),
  address       TEXT
);

CREATE TABLE purchase_orders (
  po_id          SERIAL PRIMARY KEY,
  supplier_id    INT NOT NULL REFERENCES suppliers(supplier_id),
  employee_id    INT REFERENCES employees(id),
  po_date        DATE NOT NULL,
  status         VARCHAR(20) DEFAULT 'Pending'
);

CREATE TABLE suppliers (
  supplier_id   SERIAL PRIMARY KEY,
  supplier_name VARCHAR(100) NOT NULL,
  contact_name  VARCHAR(100),
  contact_email VARCHAR(100) NOT NULL,
  phone         VARCHAR(30),
  address       TEXT
);

CREATE TABLE purchase_orders (
  po_id          SERIAL PRIMARY KEY,
  supplier_id    INT NOT NULL REFERENCES suppliers(supplier_id),
  employee_id    INT REFERENCES employees(id),
  po_date        DATE NOT NULL,
  status         VARCHAR(20) DEFAULT 'Pending'
);

CREATE TABLE products (
  product_id     SERIAL PRIMARY KEY,
  product_name   VARCHAR(100) NOT NULL,
  description    TEXT,
  price          NUMERIC(10,2) NOT NULL,
  created_at     DATE NOT NULL,
  supplier_id    INT REFERENCES suppliers(supplier_id)
);
 

CREATE TABLE purchase_order_items (
  po_item_id     SERIAL PRIMARY KEY,
  po_id          INT NOT NULL REFERENCES purchase_orders(po_id) ON DELETE CASCADE,
  product_id     INT NOT NULL REFERENCES products(product_id),
  ordered_qty    INT NOT NULL,
  received_qty   INT DEFAULT 0,
  price_per_unit NUMERIC(10,2) NOT NULL
);

 
CREATE TABLE suppliers (
  supplier_id   SERIAL PRIMARY KEY,
  supplier_name VARCHAR(100) NOT NULL,
  contact_name  VARCHAR(100),
  contact_email VARCHAR(100) NOT NULL,
  phone         VARCHAR(30),
  address       TEXT
); 

CREATE TABLE purchase_orders (
  po_id          SERIAL PRIMARY KEY,
  supplier_id    INT NOT NULL REFERENCES suppliers(supplier_id),
  employee_id    INT REFERENCES employees(id),
  po_date        DATE NOT NULL,
  status         VARCHAR(20) DEFAULT 'Pending'
);

CREATE TABLE products (
  product_id     SERIAL PRIMARY KEY,
  product_name   VARCHAR(100) NOT NULL,
  description    TEXT,
  price          NUMERIC(10,2) NOT NULL,
  created_at     DATE NOT NULL,
  supplier_id    INT REFERENCES suppliers(supplier_id)
);

CREATE TABLE purchase_order_items (
  po_item_id     SERIAL PRIMARY KEY,
  po_id          INT NOT NULL REFERENCES purchase_orders(po_id) ON DELETE CASCADE,
  product_id     INT NOT NULL REFERENCES products(product_id),
  ordered_qty    INT NOT NULL,
  received_qty   INT DEFAULT 0,
  price_per_unit NUMERIC(10,2) NOT NULL
);


CREATE TABLE inventory (
  inventory_id  SERIAL PRIMARY KEY,
  product_id    INT NOT NULL REFERENCES products(product_id) ON DELETE CASCADE,
  quantity      INT NOT NULL,
  last_updated  DATE NOT NULL
);

CREATE TABLE orders (
  order_id      SERIAL PRIMARY KEY,
  customer_id   INT NOT NULL REFERENCES customers(customerid) ON DELETE CASCADE,
  employee_id   INT NOT NULL REFERENCES employees(id) ON DELETE SET NULL,
  order_date    DATE NOT NULL,
  status        VARCHAR(20) NOT NULL
);

CREATE TABLE order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id      INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
  product_id    INT NOT NULL REFERENCES products(product_id),
  quantity      INT NOT NULL,
  price         NUMERIC(10,2) NOT NULL
);

CREATE TABLE sales (
  sale_id      SERIAL PRIMARY KEY,
  employee_id  INT NOT NULL REFERENCES employees(id) ON DELETE SET NULL,
  customer_id  INT NOT NULL REFERENCES customers(customerid) ON DELETE SET NULL,
  sales_date   DATE NOT NULL,
  amount       NUMERIC(10,2) NOT NULL,
  commission   NUMERIC(10,2) NOT NULL,
  product_id   INT NOT NULL REFERENCES products(product_id) ON DELETE SET NULL,
  region       VARCHAR(50),
  notes        TEXT
);

INSERT INTO suppliers (supplier_name, contact_name, contact_email, phone, address) VALUES
('Acme Components', 'Lucy Ford', 'lucy@acmecomponents.com', '123-555-0000', '123 Main St, Tech City'),
('Beta Supplies', 'Tom Beta', 'tom.beta@betasupplies.com', '888-123-0000', '456 Beta Rd, Plastica'),
('Global Devices', 'Anna Global', 'anna@globaldevices.com', '999-333-0000', '789 Global Ave, Hardwaretown');

-- Example: Add supplier_id to products
-- Insert some sample products with supplier_link
INSERT INTO products (product_name, description, price, created_at, supplier_id) VALUES
('Laptop', '15.6" laptop, 16GB RAM, 512GB SSD', 1500.00, '2024-04-01', 1),
('Tablet', '10" tablet, 64GB storage', 850.00, '2024-04-01', 1),
('Enterprise License', 'Corporate software license', 2500.00, '2024-04-10', 3),
('Workstation', 'High-performance desktop', 2200.00, '2024-05-05', 2),
('Monitor', '27" 4K monitor', 780.50, '2024-05-10', 2);

-- Sample Purchase Orders
INSERT INTO purchase_orders (supplier_id, employee_id, po_date, status) VALUES
(1, 1, '2024-03-01', 'Completed'),
(2, 3, '2024-05-01', 'Pending');

INSERT INTO purchase_order_items (po_id, product_id, ordered_qty, received_qty, price_per_unit) VALUES
(1, 1, 10, 10, 1200.00),
(1, 2, 15, 15, 700.00),
(2, 4, 5, 0, 1800.00);

INSERT INTO public.products (product_id, product_name, description, price, created_at) VALUES
(1, 'Laptop', '15.6\" laptop, 16GB RAM, 512GB SSD', 1500.00, '2024-04-01'),
(2, 'Tablet', '10\" tablet, 64GB storage', 850.00, '2024-04-01'),
(3, 'Enterprise License', 'Corporate software license', 2500.00, '2024-04-10'),
(4, 'Workstation', 'High-performance desktop', 2200.00, '2024-05-05'),
(5, 'Monitor', '27\" 4K monitor', 780.50, '2024-05-10'),
(6, 'Router', 'WiFi 6 router', 499.99, '2024-05-15'),
(7, 'Phone', '5G smartphone, 128GB', 900.00, '2024-06-01'),
(8, 'Server', '1U rack server, dual CPU', 3150.75, '2024-06-10'),
(9, 'Desktop', 'Standard office desktop', 2300.00, '2024-06-15'),
(10, 'Printer', 'Wireless office printer', 350.00, '2024-07-01');

SELECT customerid, firstname, lastname, email
	FROM public.customers;

	