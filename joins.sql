CREATE TABLE IF NOT EXISTS public.employees_1
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

INSERT INTO public.employees_1
(id, name, age, department, phone_number, hire_date, manager_id, salary, dept_id)
VALUES 

--(1, 'Alice Johnson', 29, 1, 555-1234, '2018-03-15', 12, 60000, 101),
(2, 'Brian Smith', 35, 2, 555-5678, '2016-07-20', 15, 75000, 102),
(3, 'Catherine Lee', 31, 3, 555-9101, '2019-01-08', 7, 95000, 103),
(4, 'David Kim', 28, 3, 555-1122, '2020-02-17', 3, 70000, 103),
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



select * FROM Employees
select * FROM Departments 
SELECT  * FROM employees_1 E INNER JOIN Departments D ON E.id
= D.dept_id;

