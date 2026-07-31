--Get set of supported collations
SELECT name, description
FROM sys.fn_helpcollations();


USE TSQLV6;


-- case insensitive filtering, env is case insensitive
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname = N'davis';

-- force case sensitivity, will return nothing
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS = N'davis'

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS = N'Davis'


-- string concantenation
SELECT	empid, firstname + N' ' + lastname AS fullname
FROM HR.Employees;

-- CONCANTENATION WITH NULL
SELECT custid, country, region, city,
	country +N',' + region + N',' + city as location
FROM Sales.Customers;

-- CHANGE NULL TO EMPTY STRING
SELECT custid, country, region, city,
	country + COALESCE(N',' + region, N'') + N','+ city AS location
FROM Sales.Customers;

-- BETTER CONCANTENATION AND ALREADY HANDLES NULLS
SELECT custid, country, region, city,
	CONCAT_WS(N',',country, region,city) AS location
FROM Sales.Customers;

-- substring -- just some quick ref.

	--SUBSTRING(string, start, length)
	--LEFT(string, n)
	--RIGHT(string, n)
	--LEN(string) # num of charachters
	--DATALENGHT(string) # num of bytes
	--CHARINDEX(substring,string[,start_pos]) # first occurance of substring
	--PATINDEX(pattern,string) # first occurance of pattern ex.,
		SELECT PATINDEX('%[0-9]%','abcd123efgh');
	--REPLACE(STRING,SUBSTRING1,SUBSTRING2)
	--TRANSLATE(string,characters,translations) # more flexible replace ex.,
		SELECT REPLACE(REPLACE(REPLACE('123.456.789,00', '.', '~'), ',', '.'), '~', ',');
		--or
		SELECT TRANSLATE('123.456.789,00', '.,', ',.');
	--REPLICATE(string,n) # ex.,
		SELECT REPLICATe('abc',3);
		SELECT supplierid,
		  RIGHT(REPLICATE('0', 9) + CAST(supplierid AS VARCHAR(10)), 10) AS strsupplierid
		FROM Production.Suppliers;