/*
Group member names:Navjot Singh and Kabin Kunwar
Date: 16 Feb 2024
Prof: Jennifer Short
Course: INFT1105 - Introduction to Databases
Purpose: Assignment 2
*/

USE employeeSample;
GO

/* Question 1
If the following SELECT statement does NOT execute successfully, why and how would you 
fix it (Answer in words in commented text) and then actually correct the statement (not commented)
*/

SELECT lastName,jobTitle, hireDate
FROM employees
ORDER BY jobTitle



-- ********************************************************************************

/* Question 2
Display the employeeid, last name and salary of employees earning in the range of $$90,000 to $130,000 inclusively.  
Sort the output by top salaries first and then by last name.
*/
SELECT 
    employeeid,
    lastName,
    salary
FROM employees
WHERE salary BETWEEN 90000 AND 130000
ORDER BY salary DESC, lastName;


/* Question 3
Write the solution for question 2 again but change the salary from annual to a weekly salary.  Make the output formatted like currency.
(i.e. a $ is shown, commas separating every 3 digits, and exactly 2 decimal places.)
NOTE: There is NOT exactly 52 in a year, so dividing by 52 is not good enough.  
It is okay to assume it is NOT a leap year.
*/
SELECT 
    employeeid,
    lastName,
    FORMAT(salary / 52, 'C', 'en-US') AS weekly_salary
FROM employees
WHERE salary BETWEEN 90000 AND 130000
ORDER BY salary DESC, lastName;


/* Question 4
Display the job titles and full names of employees whose first name contains an ‘e’ or ‘E’ anywhere. 
*/
SELECT 
    jobTitle,
    CONCAT(firstName, ' ', lastName) AS fullName
FROM employees
WHERE firstName LIKE '%e%' OR firstName LIKE '%E%';
   
   

/* Question 5
Create a query to display the address of the Toronto office. Display the 
street address, city, state/province, postal code, and country ID.
*/ 
SELECT 
      streetAddress, city, stateProv, postalcode, countryID
FROM locations
WHERE city = 'Toronto';
	
	

/*  Question 6
For each employee in departments 20, 50 and 60 display last name, 
first name, department name, salary, and salary increased by 4% and 
expressed as a whole number.  Label the increased salary column 
"NewSalary".  Also add a column that subtracts the old salary from the new
salary and displays the difference. Label the column "AnnualPayIncrease".
Sort the output first by department name, then by employee lastname.
*/
SELECT 
    lastName,
    firstName,
    departmentName AS "Department Name",
    salary,
    CAST(salary * 1.04 AS DECIMAL(10, 2)) AS "NewSalary",
    CAST((salary * 1.04 - salary) AS DECIMAL(10, 2)) AS "AnnualPayIncrease"
FROM employees
JOIN departments ON employees.departmentID = departments.departmentID
WHERE employees.departmentID IN (20, 50, 60)
ORDER BY departmentName, lastName;

    
	

/* Question 7
For each employee hired before 2014, display the employee’s last name, 
hire date and calculate the number of FULL years the employee has worked at the company.
Do not round the answer, as 11.99 is not 12 yet, it should be 11 full years.
    a.	Label the column Years worked. 
    b.	Order your results by the number of years employed.  
*/
SELECT lastName, hireDate, DATEDIFF(YEAR, hireDate, GETDATE()) AS YearsWorked
FROM employees
WHERE hireDate < '2014-01-01'
ORDER BY YearsWorked