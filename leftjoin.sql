-- create database d12;
-- create database company;
-- CREATE TABLE employees (emp_id INT PRIMARY KEY,emp_name VARCHAR(50),dept_id INT);
-- CREATE TABLE departments (dept_id INT PRIMARY KEY,dept_name VARCHAR(50));
-- INSERT INTO departments VALUES(101, 'HR'),(102, 'IT'),(103, 'Finance'),(104, 'Marketing');
-- INSERT INTO employees VALUES(1, 'Amit', 101),(2, 'Sara', 102),(3, 'John', NULL),(4, 'Priya', 102),(5, 'David', 103),(6, 'Neha', NULL);
-- --  Write a query to display all employees and their department names.
-- select employees.emp_name,departments.dept_name from employees left join departments on employees.dept_id=departments.dept_id;
-- -- 👉 Write a query to display all employees along with department names, and show "No Department" if an employee is not assigned to any department.
-- select e.emp_name,ifnull("dept_id","none") from employees as e left join departments as d on e.dept_id=d.dept_id;
-- -- 👉 Write a query to find employees who do not belong to any department.
-- select e.emp_name from employees as e left join departments as d on e.dept_id=d.dept_id and d.dept_id=NULL;
-- -- 👉 Write a query to display all departments and the number of employees in each department.


show databases;
use d12;
show tables;
create table departments(did int primary key,d_name varchar(50));
create table employees(eid int primary key,ename varchar(50),did int,foreign key(did) references departments(did));
-- Insert Sample Data into Departments
INSERT INTO departments VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing'),
(105, 'Sales');

-- Insert Sample Data into Employees
INSERT INTO employees VALUES
(1, 'Rahul', 101),
(2, 'Sneha', 102),
(3, 'Amit', 101),
(4, 'Priya', 103),
(5, 'Kiran', NULL),
(6, 'Anjali', 104),
(7, 'Ravi', NULL),
(8, 'Meena', 102);

-- 👉 Write a query to display all employees and their department names.
select*from employees as e left join departments as d on d.did=e.did;

-- 👉 Write a query to display all employees along with department names, and show "No Department" if an employee is not assigned to any department.
select e.ename,d.d_name from departments as d left join employees as e on d.did=e.did;

-- 👉 Write a query to find employees who do not belong to any department.
select e.ename from employees as e left join  departments as d on d.did=e.did where d.d_name is null;

-- 👉 Write a query to display all departments and the number of employees in each department.
select d.d_name,count(e.ename) from departments as d left join employees as e on d.did=e.did group by d.d_name;

-- 👉 Write a query to display all employees and only their department name if it is 'IT', otherwise show NULL.
select e.ename, case when d.d_name = 'IT' then d.d_name else null end as dep_name from employees as e left join departments as d on d.did=e.did;

-- 👉 Write a query to display only employees who belong to the 'HR' department.
select e.ename,e.did from employees as e left join departments as d on d.did=e.did where d.d_name='HR';
desc departments;

-- 👉 Write a query to display employee name and department name, but only include departments where dept_id = 101 using LEFT JOIN condition.
select e.ename,d.d_name from departments as d left join employees as e on d.did=e.did where d.did=101;

-- 👉 Write a query to display all departments that do not have any employees.
select d.d_name from departments as d left join employees as e on e.did=d.did where d.did is null;

-- 👉 Write a query to display employee name and department name, sorted by department name.
select e.ename,d.d_name from departments d left join employees e on d.did=e.did order by d.d_name asc;

-- 👉 Write a query to display:
-- employee name
-- department name
-- a new column status
-- "Assigned" if employee has a department
-- "Not Assigned" if no department
select e.ename,d.d_name, case when d.did is not null then 'assigned'else 'not assigned' end as status from employees as e left join departments as d on d.did=e.did;
