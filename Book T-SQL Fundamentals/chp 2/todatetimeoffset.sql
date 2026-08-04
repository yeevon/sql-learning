USE TSQLV6;

-- ToDateTimeOffset function

-- TODATETIMEOFFSET(local_date_and_time_value, UTC_offset)

-- At Time Zone Function
-- dt_val AT TIME ZONE time_zone

-- Get available timezone
SELECT name, current_utc_offset, is_currently_dst
FROM sys.time_zone_info;

SELECT
	CAST('20220212 12:00:00.000000' AS DATETIME2)
		AT TIME ZONE 'Pacific Standard Time' AS val1,
	CAST('20220812 12:00:00.000000' AS DATETIME2)
		AT TIME ZONE 'Pacific Standard Time' AS val2;

SELECT
  CAST('20220212 12:00:00.0000000 -05:00' AS DATETIMEOFFSET)
    AT TIME ZONE 'Pacific Standard Time' AS val1,
  CAST('20220812 12:00:00.0000000 -04:00' AS DATETIMEOFFSET)
    AT TIME ZONE 'Pacific Standard Time' AS val2;


-- DATEADD function
-- DATEADD(part, n, dt_val)

-- add 1 year to February 12, 2022
SELECT DATEADD(year, 1, '20220212');

-- DATEDIFF | DATEDIFF_BIG functions
-- DATEDIFF(part, dat_vale1, dt_val2) | DATEDIFF_BIG(part, dt_val1, dt_val2)

-- diff in terms of days between two values
SELECT DATEDIFF(day, '20210212','20220212');

-- if value returned is greater than an max INT
SELECT DATEDIFF_BIG(millisecond, '00010101','20220212');

-- compute the beginning of the day that corresponds to the input date and time value
SELECT
	DATEADD(
		day,
		DATEDIFF(day,'19000101',SYSDATETIME()),
		'19000101'
	);


-- Get current month
SELECT
	DATEADD(
		month,
		DATEDIFF(month,'19000101',SYSDATETIME()),
		'19000101'
	);

-- DATEPART function
-- DATEPART(part, dt_val)

-- only return the month
SELECT DATEPART(month,'20220212');

-- GET DAY, WEEKDAY, DO OF THE YEAR
SELECT
	DATEPART(day,'20220212') AS part_day,
	DATEPART(weekday,'20220213') AS part_weekday,
	DATEPART(dayofyear,'20220212') AS part_dayofyear;


-- YEAR, MONTH, DAY function
-- YEAR(dt_val) | MONTH(dt_val) | DAY(dt_val)

SELECT
	DAY('20220212') AS theday,
	MONTH('20220212') AS themonth,
	YEAR('20220212') AS theyear;

-- DATENAME function
-- DATENAME(dt_val,part)

-- get month name
SELECT DATENAME(month,'20220212');

SELECT DATENAME(YEAR,'20220212');
SELECT DATEPART(YEAR,'20220212');

-- DATETRUNC function
-- DATETRUNC(part, dt_val)

 -- returns beginning of the month date
 SELECT DATETRUNC(month,'20220212');


 -- ISDATE function
 -- ISDATE(string) returns 1/0 if value is a date

 -- returns 1
 SELECT ISDATE('20220212');

 -- returns 0
 SELECT ISDATE('20220230');


 -- FROMPARTS function
	-- DATEFROMPARTS(year, month, day) 
	-- DATETIME2FROMPARTS(year, month, day, hour, minute, seconds, fractions, precision)
	-- DATETIMEFROMPARTS(year, month, day, hour, minute, seconds, milliseconds)
	-- DATETIMEOFFSETFROMPARTS(year, month, day, hour, minute, seconds, fractions, hour_offset, minute_offset, precision)
	-- SMALLDATETIMEFROMPARTS(year, month, day, hour, minute)
	-- TIMEFROMPARTS(hour, minute, seconds, fractions, precision)

-- example
SELECT
	DATEFROMPARTS(2022, 02, 12),
	DATETIME2FROMPARTS(2022, 02, 12, 13, 30, 5, 1, 7),
	DATETIMEFROMPARTS(2022, 02, 12, 13, 30, 5, 997),
	DATETIMEOFFSETFROMPARTS(2022, 02, 12, 13, 30, 5, 1, -8, 0, 7),
	SMALLDATETIMEFROMPARTS(2022,02,12,13,30),
	TIMEFROMPARTS(12, 30, 5, 1, 7);


-- EOMONTH function
-- EOMONTH(input[,months_to_add])

-- returns the end of the current month
SELECT EOMONTH(SYSDATETIME());

-- returns orders placed on the last day of the month
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);

-- get last day of the month
-- DATEADD(month, DATEDIFF(month, '18991231', date_val),'18991231')


-- GENERATE_SERIES function
-- SELECT value FROM GENERATE_SERIES(start_value,stop_value[,step_value]);

-- returns a sequence of integers between 1 and 19
SELECT value
FROM GENERATE_SERIES(1,10) AS N;

-- generates a sequence of all dates in the year 2022
DECLARE @startdate AS DATE = '20220101', @enddate AS DATE = '20221231';

SELECT DATEADD(day, value, @startdate) AS dt
FROM GENERATE_SERIES(0, DATEDIFF(day, @startdate, @enddate)) AS N;
