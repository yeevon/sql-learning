# T-SQL Cheat Sheet: Chapter 2

## Table Creation & Constraints

```sql
CREATE TABLE dbo.Employees
(
    empid     INT         NOT NULL,
    firstname VARCHAR(30) NOT NULL,
    lastname  VARCHAR(30) NOT NULL,
    hiredate  DATE        NOT NULL,
    mgrid     INT         NULL,
    ssn       VARCHAR(20) NOT NULL,
    salary    MONEY       NOT NULL
);
```

- Inline PK: `CONSTRAINT PK_Orders PRIMARY KEY(orderid)` inside `CREATE TABLE`.
- Add PK after the fact: `ALTER TABLE dbo.Employees ADD CONSTRAINT PK_Employees PRIMARY KEY(empid);`
- Unique constraint: `ALTER TABLE dbo.Employees ADD CONSTRAINT UNQ_Employees_ssn UNIQUE(ssn);`
- Allow multiple NULLs but enforce uniqueness on non-NULLs (filtered unique index):
  ```sql
  CREATE UNIQUE INDEX idx_ssn_notnull ON dbo.Employees(ssn)
      WHERE ssn IS NOT NULL;
  ```
- Foreign key:
  ```sql
  ALTER TABLE dbo.Orders
      ADD CONSTRAINT FK_Orders_Employees
      FOREIGN KEY(empid)
      REFERENCES dbo.Employees(empid);
  ```
- Check constraint: `ALTER TABLE dbo.Employees ADD CONSTRAINT CHK_Employees_Salary CHECK(salary > 0.00);`
- Default constraint: `ALTER TABLE dbo.Orders ADD CONSTRAINT DFT_Orders_orderts DEFAULT(SYSDATETIME()) FOR orderts;`
- Rename a column: `EXEC sys.sp_rename 'dbo.Orders.oderts', 'orderts', 'COLUMN';`
- Drop table(s) if they exist: `DROP TABLE IF EXISTS dbo.Orders, dbo.Employees;`

## SELECT Query Elements & Order

Logical processing order (not written order): `FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY`

```sql
SELECT empid,
    YEAR(orderdate) AS orderyear,
    SUM(freight) AS totalfreight,
    COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate)
HAVING COUNT(*) > 1
ORDER BY empid, orderyear;
```

- `COUNT(DISTINCT custid)` counts unique non-NULL values.
- `SELECT DISTINCT` removes duplicate rows from the result.
- Column aliases defined in `SELECT` (e.g. `orderyear`) **cannot** be reused elsewhere in the same `SELECT` list (e.g. `orderyear + 1`) because all expressions in `SELECT` are logically evaluated at the same phase — causes an "invalid column name" error.

### TOP / OFFSET-FETCH

```sql
-- top N rows
SELECT TOP(5) orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;

-- top percent
SELECT TOP(1) PERCENT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;

-- include ties for the last spot
SELECT TOP(5) WITH TIES orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;

-- paging (standard, requires ORDER BY)
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate, orderid
OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY;
```

- `TOP` without a tiebreaker in `ORDER BY` is nondeterministic when there are ties — add more columns to `ORDER BY` to break ties (e.g. `ORDER BY orderdate DESC, orderid DESC`).

### Window function preview

```sql
SELECT orderid, custid, val,
    ROW_NUMBER() OVER(PARTITION BY custid ORDER BY val) AS rownum
FROM Sales.OrderValues
ORDER BY custid, val;
```

## Predicates & Operators

```sql
WHERE orderid IN (10248, 10249, 10250)
WHERE orderid BETWEEN 10300 AND 10310
WHERE lastname LIKE N'D%'
WHERE orderdate >= '20220101' AND empid NOT IN (1, 3, 5)
```

- `AND` has higher precedence than `OR` — use parentheses to make intent explicit:
  ```sql
  WHERE (custid = 1 AND empid IN (1,3,5))
     OR (custid = 85 AND empid IN (2,4,6));
  ```

### LIKE Wildcards

| Wildcard | Meaning |
|---|---|
| `%` | any string, any length (including zero) |
| `_` | exactly one character |
| `[list]` | any single character in the list, e.g. `[DFK]` |
| `[a-e]` | any single character in the range |
| `[^list or range]` | any single character **not** in the list/range |

