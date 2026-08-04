-- query against Sales.Orders table returns orders placed in June 2021

USE TSQLV6;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate LIKE '2021-06-%';
