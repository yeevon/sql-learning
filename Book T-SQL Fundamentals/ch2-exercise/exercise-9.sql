USE TSQLV6;

-- Using the HR.Employees table, write a SELECT statement that returns for each employee 
-- the gender based on the title of courtesy. For 'Ms.' and 'Mrs.' return 'Female'; for 
-- 'Mr.' return 'Male'; and in all other cases (for example, 'Dr.') return 'Unknown':

SELECT empid, firstname, lastname, titleofcourtesy,
	CASE titleofcourtesy
		WHEN 'Mr.'  THEN 'Male'
		WHEN 'Mrs.' THEN 'Female'
		WHEN 'Ms.'	THEN 'Female'
		ELSE 'Unknown'
	END AS gender
FROM HR.Employees;