```sql
WHERE lastname LIKE N'_e%'      -- 2nd char is 'e'
WHERE lastname LIKE N'[DFK]%'   -- starts with D, F, or K
WHERE lastname LIKE N'[A-E]%'   -- starts with A through E
WHERE lastname LIKE N'[^A-E]%'  -- does NOT start with A through E
```

- Escaping a literal wildcard character: `col1 LIKE '%!_%' ESCAPE '!'` or `col1 LIKE '%[_]%'`.

## NULLs (Three-Valued Logic)

- `NULL` means "missing/unknown" — comparisons against `NULL` with `=` or `<>` return `UNKNOWN`, never `TRUE`.
- Use `IS NULL` / `IS NOT NULL`, never `= NULL`.
  ```sql
  -- Bad: matches nothing, always UNKNOWN
  WHERE region = NULL;

  -- Good
  WHERE region IS NULL;
  ```
- To exclude NULLs explicitly when negating: `WHERE region <> N'WA' OR region IS NULL;`
- `IS [NOT] DISTINCT FROM` compares treating NULL as a known value (NULL-safe equality) so it never returns UNKNOWN:
  ```sql
  WHERE region IS NOT DISTINCT FROM N'WA';  -- true when region is NULL and compared to NULL
  WHERE region IS DISTINCT FROM N'WA';
  ```

## CASE Expressions

```sql
-- simple CASE
SELECT supplierid, COUNT(*) AS numproducts,
    CASE COUNT(*) % 2
        WHEN 0 THEN 'Even'
        WHEN 1 THEN 'Odd'
        ELSE 'Unknown'
    END AS countparity
FROM Production.Products
GROUP BY supplierid;

-- searched CASE
SELECT orderid, custid, val,
    CASE
        WHEN val < 1000.00 THEN 'Less than 1000'
        WHEN val <= 3000.00 THEN 'Between 1000 and 3000'
        WHEN val > 3000.00 THEN 'More than 3000'
        ELSE 'Unknown'
    END AS valuecategory
FROM Sales.OrderValues;
```

## GREATEST / LEAST

```sql
SELECT orderid, requireddate, shippeddate,
    GREATEST(requireddate, shippeddate) AS latestdate,
    LEAST(requireddate, shippeddate) AS earliestdate
FROM Sales.Orders
WHERE custid = 8;
```

Equivalent with `CASE` (need to handle NULL explicitly, unlike `GREATEST`/`LEAST`):

```sql
CASE
    WHEN requireddate > shippeddate OR shippeddate IS NULL THEN requireddate
    ELSE shippeddate
END AS latestdate
```

## Character / String Data

- Case sensitivity depends on collation of the column/database, not the query. Force case-sensitive comparison with `COLLATE`:
  ```sql
  WHERE lastname COLLATE Latin1_General_CS_AS = N'Davis';
  ```
- `sys.fn_helpcollations()` lists supported collations.
- Concatenation uses `+` and NULL is "contagious" — any NULL operand makes the whole expression NULL. Use `COALESCE` to substitute empty string, or better, use `CONCAT_WS` which ignores NULLs automatically:
  ```sql
  -- NULL propagates
  SELECT country + N',' + region + N',' + city AS location FROM Sales.Customers;

  -- handle NULL manually
  SELECT country + COALESCE(N',' + region, N'') + N',' + city AS location FROM Sales.Customers;

  -- cleanest: NULL-safe concatenation with separator
  SELECT CONCAT_WS(N',', country, region, city) AS location FROM Sales.Customers;
  ```

### String Functions Quick Reference

| Function | Purpose |
|---|---|
| `SUBSTRING(string, start, length)` | extract substring |
| `LEFT(string, n)` / `RIGHT(string, n)` | leftmost / rightmost n chars |
| `LEN(string)` | number of characters |
| `DATALENGTH(string)` | number of bytes |
| `CHARINDEX(substring, string[, start_pos])` | position of first occurrence of a literal substring |
| `PATINDEX(pattern, string)` | position of first occurrence of a pattern (supports wildcards) |
| `REPLACE(string, substr1, substr2)` | replace all occurrences |
| `TRANSLATE(string, chars, translations)` | replace multiple single characters in one pass |
| `REPLICATE(string, n)` | repeat a string n times |
| `STUFF(string, pos, delete_length, insert_string)` | delete then insert at a position |
| `UPPER(string)` / `LOWER(string)` | change case |
| `RTRIM` / `LTRIM` / `TRIM` | trim whitespace (right / left / both) |
| `TRIM([LEADING\|TRAILING\|BOTH] [chars FROM] string)` | trim specific characters |
| `FORMAT(input, format_string, culture)` | flexible formatting, higher perf cost |
| `COMPRESS(string)` / `DECOMPRESS(string)` | GZIP compress/decompress |
| `STRING_SPLIT(string, separator[, enable_ordinal])` | split string into rows |
| `STRING_AGG(input, separator) [WITHIN GROUP(order_spec)]` | aggregate rows into a delimited string |

