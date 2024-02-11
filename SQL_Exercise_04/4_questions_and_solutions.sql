SHOW Databases;

use SQL_Exercise; -- Have to runn everytime opening the file

Show tables;

-- SCHEMA BUILDING -- Add the code to buid Schema once 

-- The Movie_theatres
-- lINK: https://en.wikibooks.org/wiki/SQL_Exercises/Movie_theatres
SELECT Movies , MovieTheaters;

-- 4.1 Select the title of all movies.
SELECT title FROM movies;

-- 4.2 Show all the distinct ratings in the database.
SELECT DISTINCT(Rating) FROM Movies;

-- 4.3  Show all unrated movies.
SELECT * FROM movies where rating IS Null;

-- 4.4 Select all movie theaters that are not currently showing a movie.
SELECT Name FROM MovieTheaters WHERE Movie Is Null;

-- 4.5 Select all data from all movie theaters 
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
SELECT * FROM MovieTheaters
LEFT JOIN MOVIES 
ON MovieTheaters.Movie = MOVIES.code;    

-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
SELECT * FROM MovieTheaters
RIGHT JOIN MOVIES 
ON MovieTheaters.Movie = MOVIES.code;  

-- 4.7 Show the titles of movies not currently being shown in any theaters.
SELECT title FROM Movies 
WHERE code NOT IN (SELECT DISTINCT Movie 
					FROM MovieTheaters 
					 where movie is NOT NULL);

 /* With JOIN */
 SELECT Movies.Title
   FROM MovieTheaters RIGHT JOIN Movies
   ON MovieTheaters.Movie = Movies.Code
   WHERE MovieTheaters.Movie IS NULL;
   
   
-- 4.8 Add the unrated movie "One, Two, Three".

 INSERT INTO Movies(code,Title,Rating) VALUES(9,'One, Two, Three',NULL);

-- 4.9 Set the rating of all unrated movies to "G".
UPDATE Movies SET Rating = 'G'
WHERE Rating is NULL;

-- 4.10 Remove movie theaters projecting movies rated "NC-17".
DELETE FROM MovieTheaters 
WHERE Movie in (SELECT Code FROM Movies 
					Where rating ='NC-17') ;


