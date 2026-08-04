-- Write a query against the Sales.Orders table that returns the three shipped-to 
-- countries with the highest average freight for orders placed in 2021:

USE TSQLV6;

SELECT TOP(3) shipcountry, AVG(freight) AS avgfreight 
FROM Sales.Orders
WHERE DATEPART(year, orderdate) = 2021
GROUP BY shipcountry
ORDER BY avgfreight DESC;