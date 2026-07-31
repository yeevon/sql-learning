# Houston ETRM Transition Plan

## Progress Dashboard

**Plan started:** July 19, 2026  
**SQLBolt progress last updated:** July 21, 2026  
**Tracker updated:** July 22, 2026  
**Current milestone:** Finish the SQL fundamentals refresher before beginning the Microsoft Learn T-SQL curriculum.

| Phase | Status | Progress | Next action |
|---|---|---:|---|
| SQL Server lab | Complete | 3/3 setup items | Keep using AdventureWorks for practice |
| SQLBolt refresher | Complete | 14/16 lessons — 87.5% | Complete lessons 15 and 16 |
| SQL command cheat sheet | In Progress | Core notes captured through `UPDATE` | Add commands as each new topic is practiced |
| Microsoft Learn T-SQL | In Progress | 0/4 learning paths | Begin **Query and modify data with Transact-SQL** |
| Video companion | As needed | No completion target | Use when Microsoft Learn material needs reinforcement |
| HackerRank SQL | Not marked started | No problems logged | Start after the matching Microsoft Learn topics |
| SQL Git repository | Not marked started | 0/9 topic folders logged | Create the repository with `01-select-filter-sort` first |

### Immediate Next Checkpoint

- [X] Complete SQLBolt lesson 15
- [X] Complete SQLBolt lesson 16
- [X] Record the actual SQLBolt completion date
- [X] Create the `sql-learning` Git repository
- [X] Begin T-SQL Fundamentals, 4th Edition epub
- [ ] Reproduce the first lesson queries in SSMS
- [ ] Write two original AdventureWorks queries
- [ ] Complete three to five matching HackerRank problems

### Progress Log

| Date | Progress update |
|---|---|
| 2026-07-19 | Started the Houston ETRM transition plan. |
| 2026-07-21 | SQL Server, SSMS, and AdventureWorks setup complete; SQLBolt reached 14/16 lessons. This is the last reported progress date, not a target date. |
| 2026-07-22 | Progress tracker created and date interpretation corrected. No additional study progress reported. |

### Update Format

Add one row to the progress log after each study session:

```text
YYYY-MM-DD | Completed: ___ | Update: ___ | Blocker: ___ | Next: ___
```

---

 - 2026-07-22 | Completed: SQL Bolt | Update: Complete last 2 courses as per the plan 15 & 16 | Blocker: ___ | Next: Microsoft Learn T-SQL
 - 2026-07-22 | Completed: Enabled free azure subscription provided by OSU | Update: ___ | Blocker: ___ | Next: continue Microsoft Learn T-SQL
 - 2026-07-22 | Completed: ___ | Update: Dumping the microsoft learning resources they suck purchasing: T-SQL Fundamentals, 4th Edition  | Blocker: ___ | Next: continue Microsoft Learn T-SQL
 - 2026-07-22 | Completed:  T-SQL Fundamentals - 6% | Update: on page 19  | Blocker: ___ | Next: continue reading T-SQL Fundamentals
 - 2026-07-23 | Completed:  T-SQL Fundamentals CH1 - 7% | Update: on page 27  | Blocker: ___ | Next: Section 1 of SQL Bootcamp
 - 2026-07-23 | Completed:  SQL Bootcamp Section 1 | Update: ___  | Blocker: ___ | Next: Start Chapter 2 of T-Sql Fundamentals
 - 2026-07-26 | Completed:  12% | Update: Completed ch2 - Elements of the Select statement currently on pg 50  | Blocker: ___ | Next: Continue on ch2 Predicates and operators
 - 2026-07-27 | Completed:  12% | Update: Completed ch2 - Predicates currently on pg 53  | Blocker: ___ | Next: Continue on ch2 Case expressions
 - 2026-07-27 | Completed:  Basic HTML 63/137 | Update: add free code camp to the cycle 1 hour a day fullstack path  | Blocker: ___ | Next: continue to step 64
 - 2026-07-28 | Completed:  Basic HTML 87/137 | Update: add free code camp to the cycle 1 hour a day fullstack path  | Blocker: ___ | Next: continue to step 88
 - 2026-07-29 | Completed:  14% | Update: Completed ch2 - Predicates currently on pg 61  | Blocker: ___ | Next: Continue on ch2 The Greatest and Least Functions
 - 2026-07-29 | Completed:  Basic HTML 120/137 | Update: add free code camp 1 hour | Blocker: ___ | Next: continue to step 121
 - 2026-07-30 | Completed:  17% | Update: Completed ch2 - Predicates currently on pg 75  | Blocker: ___ | Next: Continue on ch2 The STUFF Function
 - 2026-07-30 | Completed:  Basic HTML 137/137 | Update: add free code camp 1 hour | Blocker: ___ | Next: continue to Semantic HTML
 - 2026-07-30 | Completed:  Semantic HTML 1/55 | Update: ___ | Blocker: ___ | Next: continue to Semantic HTML 2

