/* Name: Navjot singh
   Date: March 30,2024
   Course: Introduction To Dtabases */


/* 1. For each employee hired before 2014, show the employee's last name, hire date, and 
calculate the number of full years the employee has worked at the company. Do not round the answer (like 11.99 is not yet 12), 
it should be full years.Label the column YearsWorked and order the results by the number of years employed. 
(No subquery or join needed) Hint: maybe use DATEDIFF() function :) */

SELECT 
    lastName,
    hireDate,
    DATEDIFF(YEAR, hireDate, GETDATE()) AS YearsWorked
FROM 
    employees
WHERE 
    YEAR(hireDate) < 2014
ORDER BY 
    YearsWorked;


/* 2. Using Sub-Queries and Grouping. Display the full name, Department Name, and salary for the lowest paid (by salary only) 
employee in each department.  Note: Double check your output as it might not be as you expect! */

SELECT 
    e.firstName + ' ' + e.lastName AS FullName,
    d.departmentName,
    e.salary
FROM 
    employees e
JOIN 
    departments d ON e.departmentID = d.departmentID
JOIN (
    SELECT 
        departmentID,
        MIN(salary) AS minSalary
    FROM 
        employees
    GROUP BY 
        departmentID
) AS minSalaries ON e.departmentID = minSalaries.departmentID AND e.salary = minSalaries.minSalary
ORDER BY 
    d.departmentName;