--Task 1: Find all active employees in the Engineering department (dept_id = 1) earning more than 90,000.
select
emp_id, first_name, Last_name, job_title
from employees
where salary>90000 and is_active=1

--Task 2: Find products with a unit_price BETWEEN 20,000 and 100,000. Then find products in categories 1, 4, or 5 only.
select product_name, unit_price, cat_id
from products
where cat_id in (1,4,5) and unit_price between 20000 and 100000

--Task 3: Find all employees whose email ends with @acme.com AND whose first name starts with 'S'.
select * from employees
where email like '%@acme.com' and first_name like 'S%'

--Task 4.1: What is the total salary payroll per department?
select dept_id,sum(salary) 
from employees
group by dept_id

--Task 4.2: What is the average product price per category?
select cat_id, avg(unit_price)
from products
group by cat_id

--Task 4.3: How many employees does each department have?
select dept_id, count(emp_id) as total_employee
from employees
group by dept_id
order by total_employee asc

--Task 5: Find departments where the total salary bill exceeds 300,000. Show dept_id and the total.
select dept_id from employees 
group by dept_id
having sum(salary)>300000
 

--Task 6: Count how many orders are in each status (Pending, Processing, Shipped, Delivered, Cancelled).
select status, count(order_id) as total_orders
from orders
group by status

--Task 7.1: Find the highest and lowest-paid employees.
select emp_id, first_name, last_name, salary
from employees
where salary=(select max(salary) from employees)
or
salary=(select min(salary) from employees)

--Alt 01
select top 1 
emp_id, first_name, last_name, salary
from employees
order by salary ASC

--Alt 02
select top 1 
emp_id, first_name, last_name, salary
from employees
order by salary DESC

--Task 7.2: Find the total revenue from all Paid invoices.
--select * from INFORMATION_SCHEMA.TABLES
select sum(paid_amount) as total_revenue from invoices

--Task 7.3: Find the product with the lowest stock_qty (that is still active).
select product_name, stock_qty
from products
where is_active=1 and stock_qty=(select min(stock_qty) from products)

--Task 8: Find all employees hired in the year 2020. Then find all orders placed in Q4 2023 (Oct–Dec)
