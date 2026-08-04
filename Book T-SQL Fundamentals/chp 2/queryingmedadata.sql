-- Querying metadata

-- Catalog views

-- list the tables in a database along with their schema names
USE TSQLV6;

SELECT SCHEMA_NAME(schema_id) AS table_schema_name, name AS table_name
FROM sys.tables;

-- get info about columns in a table ex. clumns in Sales.Orders table
SELECT
	name AS column_name,
	TYPE_NAME(system_type_id) AS column_type,
	max_length,
	collation_name,
	is_nullable
	FROM sys.columns
	WHERE object_id = OBJECT_ID(N'Sales.Orders');

-- Information schema views

-- query against INFORMATION_SCHEMA.TABLES to get base tables in current db and their schema names
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = N'BASE TABLE';

-- query against INFORMATION_SCHEMA.COLUMNS view to get info about columns in Sales.Orders table
SELECT
	COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH,
	COLLATION_NAME, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = N'Sales'
	AND TABLE_NAME = N'Orders';


-- system stored procedures and functions

-- sp_tables sp returns a list of objects that can be quiried
EXEC sys.sp_tables;

-- sp_help prcedure accepts an objes name as input and returns multiple results sets with general info
-- about the object
EXEC sys.sp_help
	@objname = N'Sales.Orders';


-- sp_columns procedure returns info about columns in an object
EXEC sys.sp_columns
	@table_name=N'Orders',
	@table_owner=N'Sales';


-- sp_helpconstraint procedure returns info aobut constraints in an object
EXEC sys.sp_helpconstraint
	@objname=N'Sales.Orders';


-- SERVERPROPRERTY function returns the requested property of the current instance
SELECT
	SERVERPROPERTY('Collation');


-- DATABASEPROPERTYEX function returns the requested property of the specified db name
SELECT
	DATABASEPROPERTYEX(N'TSQLV6','Collation');


-- OBJECTPROPERTY function returns the requested property of the specified object name
SELECT
	OBJECTPROPERTY(OBJECT_ID(N'Sales.Orders'),'TableHasPrimaryKey');


-- COLUMNPROPERTY function returns the requested property of a specified column.
SELECT
	COLUMNPROPERTY(OBJECT_ID(N'Sales.Orders'),N'shipcountry','AllowsNull');