
SELECT  empid, 
YEAR(orderdate) AS orderyear, 
SUM(freight) AS totalfreight,
COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate)
HAVING COUNT(*) > 1
ORDER BY empid, orderyear;

SELECT empid, 
YEAR(orderdate) AS orderyear,
COUNT(DISTINCT custid) AS numcusts
FROM Sales.Orders
GROUP BY empid, YEAR(orderdate)

SELECT DISTINCT empid, YEAR(orderdate) AS orderyear
FROM Sales.Orders
WHERE custid=71;

SELECT orderid,
YEAR(ORDERDATE) AS orderyear,
YEAR(orderdate) + 1 AS nextyear
FROM Sales.Orders;


SELECT empid, firstname, lastname, country
FROM HR.Employees
ORDER BY hiredate;



