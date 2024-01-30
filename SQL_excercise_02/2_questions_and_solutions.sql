SHOW Databases;

use SQL_Exercise; -- Have to runn everytime opening the file

Show tables;

-- SCHEMA BUILDING -- Add the code to buid Schema once 

SHOW tables;

-- Tables Departments / Employees 

-- QUESTIONS AND ANSWERS

-- 2.1 Select the last name of all employees.
SELECT name FROM Employees;

-- 2.2 Select the last name of all employees, without duplicates.
SELECT distinct LastName FROM Employees;

-- 2.3 Select all the data of employees whose last name is "Smith".
SELECT * FROM Employees WHERE LastName = 'Smith';

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
SELECT * FROM Employees WHERE LastName = 'Smith' OR LastName = 'Doe';

# Another way using in keyword here in a () anything from a list of options // Used when many options to select
SELECT * FROM Employees
  WHERE LastName IN ('Smith' , 'Doe');


-- 2.5 Select all the data of employees that work in department 14.
SELECT * FROM Employees WHERE Department = 14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.
SELECT * FROM Employees WHERE Department = 37 OR Department = 77;

# Using In operator
SELECT * FROM Employees
  WHERE Department IN (37,77);


-- 2.7 Select all the data of employees whose last name begins with an "S".
SELECT * FROM Employees WHERE LastName LIKE 'S%';

-- 2.8 Select the sum of all the departments' budgets.
SELECT SUM(Budget) FROM Departments;

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
SELECT Department , COUNT(*) FROM Employees 
GROUP BY department ;

-- 2.10 Select all the data of employees, including each employee's department's data.
SELECT * FROM Employees E
INNER JOIN Departments D
ON E.Department = D.code;

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
SELECT E.name ,  LastName , D.Name AS DepartmentsName , Budget
FROM Employees E
INNER JOIN Departments D
ON E.Department = D.code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT E.name ,  LastName 
FROM Employees E
INNER JOIN Departments D
ON E.Department = D.code
WHERE budget > 60000;

# Using Subquery 
SELECT Name, LastName FROM Employees
  WHERE Department IN
  (SELECT Code FROM Departments WHERE Budget > 60000);

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
SELECT * FROM departments 
    WHERE budget > (SELECT AVG(budget) FROM Departments) ; 
    
-- 2.14 Select the names of departments with more than two employees.
/* With IN and subquery */
SELECT name FROM departments 
WHERE code IN  (
    SELECT Department
      FROM Employees
      GROUP BY Department
      HAVING COUNT(*) > 2
  );
/* With UNION. This assumes that no two departments have
   the same name */
SELECT Departments.Name
  FROM Employees INNER JOIN Departments
  ON Department = Code
  GROUP BY Departments.Name
  HAVING COUNT(*) > 2;
  
  SELECT D.Name FROM Departments D
  WHERE 2 < 
  (
   SELECT COUNT(*) 
     FROM Employees
     WHERE Department = D.Code
  );



-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
-- 2.17 Reduce the budget of all departments by 10%.
-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
-- 2.19 Delete from the table all employees in the IT department (code 14).
-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
-- 2.21 Delete from the table all employees.