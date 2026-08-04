-- Explain the difference between the following two queries:

-- Query 1
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
WHERE orderdate < '20220501'
GROUP BY empid;

-- Query 2
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20220501';


-- Query 1 filters orderdate first then groups the empid
-- Query 2 groups all the empid then filters the on the greatest orderdate