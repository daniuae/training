
CREATE TABLE Employees (
    EmployeeID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    DepartmentID INT,
    Salary NUMERIC,
    JoiningDate DATE
);


CREATE TABLE Departments (
    DepartmentID SERIAL PRIMARY KEY,
    DepartmentName VARCHAR(100)
);


CREATE TABLE Projects (
    ProjectID SERIAL PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT REFERENCES Employees(EmployeeID),
    ProjectID INT REFERENCES Projects(ProjectID),
    AllocationHours INT
);

/*
Section 1: Basic SQL and Operators (Q1–Q8)

List all employees who earn more than the average salary in their department.
Find employees who joined before 2015 and have 'an' in their name (case-insensitive).
Get names of departments that don’t have any employees.
Show the number of employees in each department. Include departments with zero employees.
Retrieve names of employees working on more than 2 projects.
Find the total salary expense for each department.
List employees whose names start and end with a vowel.
Display employees with NULL salary or salary less than 20000.


Section 2: Joins & Aggregations (Q9–Q16)

Get a list of all employees and their department names.
List each employee’s name and total number of hours they are allocated across all projects.
Show the average allocation hours per project.
Find employees who are not assigned to any project.
List projects that have more than 3 employees assigned.
Get department names along with their highest paid employee.
List employees working in the same department as 'John'.
Find employees who are working on all projects (assigned to every project in the DB).


Section 3: CTEs (Common Table Expressions) (Q17–Q24)

Use a CTE to get the second-highest salary in each department.
Find employees who are earning above their department’s average using a CTE.
Create a recursive CTE to display the reporting hierarchy starting from EmployeeID = 1 (Assume ManagerID column exists).
Using a CTE, calculate cumulative salary department-wise.
Write a CTE that returns employees with more than 10% higher salary than the overall average.
Using a CTE, list the top 3 highest paid employees in each department.
Write a CTE to show employees who joined in the earliest 5% of all join dates.
Using CTEs, show the project with the longest duration.

Section 4: Window Functions (Q25–Q32)

For each employee, show their salary rank within the department.
Calculate running total of salary within each department.
Display each employee’s salary and the department average salary as a new column.
Use LAG() to find the previous employee's salary (ordered by JoiningDate).
Use LEAD() to find the next employee to join after each employee.
Find the difference in salary between each employee and the employee who joined just before them in the same department.
For each project, list the employee who spent the most hours.
Rank employees across the company based on salary and break ties alphabetically.


Section 5: Built-in Functions, CASE, and Formatting (Q33–Q36)

Show all employees with their joining month name (e.g., 'January').
Create a column that labels salaries as 'Low', 'Medium', or 'High' using CASE.
Convert all department names to uppercase.
Format salaries with commas (e.g., 80,000).

Section 6: Subqueries, EXISTS, and Set Ops (Q37–Q40)

List employees who earn more than the highest-paid employee in the 'HR' department.
Use a correlated subquery to get employees earning more than their department's average.
Find employees who are not assigned to any project using NOT EXISTS.
Use INTERSECT to find employees who are both in 'IT' department and working on 'Alpha' project.



*/
