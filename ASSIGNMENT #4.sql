-- **************************
-- INFT1105 - Assignment 4
-- revised Fall 2023

-- Student Name: Navjot Singh
-- Student ID: 100931376
-- Date: April 12, 2024
-- **************************

/*
Please complete the following question in the spaces provided.  Your professor will run your entire script at once while testing/marking it.  Make sure your code is executable and that all comments aree commented appropriately.
*/

USE EmployeeSample;

-----------------------------------------------------------------
-- Question 1
-- Using sub-queries, display the full name of the lowest paid employee(s).  Use only Salary!

SELECT FirstName + ' ' + LastName AS FullName
FROM Employees
WHERE Salary = (
    SELECT MIN(Salary)
    FROM Employees
);


-----------------------------------------------------------------
-- Question 2
-- Display the city that the lowest salary employee(s) are located in.

-- hint 1: you can use both JOINs and sub-queries or just sub-queries

SELECT DISTINCT L.city
FROM LOCATIONS L
JOIN DEPARTMENTS D ON L.locationID = D.locationID
JOIN EMPLOYEES E ON D.departmentID = E.departmentID
WHERE E.salary = (
    SELECT MIN(salary)
    FROM EMPLOYEES
);
 
-----------------------------------------------------------------
-- Question 3
-- Display the last name of the lowest paid employee(s) in each department
-- hint: you can use both JOINs and sub-queries or just sub-queries

 SELECT E.lastName, E.departmentID AS departmentID
FROM EMPLOYEES E
JOIN (
    SELECT departmentID, MIN(salary) AS min_salary
    FROM EMPLOYEES
    GROUP BY departmentID
) AS MinSalaries ON E.departmentID = MinSalaries.departmentID AND E.salary = MinSalaries.min_salary;

-----------------------------------------------------------------
-- Question 4
-- Display last name and salary for all employees who earn less than the 
-- lowest salary in ANY department.  
-- Sort the output by top salaries first and then by last name.
-- DO NOT use JOIN
-- hint: there is an ANY() function that is similar to IN()

SELECT lastName, salary
FROM EMPLOYEES
WHERE salary < ANY (
    SELECT MIN(salary)
    FROM EMPLOYEES
    GROUP BY departmentID
)
ORDER BY salary DESC, lastName;

-- -------------------------------------
-- Question 5 A
-- The HR department needs a list of Department IDs for departments that do not 
-- contain the job ID of ST_CLERK.  Use a set operator to create this report.
-- DO NOT use JOIN

SELECT DISTINCT departmentID As Department
FROM EMPLOYEES
WHERE departmentID NOT IN (
    SELECT departmentID
    FROM EMPLOYEES
    WHERE jobTitle = 'ST_CLERK'
);

-- -------------------------------------
-- Question 5 B
-- Repeat Question 5, but also show the department name. Sort the output by department name. 
-- DO NOT use JOINs
-- Hint: a sub-query will work nicely...
-- Question 5 B
-- Repeat Question 5, but also show the department name. Sort the output by department name. 
-- DO NOT use JOINs
-- Hint: a sub-query will work nicely...

SELECT 
    d.departmentID AS department_id,
    d.departmentName AS departmentName
FROM 
    departments d
WHERE 
    d.departmentID NOT IN (
        -- Sub-query to find departments with 'ST_CLERK' job IDs
        SELECT 
            distinct e.departmentid 
        FROM 
            employees e
        WHERE 
            e.jobTitle = 'ST_CLERK'
    )
ORDER BY 
    d.departmentName;

-- -------------------------------------
-- Question 6
-- The Vice President needs a list of job titles in departments 10, 50, 20 in that order. 
-- (i.e. all titles from 10 first, then titles from 50, then titles from 20)
-- job title and department ID are to be displayed.

SELECT jobTitle, departmentID AS DepartmentID
FROM EMPLOYEES
WHERE departmentID IN (10, 50, 20)
ORDER BY CASE departmentID
    WHEN 10 THEN 1
    WHEN 50 THEN 2
    WHEN 20 THEN 3
END, jobTitle;

-- ----------------------------------------
-- Question 7
-- Write a non-saved procedure that declares an integer number and prints
-- "The number is even" is shown if a number is divisible by 2.
-- Otherwise, it prints "The number is odd".

BEGIN
    DECLARE @num INT;
    SET @num = 12;

    IF @num % 2 = 0 
        PRINT 'The number is even';
    ELSE
        PRINT 'The number is odd';
END;
GO

-- -------------------------------
-- Question 8
/*	Write a user-defined function, called funcSpecialFactorial, that gets an 
	integer number n and calculates and returns its factorial.  

	Example:
	0! = 1
	2! = fact(2) = 2 * 1 = 2
	3! = fact(3) = 3 * 2 * 1 = 6
	. . .
	n! = fact(n) = n * (n-1) * (n-2) * . . . * 1

	Create a non-saved procedure that executes the above function and outputs the 
	result for 3 different input values.
*/

 IF OBJECT_ID('dbo.funcSpecialFactorial', 'FN') IS NOT NULL
    DROP FUNCTION dbo.funcSpecialFactorial;
GO

CREATE FUNCTION dbo.funcSpecialFactorial(@n INT) RETURNS INT
AS
BEGIN
    DECLARE @result INT = 1;
    
    -- Checking if n is 0 or 1, return 1
    IF @n = 0 OR @n = 1
        RETURN 1;
    
    -- Calculating factorial for n > 1
    WHILE @n > 1
    BEGIN
        SET @result = @result * @n;
        SET @n = @n - 1;
    END

    RETURN @result;
END;
GO