- ETRM Support Analyst
- Trading Systems Support Analystz
- Trading Application Support Analyst
- Commodity Application Support Analyst
- Production Support Analyst — Trading/Energy
- Trading Systems QA Analyst
- ETRM QA / UAT Analyst
- Trade Data Analyst
- Energy Trading Systems Test Analyst
- Application Support Analyst — Commodities
- Release or Environment Analyst — Trading Systems

### 1. Install a real SQL Server lab

Use:

- SQL Server Developer Edition — free for development and testing. - Done
- SQL Server Management Studio — free.                             - Done
- AdventureWorks — Microsoft’s sample business database.           - Done

That gives you a real enterprise database, realistic relationships, and enough data for joins, reporting, procedures, and performance work.

Do not design your own database yet. Learn against AdventureWorks first.

==== Setup complete and able to query AdventureWorks

### 2. Fast fundamentals refresher: SQLBolt

Complete SQLBolt from SELECT through table creation. It teaches interactively in the browser and includes filtering, sorting, joins, nulls, aggregates, inserts, updates, deletes, and basic table operations.

This should be a refresher, not your main curriculum.

==== Current Progress: Done — Last Updated 7/22/2026


### 3. Main curriculum: Microsoft Learn T-SQL

Follow these in order:

Query and modify data with Transact-SQL
Covers queries, multiple-table joins, built-in functions, grouping, and data modification.
Program with Transact-SQL
Covers variables, control flow, stored procedures, and user-defined functions.
Write advanced Transact-SQL queries
Move into subqueries, CTEs, and window functions.
Optimize query performance
Learn execution plans, Query Store, indexing, and performance investigation.

This is the actual instructional spine.

### 4. Video companion

Use Microsoft’s Programming Databases with T-SQL for Beginners series when the written Microsoft Learn material feels too dry. The instructors build a database for an application from beginning to end rather than presenting isolated commands.

### 5. Practice problems: HackerRank SQL

Use HackerRank after learning each topic:

Basic select
Aggregation
Basic joins
Advanced joins
Alternative queries

It has SQL exercises ranging from basic through intermediate and advanced. Treat it as query-logic practice; test SQL Server-specific syntax in SSMS afterward.

The learning workflow

For every Microsoft Learn module:

Complete the lesson.
Reproduce every query in SSMS.
Change the filters, joins, and grouping.
Write two original queries against AdventureWorks.
Save them in a Git repository organized by topic.
Complete three to five matching HackerRank problems.

Your repository can look like:

```init
sql-learning/
├── 01-select-filter-sort/
├── 02-joins/
├── 03-aggregates/
├── 04-subqueries-ctes/
├── 05-window-functions/
├── 06-views-procedures-functions/
├── 07-transactions-error-handling/
├── 08-indexes-execution-plans/
└── 09-investigation-queries/
```

#### What to prioritize

For SQL-heavy application support and development roles, your progression should be:


SELECT and filtering
```init
→ joins
→ GROUP BY and aggregates
→ subqueries and CTEs
→ window functions
→ data modification
→ transactions
→ views
→ stored procedures
→ error handling
→ temporary tables
→ indexes
→ execution plans
→ blocking and performance investigation
```

Do not start with database administration, backups, clustering, replication, or obscure SQL Server features. First become extremely good at retrieving, validating, reconciling, and safely modifying relational data.
