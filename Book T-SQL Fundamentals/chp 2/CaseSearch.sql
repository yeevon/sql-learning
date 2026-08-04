USE TSQLV6;

SELECT supplierid, COUNT(*) AS numproducts,
CASE COUNT(*) % 2
	WHEN 0 THEN 'Even'
	WHEN 1 THEN 'Odd'
	ELSE 'Unknown'
	END AS countparity
FROM Production.Products
GROUP BY supplierid;

SELECT orderid, custid, val,
	CASE
		WHEN val < 1000.00 THEN 'Less than 1000'
		WHEN val <= 3000.00 THEN 'Between 1000 and 3000'
		WHEN val > 3000.00 THEN 'More than 3000'
		ELSE 'Unknown'
	END AS valuecategory
FROM Sales.OrderValues;