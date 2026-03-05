use AcmeCorp

--Task 1: List all tables and describe what each stores. Write a query that 
--shows all columns in the employees table with their data types.

--information_schema is a built-in read-only table for metadata
--This gives data about the database and it's tables(object)

select 
* 
from INFORMATION_SCHEMA.COLUMNS 
where TABLE_NAME='employees'

--Task 2: Retrieve all columns from departments. 
--Then rewrite it to fetch only dept_name and budget, ordered by budget DESC.

select 
dept_name, budget
from departments
order by budget desc

--Task 3: Select first_name, last_name, and
--calculate salary * 12 as annual_salary for all employees.

select 
first_name, last_name, 
salary*12 as anual_salary 
from employees

--Task 4: Find all unique job titles in the company. 
--How many distinct job titles exist?

select distinct
job_title 
from employees

select
COUNT(distinct job_title) as total_titles
from employees

--Task 5: Find the 5 most expensive products by unit_price.

select top 5
product_name, unit_price 
from products
order by unit_price DESC

--Task 6: Add a new column linkedin_url VARCHAR(300) 
--to the employees table. Then drop it

alter table employees
add linkedin_url varchar(300) null

--select * from employees

alter table employees
drop column linkedin_url

--select * from employees

--Task 7:List all employees who do NOT have a manager 
--(i.e., manager_id is NULL). These are top-level executives.

select 
emp_id, first_name, last_name
from employees
where manager_id is NULL 