
--1- write a query to find premium customers from orders data. Premium customers are those who have done more orders than average no of orders per customer.
SELECT CustomerID
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > (SELECT AVG(cnt) FROM (SELECT CustomerID, COUNT(*) as cnt FROM Orders GROUP BY CustomerID) as subquery);
--2- write a query to find employees whose salary is more than average salary of employees in their department
SELECT EmployeeID, Salary, DepartmentID
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees AS DeptAvg WHERE Employees.DepartmentID = DeptAvg.DepartmentID);
--3- write a query to find employees whose age is more than average age of all the employees.
SELECT EmployeeID, Age
FROM Employees
WHERE Age > (SELECT AVG(Age) FROM Employees);
--4- write a query to print emp name, salary and dep id of highest salaried employee in each department
SELECT EmployeeID, Salary, DepartmentID
FROM Employees e1
WHERE Salary = (SELECT MAX(Salary) FROM Employees e2 WHERE e1.DepartmentID = e2.DepartmentID);
--5- write a query to print emp name, salary and dep id of highest salaried overall
SELECT EmployeeID, Salary, DepartmentID
FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Employees);
--6- write a query to print product id and total sales of highest selling products (by no of units sold) in each category
SELECT ProductID, SUM(Quantity) as TotalSales
FROM OrderDetails
GROUP BY ProductID
HAVING SUM(Quantity) = (SELECT MAX(TotalSales) FROM (SELECT ProductID, SUM(Quantity) as TotalSales FROM OrderDetails GROUP BY ProductID) as SubQuery WHERE OrderDetails.CategoryID = SubQuery.CategoryID);