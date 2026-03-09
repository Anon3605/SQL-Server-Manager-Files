--Task 1: List every order alongside the customer's company_name and the order's status.
--select * from customers
--select * from orders

select 
orders.customer_id, 
customers.company_name, 
orders.status
from customers
full join orders
on customers.customer_id=orders.customer_id


--Task 2: Show order details including: order_id, customer, company_name, sales rep full name (first + last), order_date, status.
--select * from INFORMATION_SCHEMA.TABLES
--select * from orders

select 
orders.order_id,  
customers.company_name as customer_company, 
employees.first_name + ' '+ employees.last_name as emp_full_name, 
orders.order_date,
orders.status
from orders
inner join customers
on customers.customer_id=orders.customer_id
inner join  employees
on orders.emp_id=employees.emp_id

--Task 3: List ALL customers and any orders they've made. Include customers who have placed zero orders (show NULL for order fields).
--select * from orders
--select * from customers

select *
from customers
left join orders
on customers.customer_id=orders.customer_id

--Task 4: List each employee with their manager's full name. Employees with no manager should still appear..
select * from employees
select * from salary_history
select 
m.manager

select * from INFORMATION_SCHEMA.TABLES
select * from departments

select * from audit_log
select * from sysdiagrams
select * from departments
select * from employees
select * from salary_history
select * from customers
select * from categories
select * from products
select * from orders
select * from order_items
select * from projects
select * from project_assignments
select * from leave_requests
select * from invoices

--Task 5: Show a full order line detail: order_id, customer name, product name, category name, quantity, unit_price, and calculated line_total (after discount).


--Task 6: For each customer, show their total number of orders and total amount spent (sum of line totals). Order by total spent DESC.


--Task 7: Create a single list of all locations — combining departments.location and customers.city. Remove duplicates. Label each with a source column ('Department' or 'Customer City').


--Task 8: Find products that have NEVER appeared in any order_items record.


--Task 9: Find the top 3 best-selling products by total revenue (quantity × unit_price × (1 - discount/100)).

