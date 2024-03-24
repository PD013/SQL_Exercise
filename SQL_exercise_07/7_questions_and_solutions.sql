SHOW Databases;

use SQL_Exercise; -- Have to runn everytime opening the file

Show tables;

-- SCHEMA BUILDING -- Add the code to buid Schema once 

##  Tables -- Planet Express
-- Employee
-- Planet
-- Shipment
-- Has_Clearance
-- Client
-- Package

SELECT * FROM Employee;
SELECT * FROM Planet;
SELECT * FROM Shipment;
SELECT * FROM Has_Clearance;
SELECT * FROM Client;
SELECT * FROM Package;

-- https://en.wikibooks.org/wiki/SQL_Exercises/Planet_Express 
-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".

SELECT Client.Name
FROM Client JOIN Package   
  ON Client.AccountNumber = Package.Recipient 
WHERE Package.weight = 1.5;   
   
-- 7.2 What is the total weight of all the packages that he sent?
SELECT SUM(Weight) as total_weight
FROM Package
WHERE Sender = (SELECT AccountNumber FROM Client 
				WHERE Name = 'Al Gore''s Head' );

# Altenatives -- Here Used Join and then used where clause 
SELECT SUM(p.weight) 
FROM Client AS c 
  JOIN Package as P 
  ON c.AccountNumber = p.Sender
WHERE c.Name = "Al Gore's Head";

# This is a more complex approach where

SELECT SUM(p.weight), COUNT(*)
FROM Client AS c 
  JOIN Package as P 
  ON c.AccountNumber = p.Sender
WHERE c.AccountNumber = (
  SELECT Client.AccountNumber
  FROM Client JOIN Package 
    ON Client.AccountNumber = Package.Recipient 
  WHERE Package.weight = 1.5
);

#The Difference:
#COUNT(*) counts everything, including NULL values in the columns.
#COUNT(1) just counts the rows and doesn't look at the values in any column

-- 7.3 Which pilots transported those packages?
SELECT NAME
FROM Employee
JOIN Shipment ON Shipment.Manager = Employee.EmployeeID
WHERE ShipmentID IN 
(
SELECT shipment
FROM Package
WHERE Sender = (SELECT AccountNumber FROM Client 
				WHERE Name = 'Al Gore''s Head' )
);

SELECT Employee.Name
FROM Employee
  JOIN Shipment ON Shipment.Manager = Employee.EmployeeID
  JOIN Package ON Package.Shipment = Shipment.ShipmentID
WHERE Shipment.ShipmentID IN (
  SELECT p.Shipment 
  FROM Client AS c 
    JOIN Package as P 
    ON c.AccountNumber = p.Sender
  WHERE c.AccountNumber = (
    SELECT Client.AccountNumber
    FROM Client JOIN Package 
      ON Client.AccountNumber = Package.Recipient 
    WHERE Package.weight = 1.5
  )
)
GROUP BY (Employee.Name);




