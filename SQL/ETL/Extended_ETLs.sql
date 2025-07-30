/*More ETL process*/

Where  COALESCE(soh.customerid, -1) AS customerid,       
WITH cleaned_sales AS (
  SELECT DISTINCT
    soh.salesorderid,
    COALESCE(soh.orderdate, CURRENT_DATE) AS orderdate,                      -- Filling missing order dates
    COALESCE(soh.customerid, -1) AS customerid,                              -- Impute missing customer IDs as -1
    sod.productid,
    CASE 
        WHEN sod.orderqty <= 0 THEN 1                                        -- Correcting invalid order quantities
        ELSE sod.orderqty
    END AS orderqty,
    CASE 
        WHEN sod.unitprice < 0 THEN 0                                        -- Correcting negative prices
        ELSE sod.unitprice
    END AS unitprice
  FROM sales.salesorderheader soh
  JOIN sales.salesorderdetail sod 
    ON soh.salesorderid = sod.salesorderid
),
final_sales AS (
  SELECT *,
    unitprice * orderqty AS total_price
  FROM cleaned_sales
)
SELECT * FROM final_sales
ORDER BY salesorderid;


SELECT *
FROM sales.salesorderheader
WHERE orderdate IS NULL OR customerid IS NULL;

SELECT *
FROM sales.salesorderdetail
WHERE unitprice < 0;
orderqty <= 0 OR  unitprice < 0;

