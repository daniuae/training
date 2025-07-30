--Step 1
/*Create function to calculate the discount
DISCOUNT CALCULATION
*/
CREATE OR REPLACE FUNCTION calculate_discount(order_qty INT)
RETURNS NUMERIC AS $$
BEGIN
    IF order_qty >= 50 THEN
        RETURN 0.15;  -- 15% discount
    ELSIF order_qty >= 20 THEN
        RETURN 0.10;
    ELSE
        RETURN 0.05;
    END IF;
END;
$$ LANGUAGE plpgsql;

--Check the salesorderdetail table
SELECT productid, orderqty, calculate_discount(orderqty) AS discount
FROM sales.salesorderdetail
LIMIT 10;

--Step 2
/*Create Stored Procedures to calculate the discount and insert the record
CALCULATE DISCOUNT AND INSERT CALCULATED RECORD
*/

CREATE OR REPLACE PROCEDURE insert_discounted_order(
    p_orderid INT, p_productid INT, p_qty INT, p_unitprice NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_discount NUMERIC;
    v_total NUMERIC;
BEGIN
    v_discount := calculate_discount(p_qty);
    v_total := p_unitprice * p_qty * (1 - v_discount);

    INSERT INTO sales.salesorderdetail (
        salesorderid, productid, orderqty, unitprice, lineTotal
    ) VALUES (
        p_orderid, p_productid, p_qty, p_unitprice, v_total
    );
END;
$$;

--Step 3
/*Calling the Stored Procedures to calculate the discount and insert the record
CALL THE STORED PROCEDURE[ DISCOUNT AND INSERT CALCULATED RECORD]
*/

CALL insert_discounted_order(43659, 776, 25, 100.00);

--Step 4
/*
	### 1. Create audit table
	LOG AUDIT TABLE USED TO INSERT THE AUDIT RECORD.
*/

CREATE TABLE audit_orderqty_changes (
    audit_id SERIAL PRIMARY KEY,
    salesorderid INT,
    old_qty INT,
    new_qty INT,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


--Step 5
/*  
	#### 2. Create a trigger function
	CREATING TRIGGER FUNCTION TO INSERT LOG AUDIT RECORD INTO TABLE USED TO audit_orderqty_changes TABLE.
*/
CREATE OR REPLACE FUNCTION log_orderqty_update()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.orderqty <> NEW.orderqty THEN
        INSERT INTO audit_orderqty_changes (
            salesorderid, old_qty, new_qty
        ) VALUES (
            OLD.salesorderid, OLD.orderqty, NEW.orderqty
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Step 6
/*
	#### 3. Attach the trigger to the table
	CREATING TRIGGER FUNCTION TO INSERT LOG AUDIT RECORD INTO TABLE USED TO audit_orderqty_changes TABLE.
*/

CREATE TRIGGER trg_log_orderqty_update
AFTER UPDATE ON sales.salesorderdetail
FOR EACH ROW
EXECUTE FUNCTION log_orderqty_update();

--Step 7
/*
	#### 3. EXECUTING AND VALIDATING TRIGGER
	EXECUTING TRIGGER FUNCTION TO INSERT LOG AUDIT RECORD INTO TABLE USED TO audit_orderqty_changes TABLE.
*/

-- Update a quantity (will trigger logging)
UPDATE sales.salesorderdetail
SET orderqty = 60
WHERE salesorderid = 43659 AND productid = 776;

-- Check the audit table
SELECT * FROM audit_orderqty_changes;




