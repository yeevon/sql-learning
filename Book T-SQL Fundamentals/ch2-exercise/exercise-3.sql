-- Write a query against the HR.Employees table that returns employees with a last name containing the letter e twice or more:

USE TSQLV6;

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE LEN(lastname) - LEN(REPLACE(lastname, 'e', '')) >= 2;