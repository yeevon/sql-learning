USE TSQLV6;


EXEC sys.sp_rename
	'dbo.Orders.oderts',
	'orderts',
	'COLUMN';


ALTER TABLE dbo.Orders
	ADD CONSTRAINT DFT_Orders_orderts
	DEFAULT(SYSDATETIME()) FOR orderts;

DROP TABLE IF EXISTS dbo.Orders, dbo.Employees;
