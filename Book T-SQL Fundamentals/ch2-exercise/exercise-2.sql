-- Write a query against the Sales.Orders table that returns orders placed on the day before the last day of the month:

USE TSQLV6;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = DATEADD(day, -1, EOMONTH(orderdate));