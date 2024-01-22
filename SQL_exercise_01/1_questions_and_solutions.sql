CREATE database SQL_Exercise;
Show databases;


use SQL_Exercise;
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