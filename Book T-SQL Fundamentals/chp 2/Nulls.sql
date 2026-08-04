USE TSQLV6;

SELECT custid, country, region, city
FROM Sales.Customers
WHERE region = N'WA';

SELECT custid, country, region, city
FROM Sales.Customers
WHERE region IS NOT DISTINCT FROM N'WA';

SELECT custid, country, region, city
FROM Sales.Customers
WHERE region <> N'WA';

-- Bad query
SELECT custid, country, region, city
FROM Sales.Customers
WHERE region = NULL;

-- Good query
SELECT custid, country, region, city
FROM Sales.CUSTOMERS	
WHERE region IS NULL;

SELECT custid, country, region, city
FROM Sales.Customers
WHERE region <> N'WA'
	OR region IS NULL;

SELECT custid, country, region, city
FROM Sales.Customers
WHERE region IS DISTINCT FROM N'WA';