USE TSQLV6;

DROP TABLE IF EXISTS dbo.Employees;

CREATE TABLE dbo.Employees
(
	empid		INT			NOT NULL,
	firstname	VARCHAR(30)	NOT NULL,
	lastnamee	VARCHAR(30)	NOT NULL,
	hiredate	DATE		NOT NULL,
	mgrid		INT			NULL,
	ssn			VARCHAR(20)	NOT NULL,
	salary		MONEY		NOT NULL
);