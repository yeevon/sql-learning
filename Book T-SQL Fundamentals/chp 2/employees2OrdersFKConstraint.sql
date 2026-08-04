USE TSQLV6;

ALTER TABLE dbo.Orders
	ADD CONSTRAINT FK_Orders_Employees
	FOREIGN KEY(empid)
	REFERENCES dbo.Employees(empid);