--Task 1: Find all active employees in the Engineering department (dept_id = 1) earning more than 90,000.
select
emp_id, first_name, Last_name, job_title
from employees
where salary>90000 and is_active=1

--Task 2: Find products with a unit_price BETWEEN 20,000 and 100,000. Then find products in categories 1, 4, or 5 only.


--Task 3: Find all employees whose email ends with @acme.com AND whose first name starts with 'S'.


--Task 4.1: What is the total salary payroll per department?


--Task 4.2: What is the average product price per category?


--Task 4.3: How many employees does each department have?


--Task 5: Find departments where the total salary bill exceeds 300,000. Show dept_id and the total.


--Task 6: Count how many orders are in each status (Pending, Processing, Shipped, Delivered, Cancelled).


--Task 7.1: Find the highest and lowest-paid employees.


--Task 7.2: Find the total revenue from all Paid invoices.


--Task 7.3: Find the product with the lowest stock_qty (that is still active).


--Task 8: Find all employees hired in the year 2020. Then find all orders placed in Q4 2023 (Oct–Dec)
