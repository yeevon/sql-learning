-- STUFF(string, pos, delete_length, insert_string)

USE TSQLV6;

-- Removes the y and inserts abc
SELECT STUFF('xyz', 2, 1, 'abc');

-- UPPER(string) | LOWER(string)

SELECT UPPER('Itzik Ben-Gan');
SELECT LOWER('Itzik Ben-Gan');

-- RTRIM(string | LTRIM(string): right left trim

SELECT RTRIM('   abc   ');
SELECT LTRIM('   abc   ');

-- Just trim
SELECT TRIM('   abc   ');


-- TRIM specific characters
SELECT TRIM('/\'
	FROM '//\\ remove leading and trailing backward(\) and forward(/) slashes \\//')
AS outputstring;

-- Instead of RTRIM and LTRIM: TRIM( [ LEADING | TRAILING | BOTH ] [ characters FROM ] string ) both version are valid

-- FORMAT(input, format_string, culture) easier formatting higher performance cost
SELECT FORMAT(1759, '0000000000');
SELECT FORMAT(11111759, 'd10');

-- COMPRESS(string) | DECOMPRESS(string) use GZIP algorithm
-- DON'T RUN
SELECT COMPRESS(N'This is my cv. Imagine it was much longer.');

-- SELECT CAST(DECOMPRESS(cv) AS NVARCHAR(MAX)) AS cv
-- FROM dbo.EmployeeCVs;

-- String split function
-- SELECT value FROM STRING_SPLIT(string, separator[,enable_ordinal]);
SELECT CAST(value AS INT) AS myvalue
FROM STRING_SPLIT('10248,10249,10250',',') AS S;

-- String_agg function
-- STRING_AGG(input, separator)[WITHIN GROUP(order_specfication)]
SELECT custid,
	STRING_AGG(CAST(orderid AS VARCHAR(10)),',')
	 WITHIN GROUP(ORDER BY orderdate DESC, orderid DESC) AS custorders
FROM sales.Orders
GROUP BY custid;