```sql
SELECT PATINDEX('%[0-9]%', 'abcd123efgh');  -- first digit position

-- TRANSLATE is a cleaner alternative to nested REPLACE
SELECT REPLACE(REPLACE(REPLACE('123.456.789,00', '.', '~'), ',', '.'), '~', ',');
SELECT TRANSLATE('123.456.789,00', '.,', ',.');

SELECT supplierid,
    RIGHT(REPLICATE('0', 9) + CAST(supplierid AS VARCHAR(10)), 10) AS strsupplierid
FROM Production.Suppliers;

-- STUFF: remove the 'y' from 'xyz' and insert 'abc' -> 'xabcz'
SELECT STUFF('xyz', 2, 1, 'abc');

-- trim specific characters (slashes)
SELECT TRIM('/\' FROM '//\\ remove leading and trailing backward(\) and forward(/) slashes \\//');

SELECT CAST(value AS INT) AS myvalue
FROM STRING_SPLIT('10248,10249,10250', ',') AS S;

SELECT custid,
    STRING_AGG(CAST(orderid AS VARCHAR(10)), ',')
        WITHIN GROUP(ORDER BY orderdate DESC, orderid DESC) AS custorders
FROM Sales.Orders
GROUP BY custid;
```

## Date & Time

### Comparing dates — no date literals in T-SQL, use strings + conversion

```sql
-- implicit conversion (works, but relies on session settings for the string format)
WHERE orderdate = '20220212';

-- explicit conversion (preferred, unambiguous)
WHERE orderdate = CAST('20220212' AS DATE);
```

### Current date/time functions

| Function | Return type | Description |
|---|---|---|
| `GETDATE()` | DATETIME | current date and time |
| `CURRENT_TIMESTAMP` | DATETIME | same as `GETDATE()`, SQL-standard syntax |
| `GETUTCDATE()` | DATETIME | current date and time in UTC |
| `SYSDATETIME()` | DATETIME2 | current date and time (higher precision) |
| `SYSUTCDATETIME()` | DATETIME2 | current date and time in UTC |
| `SYSDATETIMEOFFSET()` | DATETIMEOFFSET | current date/time plus UTC offset |

- Reserved keywords used as column aliases must be bracketed: `AS [GETDATE]`.
- Get only the date or only the time part: `CAST(SYSDATETIME() AS DATE)` / `CAST(SYSDATETIME() AS TIME)`.

### Conversion functions (with safe counterparts)

- `CAST(value AS datatype)` / `TRY_CAST(value AS datatype)`
- `CONVERT(datatype, value[, style_number])` / `TRY_CONVERT(datatype, value[, style_number])`
- `PARSE(value AS datatype [USING culture])` / `TRY_PARSE(value AS datatype [USING culture])`
- `TRY_*` variants return `NULL` instead of raising an error on failed conversion.

### Time zones

```sql
-- list available time zones
SELECT name, current_utc_offset, is_currently_dst
FROM sys.time_zone_info;

-- attach a time zone to a "local" value -> produces DATETIMEOFFSET
SELECT CAST('20220212 12:00:00.000000' AS DATETIME2)
    AT TIME ZONE 'Pacific Standard Time' AS val1;

-- convert a DATETIMEOFFSET to another time zone
SELECT CAST('20220212 12:00:00.0000000 -05:00' AS DATETIMEOFFSET)
    AT TIME ZONE 'Pacific Standard Time' AS val1;

-- TODATETIMEOFFSET(local_date_and_time_value, UTC_offset) also attaches a fixed offset
```

### Date arithmetic & parts

