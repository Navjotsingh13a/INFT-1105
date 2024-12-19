/* GROUP members: Navjot Singh, Ashok Raj Sapkota,
                  Anjal Kafle and Sarbhjodh Singh Baweja */

/* Date: April 12, 2024 */

/* 1) Use the below tables (below) "Salesperson" and "Orders" to write this query. Show all orders issued by the sales person 'Paul Adam'.
Display ord_no, purch_amt, ord_date, customer_id, and salesman_id. Hint: Use a subquery. */

SELECT *
FROM orders
WHERE salesman_id =
    (SELECT salesman_id 
     FROM salesman 
     WHERE name='Paul Adam');

/* 2) Create a custom function that can be created or altered, it will accept 2 parameters for a temperature and a character (C/F) and
will return a decimal (the converted temperature). Use a decision structure to convert the temperature to Celsius or Fahrenheit,
depending on the character inputted. Don't worry about checking for errors for invalid input. Once complete, execute the function then create
two  simple selects to run the function and pass a values (1 for C and 1 for F) for testing. Provide screen shots of the successful results
for both Celsius and Fahrenheit. */

CREATE OR ALTER FUNCTION ConvertTemp (@temp DECIMAL, @Degree CHAR(1)) 
RETURNS DECIMAL 
AS
BEGIN
    DECLARE @Result DECIMAL;

    IF UPPER(@Degree) = 'C'
    BEGIN
        SET @Result = (@temp * 9/5) + 32;
    END
    ELSE IF UPPER(@Degree) = 'F'
    BEGIN
        SET @Result = (@temp -32) ;
    END

    RETURN @Result;
END;

SELECT dbo.ConvertTemp(58, 'f') AS C;

SELECT dbo.ConvertTemp(14, 'c') AS F;


/* 3) Using the Employees database, Insert a new country (when executing the stored procedure pick any country not already there).
Create a stored procedure called spCountriesCreate that accepts a CountryID, CountryName, and RegionID (for RegionID use 3 when testing)
as parameters and inserts the new record into the 'countries' table. Declare the integer variable @numRows and the VARCHAR variable @output.*/

CREATE PROCEDURE spCountryCreate
    @countryCode CHAR(2),
    @countryName VARCHAR(40),
    @regionID INT
AS
BEGIN
    DECLARE @numRows INT = 0;
    DECLARE @output VARCHAR(100) = '';

    BEGIN TRY
		INSERT INTO countries VALUES (@countryCode, @countryName, @regionID);
		SET @numRows = (SELECT @@ROWCOUNT);

		SET @output = (
			CASE @numRows
				WHEN 1 THEN 'Insert Successful!'
				WHEN 0 THEN 'Insert Failed'
				ELSE 'Something funky going on...'
			END);
    END TRY
    BEGIN CATCH
        SET @output = 'An error occurred while trying to insert the record';
    END CATCH

    PRINT 'Output: ' + @output;
END;

/* Create the execution code to execution the stored procedure and pass the country ID, the country name, and the region ID.*/

BEGIN
	EXEC spCountryCreate
		@countryCode = 'GG',
		@countryName = 'TestCountry',
		@regionID = 2;

		PRINT 'Output: ' + @output;

END
