CREATE TABLE IF NOT EXISTS emp_info
(
    emp_id integer NOT NULL DEFAULT nextval('customers_customerid_seq'::regclass),
    emp_name character varying(50) COLLATE pg_catalog."default" NOT NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS  emp_info
    OWNER to postgres;



INSERT INTO emp_info(emp_id, emp_name)
values
(1, 'Sam'),
(2, 'Benjamin'),
(3, 'joseph')


UPDATE emp_info AS t
SET emp_name = c.emp_name
FROM (VALUES
(1, 'joe'),
(2, 'Ambrose'),
(3, 'joseph')
) AS c(emp_id, emp_name)
WHERE t.emp_id = c.emp_id;

select * from emp_info
