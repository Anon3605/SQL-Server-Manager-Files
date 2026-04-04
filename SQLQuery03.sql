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

select 
    *
from customers
left join orders
on customers.customer_id=orders.customer_id

--Task 4: List each employee with their manager's full name. Employees with no manager should still appear..
--select * from employees
--Note: It is a self referencing table

select 
	e.emp_id,
	e.first_name+' '+e.last_name as employee_name,
	e.manager_id,
	m.first_name+' '+e.last_name as manager_name
from employees as e
left join employees as m on e.manager_id=m.emp_id
order by e.emp_id

--Task 5: Show a full order line detail: order_id, customer name, product name, category name, quantity, unit_price, and calculated line_total (after discount).
--select * from orders
--select * from customers
--select * from products
--select * from categories
--SELECT * FROM order_items
--select * from INFORMATION_SCHEMA.tables

select 
	o.order_id, c.contact_name, p.product_name, ct.cat_name,
	i.quantity, i.unit_price,
	(i.quantity*(i.unit_price-i.discount)) as line_total
from orders as o
full join customers as c
on o.customer_id=c.customer_id
full join order_items as i
on o.order_id=i.order_id
full join products as p
on p.product_id=i.product_id
full join categories as ct
on ct.cat_id=p.cat_id


--Task 6: For each customer, show their total number of orders and total amount spent (sum of line totals). Order by total spent DESC.
select * from customers
select * from orders
select * from order_items

select 
	c.customer_id, 
	count(o.order_id) as total_order, 
	sum(i.quantity*(i.unit_price-i.discount)) as total_amount_spent
from customers as c
full join orders as o
on o.customer_id=c.customer_id
full join order_items as i
on o.order_id=i.order_id
group by c.customer_id
order by c.customer_id DESC

--Task 7: Create a single list of all locations — combining departments.location and customers.city. Remove duplicates. Label each with a source column ('Department' or 'Customer City').
--select * from customers
--select * from departments

select distinct
	d.location as location,
	'Departments' as source_name
from departments as d
union 
select distinct
	c.city as location,
	'Coustomers' as source_name
from customers as c
order by source_name, location;

--Task 8: Find products that have NEVER appeared in any order_items record.
--select * from order_items;
--select * from products;

--Way:01
select distinct
	p.product_name,
	p.product_id
from products as p
full join order_items as oi
on oi.product_id=p.product_id
where oi.product_id is Null
order by product_id

--Way:02
SELECT 
    product_id,
    product_name,
    unit_price
FROM products
WHERE product_id NOT IN (
    SELECT product_id 
    FROM order_items
);

--Way:03
SELECT 
    p.product_id,
    p.product_name,
    p.unit_price
FROM products AS p
WHERE NOT EXISTS (
    SELECT 1 
    FROM order_items AS oi
    WHERE oi.product_id = p.product_id
);

--Way:04
SELECT 
    p.product_id,
    p.product_name,
    p.unit_price
FROM products AS p
LEFT JOIN order_items AS oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

--Way:05
SELECT 
    product_id, 
    product_name, 
    unit_price 
FROM products
EXCEPT
SELECT 
    p.product_id, 
    p.product_name, 
    p.unit_price 
FROM products AS p
JOIN order_items AS oi ON p.product_id = oi.product_id;

--Task 9: Find the top 3 best-selling products by total revenue (quantity × unit_price × (1 - discount/100)).
--select * from products
--select * from INFORMATION_SCHEMA.TABLES

SELECT TOP 3
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100.0)) AS total_revenue
FROM products AS p
JOIN order_items AS oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;