```sql
-- DATEADD(part, n, dt_val)
SELECT DATEADD(year, 1, '20220212');

-- DATEDIFF(part, dt_val1, dt_val2) / DATEDIFF_BIG for values that overflow INT
SELECT DATEDIFF(day, '20210212', '20220212');
SELECT DATEDIFF_BIG(millisecond, '00010101', '20220212');

-- truncate to start of day / start of month via DATEDIFF + DATEADD round-trip
SELECT DATEADD(day, DATEDIFF(day, '19000101', SYSDATETIME()), '19000101');   -- start of day
SELECT DATEADD(month, DATEDIFF(month, '19000101', SYSDATETIME()), '19000101'); -- start of month

-- DATEPART(part, dt_val) -- returns an int
SELECT DATEPART(month, '20220212');
SELECT DATEPART(weekday, '20220213');
SELECT DATEPART(dayofyear, '20220212');

-- YEAR / MONTH / DAY shortcuts
SELECT YEAR('20220212'), MONTH('20220212'), DAY('20220212');

-- DATENAME(part, dt_val) -- returns the name as a string, e.g. 'February'
SELECT DATENAME(month, '20220212');

-- DATETRUNC(part, dt_val) -- SQL Server 2022+, truncates to the start of the part
SELECT DATETRUNC(month, '20220212');

-- ISDATE(string) -- 1 if valid date, 0 otherwise
SELECT ISDATE('20220212');  -- 1
SELECT ISDATE('20220230');  -- 0 (Feb 30 doesn't exist)
```

### Building dates from parts

```sql
SELECT
    DATEFROMPARTS(2022, 02, 12),
    DATETIME2FROMPARTS(2022, 02, 12, 13, 30, 5, 1, 7),
    DATETIMEFROMPARTS(2022, 02, 12, 13, 30, 5, 997),
    DATETIMEOFFSETFROMPARTS(2022, 02, 12, 13, 30, 5, 1, -8, 0, 7),
    SMALLDATETIMEFROMPARTS(2022, 02, 12, 13, 30),
    TIMEFROMPARTS(12, 30, 5, 1, 7);
```

### End of month & series generation

```sql
-- EOMONTH(input[, months_to_add])
SELECT EOMONTH(SYSDATETIME());

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);  -- orders placed on the last day of the month

-- GENERATE_SERIES(start, stop[, step]) -- SQL Server 2022+
SELECT value FROM GENERATE_SERIES(1, 10) AS N;

-- generate every date in 2022
DECLARE @startdate AS DATE = '20220101', @enddate AS DATE = '20221231';
SELECT DATEADD(day, value, @startdate) AS dt
FROM GENERATE_SERIES(0, DATEDIFF(day, @startdate, @enddate)) AS N;
```

## Querying Metadata

### Catalog views (SQL Server-specific, most detailed)

```sql
-- list tables + schema
SELECT SCHEMA_NAME(schema_id) AS table_schema_name, name AS table_name
FROM sys.tables;

-- column info for a specific table
SELECT name AS column_name, TYPE_NAME(system_type_id) AS column_type,
    max_length, collation_name, is_nullable
FROM sys.columns
WHERE object_id = OBJECT_ID(N'Sales.Orders');
```

### INFORMATION_SCHEMA views (ANSI-standard, portable across DB platforms)

```sql
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = N'BASE TABLE';

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, COLLATION_NAME, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = N'Sales' AND TABLE_NAME = N'Orders';
```

### System stored procedures & property functions

```sql
EXEC sys.sp_tables;                              -- list queryable objects
EXEC sys.sp_help @objname = N'Sales.Orders';      -- general info about an object
EXEC sys.sp_columns @table_name = N'Orders', @table_owner = N'Sales'; -- column info
EXEC sys.sp_helpconstraint @objname = N'Sales.Orders'; -- constraint info

SELECT SERVERPROPERTY('Collation');                            -- instance-level property
SELECT DATABASEPROPERTYEX(N'TSQLV6', 'Collation');              -- database-level property
SELECT OBJECTPROPERTY(OBJECT_ID(N'Sales.Orders'), 'TableHasPrimaryKey'); -- object-level property
SELECT COLUMNPROPERTY(OBJECT_ID(N'Sales.Orders'), N'shipcountry', 'AllowsNull'); -- column-level property
```
