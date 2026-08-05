USE TSQLV6;

-- Write a query against the Sales.Customers table that returns for each customer the
-- customer ID and region. Sort the rows in the output by region, ascending, having 
-- NULLs sort last (after non-NULL values). Note that the default sort behavior for NULLs 
-- in T-SQL is to sort first (before non-NULL values):

SELECT custid, region
FROM Sales.Customers
ORDER BY 
	CASE 
		WHEN region IS NULL THEN 1 
		ELSE 0
	END,
	region ASC;