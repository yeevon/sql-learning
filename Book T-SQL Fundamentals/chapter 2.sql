
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

SELECT TOP(5) orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;

SELECT TOP (1) PERCENT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;

SELECT TOP(5) orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC, orderid DESC;


SELECT TOP(5) WITH TIES orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate, orderid
OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY;

SELECT orderid, custid, val,
	ROW_NUMBER() OVER(PARTITION BY custid
		ORDER BY val) AS rownum
FROM Sales.OrderValues
ORDER BY custid, val;