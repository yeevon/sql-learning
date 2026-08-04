-- Write a query against the Sales.Orders table that calculates row numbers 
-- for orders based on order date ordering (using the order ID as the 
-- tiebreaker) for each customer separately:

USE TSQLV6;

SELECT custid, orderdate, orderid, 
	ROW_NUMBER() OVER(
		PARTITION BY custid ORDER BY orderdate, orderid
	) AS rownum
FROM Sales.Orders;