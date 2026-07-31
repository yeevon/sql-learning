USE TSQLV6;

-- EXPECT INVALID COLUMN ERROR ORDERYEAR
SELECT 
	orderid,
	YEAR(orderdate) AS orderyear,
	orderyear + 1 AS nextyear
FROM Sales.Orders;

