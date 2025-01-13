--1- write a query to print emp name , their manager name and diffrence in their age (in days) 
--for employees whose year of birth is before their managers year of birth
SELECT 
e.emp_name AS employee_name,
m.emp_name AS manager_name,
DATEDIFF(CURDATE(), e.birth_date) - DATEDIFF(CURDATE(), m.birth_date) AS age_difference_in_days
FROM 
employee e
JOIN 
employee m ON e.manager_id = m.emp_id
WHERE 
YEAR(e.birth_date) < YEAR(m.birth_date);

--2- write a query to find subcategories who never had any return orders in the month of november (irrespective of years)
SELECT 
    subcategory
FROM 
    orders o
WHERE 
NOT EXISTS (
SELECT 1
FROM orders o2
WHERE o2.subcategory = o.subcategory
AND MONTH(o2.order_date) = 11
AND o2.[Return Reason] IS NOT NULL)
GROUP BY 
subcategory;

--3- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
--write a query to find order ids where there is only 1 product bought by the customer.
SELECT 
order_id
FROM 
orders
GROUP BY 
order_id
HAVING 
COUNT(*) = 1;

--4- write a query to print manager names along with the comma separated list(order by emp salary) of all employees directly reporting to him.
SELECT 
m.emp_name AS manager_name,
GROUP_CONCAT(e.emp_name ORDER BY e.salary) AS employees_list
FROM 
employee e
JOIN 
employee m ON e.manager_id = m.emp_id
GROUP BY 
m.emp_name;

--5- write a query to get number of business days between order_date and ship_date (exclude weekends). 
--Assume that all order date and ship date are on weekdays only
SELECT 
order_id,
DATEDIFF(ship_date, order_date) - (2 * (WEEKDAY(order_date) > WEEKDAY(ship_date))) AS business_days
FROM 
orders;

--6- write a query to print 3 columns : category, total_sales and (total sales of returned orders)
SELECT 
category,
SUM(sales) AS total_sales,
SUM(CASE WHEN [Return Reason] IS NOT NULL THEN sales ELSE 0 END) AS returned_sales
FROM 
orders
GROUP BY 
category;

--7- write a query to print below 3 columns
--category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)
SELECT 
category,
SUM(CASE WHEN YEAR(order_date) = 2019 THEN sales ELSE 0 END) AS total_sales_2019,
SUM(CASE WHEN YEAR(order_date) = 2020 THEN sales ELSE 0 END) AS total_sales_2020
FROM 
orders
GROUP BY 
category;

--8- write a query print top 5 cities in west region by average no of days between order date and ship date.
SELECT top 5 city, AVG(DATEDIFF(ship_date, order_date)) AS avg_days
FROM 
orders
WHERE 
region = 'West'
GROUP BY 
city
ORDER BY 
avg_days ASC


--9- write a query to print emp name, manager name and senior manager name (senior manager is manager's manager)
SELECT e.emp_name AS employee_name,
m.emp_name AS manager_name,
sm.emp_name AS senior_manager_name
FROM 
employee e
JOIN 
employee m ON e.manager_id = m.emp_id
JOIN 
employee sm ON m.manager_id = sm.emp_id;
