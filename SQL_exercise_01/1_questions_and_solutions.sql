CREATE database SQL_Exercise;
Show databases;


use SQL_Exercise; -- Have to runn everytime opening the file

Show tables;

-- SCHEMA BUILDING -- Add the code to buid Schema once 

SHOW tables;

-- QUESTIONS AND ANSWERS

-- 1.1 Select the names of all the products in the store.
SELECT name FROM products;

-- 1.2 Select the names and the prices of all the products in the store.
SELECT name , price FROM products;

-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT name 
FROM products 
where price <= 200;

-- 1.4 Select all the products with a price between $60 and $120.
select * from products where price between 60 and 120;
select * from products where price >= 60 and price <= 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT name , (price*100) as price_in_cents 
FROM products;
select name, concat(price*100, ' cents') as price_in_cents  from products;

-- 1.6 Compute the average price of all the products.
SELECT AVG(price) as Avergae_price FROM products;

-- - 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(price) FROM products WHERE Manufacturer = '2';

-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(*) FROM products WHERE Price  >= 180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT name,price  FROM products WHERE price >= 180
ORDER BY price DESC , name ASC;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
SELECT * FROM products P LEFT JOIN manufacturers M ON M.code = P.Manufacturer;
 /* Without LEFT JOIN */
 SELECT * FROM Products, Manufacturers
   WHERE Products.Manufacturer = Manufacturers.Code;

-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT P.name , price , M.name as Manufacturer_name
FROM products P 
INNER JOIN manufacturers M  
#Inner join returns only the matching rows between both the tables, non matching rows are eliminated
ON M.code = P.Manufacturer;
 
  /* Without INNER JOIN */
SELECT Products.Name, Price, Manufacturers.Name
FROM Products, Manufacturers
WHERE Products.Manufacturer = Manufacturers.Code;

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT Manufacturer,AVG(price) FROM Products GROUP BY Manufacturer;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT AVG(P.Price),M.name FROM products P
INNER JOIN manufacturers M
ON M.code = P.Manufacturer
GROUP BY P.Manufacturer;
# Inner joins combine records from two tables whenever there are matching values in a field common to both tables

 /* Without Joins */
SELECT AVG(P.Price),M.name FROM products P , manufacturers M
WHERE M.code = P.Manufacturer
GROUP BY P.Manufacturer;


-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT AVG(P.Price) as average,M.name FROM products P
INNER JOIN manufacturers M
ON M.code = P.Manufacturer
GROUP BY P.Manufacturer
HAVING average >= 150; # This is the only extra line required too add in any of the above 2 answers to get same result

-- 1.15 Select the name and price of the cheapest product.
SELECT price, name 
FROM products 
ORDER BY price ASC
LIMIT 1;

/* With a nested SELECT */
/* WARNING: If there is more than one item with the cheapest price it will select them both */
SELECT price,name
FROM products
WHERE price = (SELECT MIN(price) FROM Products);


-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT M.name , P.name , P.price
FROM products P 
INNER JOIN manufacturers M
ON M.code = P.manufacturer
AND P.Price = (
SELECT MAX(P.Price)
FROM products P 
WHERE P.Manufacturer = M.Code);

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO products (Code ,Name , Price , Manufacturer)
VALUES (11, 'Loudspeakers',70,2); 

-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE products 
SET Name = 'Laser Printer'
WHERE Code = 8;

SELECT * FROM products;

-- 1.19 Apply a 10% discount to all products.
UPDATE products
SET Price = Price*0.9;
# SET Price = Price - (Price * 0.1); Another way

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
UPDATE products
SET Price = Price*0.9
WHERE Price >= 120;


-- 1.21  Select the name of each manufacturer which have an average price above $145 and contain at least 2 different products.
Select m.Name, Avg(p.price) as p_price, COUNT(p.Manufacturer) as m_count
FROM Manufacturers m, Products p
WHERE p.Manufacturer = m.code
GROUP BY m.Name , p.Manufacturer
HAVING Avg(p.price) >= 150 and COUNT(p.Manufacturer) >= 2;
# Here answer is not coming cause we have updated the tables so no worries it will work fine