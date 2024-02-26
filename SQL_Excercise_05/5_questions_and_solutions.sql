SHOW Databases;

use SQL_Exercise; -- Have to runn everytime opening the file

Show tables;

-- SCHEMA BUILDING -- Add the code to buid Schema once 


-- Pieces_and_providers

SELECT * FROM Providers;

SELECT * FROM Provides;

SELECT * FROM Pieces;

-- 5.1 Select the name of all the pieces. 
SELECT Name FROM Pieces;

-- 5.2  Select all the providers' data. 
SELECT * FROM Provides;

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
SELECT piece , AVG(Price) 
FROM Provides
GROUP BY piece;

-- 5.4  Obtain the names of all providers who supply piece 1.

# With Subquery 
SELECT Name FROM providers 
WHERE code in (SELECT Provider FROM provides WHERE piece = 1);

# without Subquery
SELECT Providers.Name
   FROM Providers INNER JOIN Provides
          ON Providers.Code = Provides.Provider
             AND Provides.Piece = 1;


-- 5.5 Select the name of pieces provided by provider with code "HAL".

# Using Subquery
SELECT Name FROM Pieces 
WHERE code in (SELECT Piece FROM provides WHERE provider = 'HAL'); 

# Without Subquery
SELECT Pieces.name FROM Pieces
INNER JOIN Provides
ON Pieces.code =  Provides.Piece
AND provider = 'HAL';

 /* With EXISTS subquery */
SELECT Name
 FROM Pieces
 WHERE EXISTS 
(
     SELECT * FROM Provides
       WHERE Provider = 'HAL'
         AND Piece = Pieces.Code
   );
## SQL EXISTS Operator
-- The EXISTS operator is used to test for the existence of any record in a subquery.
-- The EXISTS operator returns TRUE if the subquery returns one or more records.


-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
SELECT piece ,price, Pieces.name , providers.name  
FROM Provides INNER JOIN providers ON provides.provider = providers.code
INNER JOIN Pieces ON provides.piece = Pieces.code
   WHERE Price =
   (
     SELECT MAX(Price) FROM Provides
     WHERE Piece = Pieces.Code
   );
-- ---------------------------------------------

-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO Provides VALUES(1,'TNBC', 7);


-- 5.8 Increase all prices by one cent.
update provides 
SET price = price * 1.1

-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).


-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
