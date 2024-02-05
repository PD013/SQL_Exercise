SHOW Databases;

use SQL_Exercise; -- Have to runn everytime opening the file

Show tables;

-- SCHEMA BUILDING -- Add the code to buid Schema once 

-- The Warehouse
-- lINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_warehouse

-- 3.1 Select all warehouses.
SELECT * FROM warehouses;

-- 3.2 Select all boxes with a value larger than $150.
SELECT * FROM Boxes WHERE Value > 150;

-- 3.3 Select all distinct contents in all the boxes.
SELECT Distinct Contents FROM Boxes;

-- 3.4 Select the average value of all the boxes.
SELECT AVG(Value) FROM Boxes;

-- 3.5 Select the warehouse code and the average value of the boxes in each warehouse.
SELECT Warehouse , AVG(Value) FROM Boxes GROUP BY Warehouse;

-- 3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
SELECT Warehouse , AVG(Value) as Value 
FROM Boxes 
GROUP BY Warehouse 
HAVING Value > 150;

SELECT * FROM Warehouses ;
SELECT * FROM Boxes;

-- 3.7 Select the code of each box, along with the name of the city the box is located in.
SELECT Boxes.Code , Location FROM Warehouses 
INNER JOIN Boxes ON
BOXES.Warehouse = Warehouses.code;

-- 3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
    -- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
 
 /* Not taking into account empty warehouses */
 SELECT Warehouse, COUNT(*)
 FROM Boxes
 GROUP BY Warehouse;
 
 /* Taking into account empty warehouses */
SELECT Warehouses.code , COUNT(Boxes.Warehouse) 
FROM Warehouses LEFT JOIN 
Boxes ON
Warehouses.code = Boxes.Warehouse   
GROUP BY Warehouses.code;


-- 3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
SELECT Code FROM Warehouses
WHERE Capacity < (SELECT COUNT(*) FROM Boxes WHERE Warehouse = Warehouses.Code);

-- 3.10 Select the codes of all the boxes located in Chicago.
SELECT code FROM Boxes 
WHERE Warehouse IN (SELECT code FROM Warehouses WHERE Location = 'Chicago');

-- 3.11 Create a new warehouse in New York with a capacity for 3 boxes.

INSERT 
   INTO Warehouses
        (Code , Location,Capacity)
 VALUES (6,'New York',3);

-- 3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT 
   INTO Boxes
        (Code, Contents, Value, Warehouse)
 VALUES ("H5RT","Papers",200,2);

-- 3.13 Reduce the value of all boxes by 15%.
UPDATE Boxes
SET value = value * 0.85;

-- 3.14 Remove all boxes with a value lower than $100.
DELETE FROM Boxes
WHERE value < 100;

-- 3.15 Remove all boxes from saturated warehouses.
 DELETE FROM Boxes 
  WHERE Warehouse IN 
  (
   SELECT * FROM 
     (
       SELECT Code
	 FROM Warehouses
	 WHERE Capacity <
           (
                SELECT COUNT(*)
		  FROM Boxes
		  WHERE Warehouse = Warehouses.Code
            )
      ) AS Bxs
  );

-- ## Syntax for CREATE INDEX
-- #  CREATE INDEX index_name // There is also UNIQUE INDEX 
-- #  ON table_name (column1, column2, ...);

# Syntax to Delete the Index / Also Index is not visible use for fast searching by system
-- ALTER TABLE table_name
-- DROP INDEX index_name;


-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
CREATE INDEX INDEX_WAREHOUSE100 ON Boxes (code);
    
-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
SHOW INDEXES FROM Boxes; 
SHOW INDEX FROM SQL_Exercise.Boxes;
    
-- 3.18 Remove (drop) the index you added just  ## PENDING PARTT  ## -------=================

    -- !!!NOTE!!!: index should NOT be used on small tables in practice
ALTER TABLE boxes DROP FOREIGN KEY boxes_ibfk_1; -- when creating Index on a key then it cannot be deleted easily
DROP INDEX INDEX_WAREHOUSE1 ON boxes;
SHOW CREATE TABLE boxes; ## THIS IS PENDING QUESTION 
