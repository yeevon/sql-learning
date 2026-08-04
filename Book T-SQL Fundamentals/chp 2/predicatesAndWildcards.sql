-- Like predicate
SELECT empid, lastname
FROM HR.Employees
WHERE lastname LIKE N'D%';

-- _(UNDERSCORE) wildcard
SELECT empid, lastname
FROM HR.Employees
WHERE lastname LIKE N'_e%';

--[<list of characters>] wildcard
SELECT empid, lastname
FROM HR.Employees
WHERE lastname LIKE N'[DFK]%';

-- [<CHARACTER>-<CHARACTER>] wildcard
SELECT empid, lastname
FROM HR.Employees
WHERE lastname LIKE N'[A-E]%';

-- [^<character list or range>] wildcard
-- ^ is equal to not
SELECT empid, lastname
FROM HR.Employees
WHERE lastname LIKE N'[^A-E]%';

-- ESCAPE character
-- col1 LIKE '%!_%' ESCAPE '!'
-- or
-- col1 LIKE '%[_]%'

