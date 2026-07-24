# SQL Command Cheat sheet:

- Select: 
        
    Select query for a specific columns
    ```sql
    SELECT column, another_column, …
    FROM mytable;
    ```

    Select query for all columns
    ```sql
    SELECT * 
    FROM mytable;
    ```
- Where

    Select query with constraints
    ```sql
    SELECT column, another_column, …
    FROM mytable
    WHERE condition
    AND/OR another_condition
    AND/OR …;
    ```
- Operators
   | Operator |	Condition |	SQL Example |
   |----------|-------------------------|-------------|
   |=, !=, <, <=, >, >= |	Standard numerical operators |	col_name != 4 |
   | BETWEEN … AND … |	Number is within range of two values (inclusive) |	col_name BETWEEN 1.5 AND 10.5 |
   | NOT BETWEEN … AND … |	Number is not within range of two values (inclusive) |	col_name NOT BETWEEN 1 AND 10 |
   | IN (…)	| Number exists in a list |	col_name IN (2, 4, 6) |
   | NOT IN (…) |	Number does not exist in a list |	col_name NOT IN (1, 3, 5) |

- Distinct

    Select query with unique results
    ```sql
    SELECT DISTINCT column, another_column, …
    FROM mytable
    WHERE condition(s);
    ```

- Order By

    Select query with ordered results
    ```sql
    SELECT column, another_column, …
    FROM mytable
    WHERE condition(s)
    ORDER BY column ASC/DESC;
    ```

- Limit & Offset

    Select query with limited rows
    ```sql
    SELECT column, another_column, …
    FROM mytable
    WHERE condition(s)
    ORDER BY column ASC/DESC
    LIMIT num_limit OFFSET num_offset;
    ```

- Joins

    Select query with INNER JOIN on multiple tables
    ```sql
    SELECT column, another_table_column, …
    FROM mytable
    INNER JOIN another_table 
        ON mytable.id = another_table.id
    WHERE condition(s)
    ORDER BY column, … ASC/DESC
    LIMIT num_limit OFFSET num_offset;
    ```

    Select query with LEFT/RIGHT/FULL JOINs on multiple tables
    ```sql
    SELECT column, another_column, …
    FROM mytable
    INNER/LEFT/RIGHT/FULL JOIN another_table 
        ON mytable.id = another_table.matching_id
    WHERE condition(s)
    ORDER BY column, … ASC/DESC
    LIMIT num_limit OFFSET num_offset;
    ```

- Null

    Select query with constraints on NULL values
    ```sql
    SELECT column, another_column, …
    FROM mytable
    WHERE column IS/IS NOT NULL
    AND/OR another_condition
    AND/OR …;
    ```

- Expressions

    Example query with expressions
    ```sql
    SELECT particle_speed / 2.0 AS half_particle_speed
    FROM physics_data
    WHERE ABS(particle_position) * 10.0 > 500;
    ```

- Aliases

    Select query with expression aliases
    ```sql
    SELECT col_expression AS expr_description, …
    FROM mytable;
    ```

    Example query with both column and table name aliases
    ```sql
    SELECT column AS better_column_name, …
    FROM a_long_widgets_table_name AS mywidgets
    INNER JOIN widget_sales
    ON mywidgets.id = widget_sales.widget_id;
    ```

