USE TSQLV6;

SELECT orderid, requireddate, shippeddate,
	GREATEST(requireddate, shippeddate) AS latestdate,
	LEAST(requireddate, shippeddate) AS earliestdate
FROM Sales.Orders
WHERE custid=8;

-- SAME THING USING CASE
SELECT orderid, requireddate, shippeddate,
	CASE
		WHEN requireddate > shippeddate OR shippeddate IS NULL THEN requireddate
		ELSE shippeddate
	END AS latestdate,
	CASE	
		WHEN requireddate < shippeddate OR shippeddate IS NULL THEN requireddate
		ELSE shippeddate
	END AS earliestdate
FROM Sales.ORDERS
WHERE custid=8;