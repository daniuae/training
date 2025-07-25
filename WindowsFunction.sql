/*
| Task                      | Use Function       |
| ------------------------- | ------------------ |
| Row index per group       | `ROW_NUMBER()`     |
| Rank with tie gaps        | `RANK()`           |
| Rank without tie gaps     | `DENSE_RANK()`     |
| Bucket/group distribution | `NTILE()`          |
| Compare previous/next row | `LAG()`, `LEAD()`  |
| First/last in partition   | `FIRST_VALUE()`    |
| Cumulative sums/averages  | `SUM() OVER (...)` |

*/
CREATE TABLE sales1 (
    id SERIAL PRIMARY KEY,
    employee TEXT,
    department TEXT,
    sale_amount INT,
    sale_date DATE
);

INSERT INTO sales1 (employee, department, sale_amount, sale_date) VALUES 
('Sean', 'Electronics', 300, '2023-01-01'),
('Anna', 'Electronics', 500, '2023-01-03'),
('Lubo', 'Electronics', 400, '2023-01-05'),
('David', 'Furniture', 700, '2023-01-02'),
('Eve', 'Furniture', 600, '2023-01-06'),
('Frank', 'Furniture', 750, '2023-01-07'),
('Grace', 'Clothing', 200, '2023-01-04'),
('Heidi', 'Clothing', 350, '2023-01-08'),
('Ivan', 'Clothing', 150, '2023-01-09'),
('Judy', 'Electronics', 550, '2023-01-10'),
('Karl', 'Furniture', 800, '2023-01-11'),
('Leo', 'Furniture', 720, '2023-01-12'),
('Mallory', 'Clothing', 280, '2023-01-13'),
('Nina', 'Clothing', 310, '2023-01-14'),
('Oscar', 'Electronics', 250, '2023-01-15'),
('Peggy', 'Furniture', 710, '2023-01-16'),
('Quinn', 'Furniture', 705, '2023-01-17'),
('Ruth', 'Clothing', 360, '2023-01-18'),
('Sam', 'Electronics', 460, '2023-01-19'),
('Trudy', 'Clothing', 400, '2023-01-20');

select * from sales;

SELECT employee, department, sale_amount,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY sale_amount DESC) AS row_num
FROM sales1;


SELECT employee, department, sale_amount,
		ROW_NUMBER() OVER (PARTITION BY department ORDER BY sale_amount DESC) AS row_num,
       RANK() OVER (PARTITION BY department ORDER BY sale_amount DESC) AS rank,
       DENSE_RANK() OVER (PARTITION BY department ORDER BY sale_amount DESC) AS dense_rank
FROM sales1;


SELECT employee, sale_amount,
       NTILE(3) OVER (ORDER BY sale_amount) AS quartile
FROM sales1;


SELECT employee, sale_amount,
       LAG(sale_amount) OVER (ORDER BY sale_date) AS prev_sale,
       LEAD(sale_amount) OVER (ORDER BY sale_date) AS next_sale
FROM sales1;


SELECT employee, department, sale_amount,
       FIRST_VALUE(sale_amount) OVER (PARTITION BY department ORDER BY sale_date) AS first_sale,
       LAST_VALUE(sale_amount) OVER (PARTITION BY department ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_sale
FROM sales1;


SELECT employee, sale_date, sale_amount,
       SUM(sale_amount) OVER (PARTITION BY employee ORDER BY sale_date) AS running_total
FROM sales1;

--Stock Table 

CREATE TABLE stock_price (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    price NUMERIC(10, 2) NOT NULL
);

INSERT INTO stock_price (date, price) VALUES
('2025-07-20', 100.50),
('2025-07-21', 101.75),
('2025-07-22', 102.20),
('2025-07-23', 99.80),
('2025-07-24', 101.00);
select * from stock_price order By date
 
SELECT 
    date, 
    price,
    LAG(price) OVER (ORDER BY date) AS one_day_before,
    price - LAG(price) OVER (ORDER BY date) AS daily_change
FROM stock_price;

SELECT 
    date, 
    price,
    LEAD(price) OVER (ORDER BY price) AS next_price,
    LEAD(price) OVER (ORDER BY price) - price AS price_difference
FROM stock_price;



