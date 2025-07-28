--Step #1
-- Employee Table
CREATE TABLE employees_sptr (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    salary NUMERIC(10, 2)
);

-- Audit Table
CREATE TABLE salary_audit_sptr (
    audit_id SERIAL PRIMARY KEY,
    emp_id INT,
    old_salary NUMERIC(10, 2),
    new_salary NUMERIC(10, 2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Step #2
INSERT INTO employees_sptr (emp_name, salary)
VALUES 
('Om', 50000),
('Shivam', 60000),
('Biju', 70000);


CREATE OR REPLACE FUNCTION salary_change_logging()
RETURNS TRIGGER AS $$
BEGIN
    -- Only log if salary actually changed
    IF NEW.salary <> OLD.salary THEN
        INSERT INTO salary_audit_sptr(emp_id, old_salary, new_salary)
        VALUES (OLD.emp_id, OLD.salary, NEW.salary);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


--Step #4 

CREATE TRIGGER trg_salary_update
	AFTER UPDATE ON employees_sptr
	FOR EACH ROW
	WHEN (OLD.salary IS DISTINCT FROM NEW.salary)
EXECUTE FUNCTION salary_change_logging();

--Step #5

/*
Select * from employees_sptr
Select * from salary_audit_sptr
*/

UPDATE employees_sptr
SET salary = 75000
WHERE emp_id = 2;

/*Check the audit log*/

SELECT * FROM salary_audit_sptr;
