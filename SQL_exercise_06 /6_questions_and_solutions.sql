SHOW Databases;

use SQL_Exercise; -- Have to runn everytime opening the file

Show tables;

-- SCHEMA BUILDING -- Add the code to buid Schema once 

##  Tables -- Scientists
-- Scientists
-- Projects 
-- AssignedTo

SELECT * FROM Scientists;
SELECT * FROM Projects;
SELECT * FROM AssignedTo;


SELECT Scientists.Name as Name_of_Scientist , x.Scientist as id_num , x.Project as project_id , x.Name as project_name , x.Hours 
FROM (SELECT AssignedTo.Scientist , AssignedTo.Project , Projects.Name , Projects.Hours
FROM AssignedTo 
LEFT JOIN Projects
ON AssignedTo.Project = Projects.Code) as x 
LEFT JOIN Scientists 
ON Scientists.SSN = x.Scientist;

-- https://en.wikibooks.org/wiki/SQL_Exercises/Scientists
-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.
SELECT Scientists.Name as Name_of_Scientist , x.Scientist as id_num , x.Project as project_id , x.Name as project_name , x.Hours 
FROM (SELECT AssignedTo.Scientist , AssignedTo.Project , Projects.Name , Projects.Hours
FROM AssignedTo 
LEFT JOIN Projects
ON AssignedTo.Project = Projects.Code) as x 
LEFT JOIN Scientists 
ON Scientists.SSN = x.Scientist
ORDER BY x.Name , Scientists.Name;

# Answer which is simpler 
-- SELECT   S.Name, P.Name, P.Hours
-- FROM     Scientists S 
--          INNER JOIN AssignedTo A ON S.SSN=A.Scientist
--          INNER JOIN Projects P ON A.Project=P.Code
-- ORDER BY P.Name ASC, S.Name ASC;

-- 6.2 Select the project names which are not assigned yet
SELECT Name
FROM Projects
LEFT JOIN AssignedTo
ON Projects.Code = AssignedTo.Project
WHERE Scientist IS Null  ;

# Another Solution 
SELECT Name 
FROM Projects
WHERE Code NOT In
(
SELECT Project 
         FROM AssignedTo
);
