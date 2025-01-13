select*from orders;
select * from returns$;

--1- write a query to get region wise count of return orders
SELECT region, COUNT(*) AS return_orders
FROM 
orders o
inner join returns$ r 
ON o.order_id = r.[Order Id]
GROUP BY region;

--2- write a query to get category wise sales of orders that were not returned
SELECT category, SUM(sales) AS total_sales
FROM 
orders o
left join 
returns$ r 
ON o.order_id = r.[Order Id]
WHERE r.[Order Id] IS NULL
GROUP BY category;

--3- write a query to print dep name and average salary of employees in that dep.
SELECT d.dep_name, AVG(e.salary) AS average_salary
FROM employee e
JOIN dept d ON e.dept_id = d.dep_id
GROUP BY d.dep_name;

--4- write a query to print dep names where none of the emplyees have same salary.
SELECT d.dep_name
FROM dept d
JOIN
employee e 
ON d.dep_id = e.dept_id
GROUP BY d.dep_name
HAVING COUNT(DISTINCT e.salary) = COUNT(e.salary);

--5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)
SELECT sub_category
FROM orders o
inner join returns$ r 
ON o.order_id = r.[Order Id]
GROUP BY sub_category
HAVING COUNT(DISTINCT [Return Reason]) = (SELECT COUNT(DISTINCT [Return Reason]) FROM returns$);


--6- write a query to find cities where not even a single order was returned.
SELECT DISTINCT city
FROM orders
WHERE city NOT IN (
SELECT DISTINCT city
FROM orders
WHERE[Return Reason] IS NOT NULL
);


--7- write a query to find top 3 subcategories by sales of returned orders in east region
SELECT top 3 sub_category, SUM(sales) AS total_sales
FROM 
orders
WHERE [Return Reason] IS NOT NULL 
AND region = 'East'
GROUP BY 
sub_category
ORDER BY 
total_sales DESC

--8- write a query to print dep name for which there is no employee
SELECT dep_name
FROM dept
WHERE dep_id NOT IN (
SELECT DISTINCT dept_id
FROM employee
);

--9- write a query to print employees name for dep id is not avaiable in dept table
SELECT e.emp_name
FROM employee e
LEFT JOIN 
dept d 
ON e.dept_id = d.dep_id
WHERE d.dep_id IS NULL;