- Aggregates

    Select query with aggregate functions over all rows
    ```sql
    SELECT AGG_FUNC(column_or_expression) AS aggregate_description, …
    FROM mytable
    WHERE constraint_expression;
    ```

    #### Common aggregate functions

    | Function |	Description |
    |----------|----------------|
    | COUNT(*), COUNT(column) |	A common function used to counts the number of rows in the group if no column name is specified. Otherwise, count the number of rows in the group with non-NULL values in the specified column. |
    | MIN(column) |	Finds the smallest numerical value in the specified column for all rows in the group. |
    | MAX(column) |	Finds the largest numerical value in the specified column for all rows in the group. |
    | AVG(column) |	Finds the average numerical value in the specified column for all rows in the group. |
    | SUM(column) |	Finds the sum of all numerical values in the specified column for the rows in the group. |
    | Docs: | [MySQL](https://dev.mysql.com/doc/refman/5.6/en/group-by-functions.html), [Postgres](http://www.postgresql.org/docs/9.4/static/functions-aggregate.html), [SQLite](http://www.sqlite.org/lang_aggfunc.html), [Microsoft SQL Server](https://msdn.microsoft.com/en-us/library/ms173454.aspx) |

    #### Grouped aggregate functions

    Select query with aggregate functions over groups
    ```sql
    SELECT AGG_FUNC(column_or_expression) AS aggregate_description, …
    FROM mytable
    WHERE constraint_expression
    GROUP BY column;
    ```

- Having

    Select query with HAVING constraint
    ```sql
    SELECT group_by_column, AGG_FUNC(column_expression) AS aggregate_result_alias, …
    FROM mytable
    WHERE condition
    GROUP BY column
    HAVING group_condition;
    ```

- SQL Order of Operations

    Complete SELECT query
    ```sql
    SELECT DISTINCT column, AGG_FUNC(column_or_expression), …
    FROM mytable
        JOIN another_table
        ON mytable.column = another_table.column
        WHERE constraint_expression
        GROUP BY column
        HAVING constraint_expression
        ORDER BY column ASC/DESC
        LIMIT count OFFSET COUNT;
    ```

        1. **FROM** and **JOIN**
        2. **WHERE**
        3. **GROUP BY**
        4. **HAVING**
        5. **SELECT**
        6. **DISTINCT**
        7. **ORDER BY**
        8. **LIMIT / OFFSET**
        
- Insert

    Insert statement with values for all columns
    ```sql
    INSERT INTO mytable
    VALUES (value_or_expr, another_value_or_expr, …),
        (value_or_expr_2, another_value_or_expr_2, …),
        …;
    ```

    Insert statement with specific columns
    ```sql
    INSERT INTO mytable
    (column, another_column, …)
    VALUES (value_or_expr, another_value_or_expr, …),
        (value_or_expr_2, another_value_or_expr_2, …),
        …;
    ```

    Example Insert statement with expressions
    ```sql
    INSERT INTO boxoffice
    (movie_id, rating, sales_in_millions)
    VALUES (1, 9.9, 283742034 / 1000000);
    ```

- Update 

    Update statement with values
    ```sql
    UPDATE mytable
    SET column = value_or_expr, 
        other_column = another_value_or_expr, 
        …
    WHERE condition;
    ```

- Deleting

    Delete statement with condition
    ```sql
    DELETE FROM mytable
    WHERE condition;
    ```

- Creating Tables

    Create table statement w/ optional table constraint and default value
    ```sql
    CREATE TABLE IF NOT EXISTS mytable (
        column DataType TableConstraint DEFAULT default_value,
        another_column DataType TableConstraint DEFAULT default_value,
        …
    );
    ```

    #### **Table data types**

    | Data type	| Description |
    |-----------|-------------|
    | INTEGER, BOOLEAN	| The integer datatypes can store whole integer values like the count of a number or an age. In some implementations, the boolean value is just represented as an integer value of just 0 or 1. |
    | FLOAT, DOUBLE, REAL	| The floating point datatypes can store more precise numerical data like measurements or fractional values. Different types can be used depending on the floating point precision required for that value. |
    | CHARACTER(num_chars), VARCHAR(num_chars), TEXT	| The text based datatypes can store strings and text in all sorts of locales. The distinction between the various types generally amount to underlaying efficiency of the database when working with these columns. Both the CHARACTER and VARCHAR (variable character) types are specified with the max number of characters that they can store (longer values may be truncated), so can be more efficient to store and query with big tables. |
    | DATE, DATETIME	| SQL can also store date and time stamps to keep track of time series and event data. They can be tricky to work with especially when manipulating data across timezones. |
    | BLOB	| Finally, SQL can store binary data in blobs right in the database. These values are often opaque to the database, so you usually have to store them with the right metadata to requery them. |
    | Docs: | [MySQL](http://dev.mysql.com/doc/refman/5.6/en/data-types.html), [Postgres](http://www.postgresql.org/docs/9.4/static/datatype.html), [SQLite](https://www.sqlite.org/datatype3.html), [Microsoft SQL Server](https://msdn.microsoft.com/en-us/library/ms187752.aspx) |

    
    #### **Table constraints**

    | Constraint | Description | 
    |------------|-------------| 
    | PRIMARY KEY	| This means that the values in this column are unique, and each value can be used to identify a single row in this table. |
    | AUTOINCREMENT | For integer values, this means that the value is automatically filled in and incremented with each row insertion. Not supported in all databases. |
    | UNIQUE	| This means that the values in this column have to be unique, so you can't insert another row with the same value in this column as another row in the table. Differs from the `PRIMARY KEY` in that it doesn't have to be a key for a row in the table. |
    | NOT NULL	| This means that the inserted value can not be `NULL`. |
    | CHECK (expression)	| This allows you to run a more complex expression to test whether the values inserted are valid. For example, you can check that values are positive, or greater than a specific size, or start with a certain prefix, etc. |
    | FOREIGN KEY	| This is a consistency check which ensures that each value in this column corresponds to another value in a column in another table. For example, if there are two tables, one listing all Employees by ID, and another listing their payroll information, the `FOREIGN KEY` can ensure that every row in the payroll table corresponds to a valid employee in the master Employee list. | 

    #### **Example**

    Movies table schema
    ```sql
    CREATE TABLE movies (
        id INTEGER PRIMARY KEY,
        title TEXT,
        director TEXT,
        year INTEGER, 
        length_minutes INTEGER
    );
    ```