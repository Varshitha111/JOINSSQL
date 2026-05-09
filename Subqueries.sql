use firstdb;
show tables;


-- Create Departments Table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create Employees Table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    designation VARCHAR(50),
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);
-- Create Salaries Table
CREATE TABLE Salaries (
    salary_id INT PRIMARY KEY,
    emp_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

-- Insert Data into Departments
INSERT INTO Departments VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

-- Insert Data into Employees
INSERT INTO Employees VALUES
(1, 'Rahul', 101, 'Manager'),
(2, 'Sneha', 101, 'Developer'),
(3, 'Amit', 101, 'Tester'),
(4, 'Priya', 102, 'Manager'),
(5, 'Kiran', 102, 'Recruiter'),
(6, 'Anjali', 103, 'Manager'),
(7, 'Ravi', 103, 'Analyst'),
(8, 'Meena', 104, 'Executive'),
(9, 'Arjun', 104, 'Manager');

-- Insert Data into Salaries
INSERT INTO Salaries VALUES
(1, 1, 90000),
(2, 2, 70000),
(3, 3, 65000),
(4, 4, 85000),
(5, 5, 50000),
(6, 6, 95000),
(7, 7, 75000),
(8, 8, 60000),
(9, 9, 88000);
desc salaries;
desc departments;
desc employees;

-- Write a SQL query to find the names of all employees who earn a salary higher than the average 
-- salary in their department. Use a subquery to calculate the average salary for each department.
select emp_name from employees as e join salaries s on s.emp_id=e.emp_id where salary >(select avg(salary) from salaries) group by dept_id;

-- Create a query that retrieves the department names where the total salary of all 
-- employees in that department is greater than $100,000. Use a subquery to calculate the total salary for each department.
select sum(salary) from salaries;
select dept_name from departments join salaries where salary>(select sum(salary) from salaries) group by dept_id;
desc employees;
-- Develop a SQL query to find the employee with the highest salary in each department.
-- Use a subquery to first find the maximum salary in each department and then find the corresponding employee details.
select max(salary) from salaries;
select emp_name from employees join salaries where salary= (select max(salary) from salaries);

-- Write a query to find all employees who are not managers but have a salary higher 
-- than at least one manager in the company. Use a subquery to identify the salaries of all managers.

SELECT e.emp_name, s.salary
FROM Employees e
JOIN Salaries s
ON e.emp_id = s.emp_id
WHERE e.designation != 'Manager'
AND s.salary > ANY(
select salary from employees join salaries on employees.emp_id=salaries.emp_id where designation='manager');