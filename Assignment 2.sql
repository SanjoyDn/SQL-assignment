

--1- write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909
select * from orders
update orders
set city = NULL
WHERE order_id IN ('CA-2020-161389', 'US-2021-156909');

--2- write a query to find orders where city is null (2 rows)
select * from orders
where city is NULL;

--3- write a query to get total profit, first order date and latest order date for each category
SELECT category, 
SUM(profit) AS total_profit, 
MIN(order_date) AS first_order_date, 
MAX(order_date) AS latest_order_date
FROM orders
GROUP BY category;

--4- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category
SELECT sub_category
FROM orders
GROUP BY sub_category
HAVING AVG(profit) > (MAX(profit) / 2);


/*5- create the exams table with below script;
create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

write a query to find students who have got same marks in Physics and Chemistry.*/
CREATE TABLE exams (
    student_id INT,
    subject VARCHAR(20),
    marks INT
);
INSERT INTO exams (student_id, subject, marks)
VALUES 
    (1, 'Chemistry', 91),
    (1, 'Physics', 91),
    (1, 'Maths', 92),
    (2, 'Chemistry', 80),
    (2, 'Physics', 90),
    (3, 'Chemistry', 80),
    (3, 'Maths', 80),
    (4, 'Chemistry', 71),
    (4, 'Physics', 54),
    (5, 'Chemistry', 79);

SELECT student_id
FROM exams e1
WHERE e1.subject = 'Physics' 
  AND e1.marks = (
      SELECT e2.marks 
	  FROM exams e2 
WHERE e2.subject = 'Chemistry' AND e2.student_id = e1.student_id
 );

--6- write a query to find total number of products in each category.
SELECT category, 
COUNT(product_id) AS total_products
FROM orders
GROUP BY category;

--7- write a query to find top 5 sub categories in west region by total quantity sold
SELECT top 5 sub_category, SUM(quantity) AS total_quantity
FROM orders
WHERE region = 'West'
GROUP BY sub_category
ORDER BY total_quantity DESC


--8- write a query to find total sales for each region and ship mode combination for orders in year 2020
SELECT region, ship_mode, SUM(sales) AS total_sales
FROM orders
WHERE YEAR(order_date) = 2020
GROUP BY region, ship_mode;