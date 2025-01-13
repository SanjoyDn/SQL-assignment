create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');


create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');


 select * from icc_world_cup

--1- write a query to produce below output from icc_world_cup table.
--team_name, no_of_matches_played , no_of_wins , no_of_losses

SELECT 
    Team_name, 
    COUNT(*) AS no_of_matches_played, 
    SUM(Winner = Team_name) AS no_of_wins, 
    SUM(Winner != Team_name AND Winner != '') AS no_of_losses
FROM
    (SELECT Team_1 AS Team_name FROM icc_world_cup
     UNION ALL
     SELECT Team_2 AS Team_name FROM icc_world_cup) AS All_Teams
GROUP BY 
    Team_name;

--2- write a query to print first name and last name of a customer using orders table(everything after first space can be considered as last name)
--customer_name, first_name,last_name

SELECT 
    customer_name, 
    SUBSTRING_INDEX(customer_name, ' ', 1) AS first_name, 
    SUBSTRING_INDEX(customer_name, ' ', -1) AS last_name
FROM 
    orders;
--3- write a query to print below output using drivers table. Profit rides are the no of rides where end location of a ride is same as start location of immediate next ride for a driver
--id, total_rides , profit_rides
--dri_1,5,1
--dri_2,2,0

SELECT 
id, 
COUNT(*) AS total_rides, 
SUM(d1.end_loc = d2.start_loc) AS profit_rides
FROM 
drivers d1
JOIN 
drivers d2 ON d1.id = d2.id AND d1.end_time < d2.start_time 
GROUP BY 
id;
--4- write a query to print customer name and no of occurence of character 'n' in the customer name.
--customer_name , count_of_occurence_of_n
SELECT 
    customer_name, 
    LENGTH(customer_name) - LENGTH(REPLACE(customer_name, 'n', '')) AS count_of_occurence_of_n
FROM 
    orders;
--5-write a query to print below output from orders data. example output
--hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
--category , Technology, ,
--category, Furniture, ,
--category, Office Supplies, ,
--sub_category, Art , ,
--sub_category, Furnishings, ,
--and so on all the category ,subcategory and ship_mode hierarchies 
SELECT 
    h.hierarchy_type, 
    h.hierarchy_name, 
    SUM(o.region = 'West' AND o.sales) AS total_sales_in_west_region,
    SUM(o.region = 'East' AND o.sales) AS total_sales_in_east_region
FROM 
    hierarchy h
LEFT JOIN 
    orders o ON h.hierarchy_name = 
        CASE 
            WHEN h.hierarchy_type = 'category' THEN o.category 
            WHEN h.hierarchy_type = 'sub_category' THEN o.sub_category 
            -- Add more cases for other hierarchy levels 
        END
GROUP BY 
    h.hierarchy_type, 
    h.hierarchy_name;
--6- the first 2 characters of order_id represents the country of order placed . write a query to print total no of orders placed in each country
--(an order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order)
SELECT 
    LEFT(order_id, 2) AS country_code, 
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    orders
GROUP BY 
    country_code;