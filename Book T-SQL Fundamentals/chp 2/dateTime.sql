-- no datetime literals use string and covert to datetime
-- implicit conversion
SELECT orderid, custid, orderdate
FROM Sales.Orders
WHERE orderdate = '20220212';

-- explicit conversion
SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE orderdate = CAST('20220212' AS DATE);

-- Function				Return type			Description
---------------------------------------------------------------------------
-- GETDATE				DATETIME			Current date and time 
-- CURRENT_TIMESTAMP	DATETIME			Same as GETDATE but SQL-compliant
-- GETUTCDATE			DATETIME			Current date and time in UTC
-- SYSDATETIME			DATETIME2			Current date and time
-- SYSUTCDATETIME		DATETIME2			Current date and time in UTC
-- SYSDATETIMEOFFSET	DATETIMEOFFSET		Current date and time, including the offset from UTC

-- reserved keywords need to use [] if setting the as column name
SELECT 
	GETDATE() AS[GETDATE],
	CURRENT_TIMESTAMP AS[CURRENT_TIMESTAMP],
	GETUTCDATE() AS[GETUTCDATE],
	SYSDATETIME() AS[SYSDATETIME],
	SYSUTCDATETIME() AS[SYSUTCDATETIME],
	SYSDATETIMEOFFSET() AS[SYSDATETIMEOFFSET];

-- Get only date or only time
SELECT
	CAST(SYSDATETIME() AS DATE) AS[current_date],
	CAST(SYSDATETIME() AS TIME) AS[current_time];

-- cast, convert and parse functions w/ counterparts
-- CAST(value AS datatype) | TRY_CAST(value AS datatype)
-- CONVERT(datatype, value[,style_number]) | TRY_CONVERT(datatype, value[,style_number])
-- PARSE(value AS datatype[USING culture]) | TRY_PARSE(value AS datatype[USING culture])

