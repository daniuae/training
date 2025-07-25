--CTE
CREATE TABLE sales_cte (
  id SERIAL PRIMARY KEY,
  region VARCHAR(50),
  sales INT,
  sale_date DATE
);

INSERT INTO sales_cte (region, sales, sale_date) VALUES
('East', 100, '2024-01-01'),
('East', 200, '2024-01-02'),
('West', 150, '2024-01-01'),
('West', 300, '2024-01-02'),
('North', 120, '2024-01-03'),
('South', 180, '2024-01-04');


WITH region_sales AS (
  SELECT
    region,
    SUM(sales) AS total_sales
  FROM sales_cte
  GROUP BY region
)
SELECT * FROM region_sales;
