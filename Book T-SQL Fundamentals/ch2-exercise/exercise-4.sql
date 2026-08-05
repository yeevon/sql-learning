-- Write a query against the Sales.OrderDetails table that returns orders with a 
-- total value (quantity * unitprice) greater than 10,000, sorted by total value, descending:

USE TSQLV6;

SELECT orderid, SUM(qty * unitprice) AS totalvalue
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty * unitprice) > 10000
ORDER BY totalvalue DESC;