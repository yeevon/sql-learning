USE TSQLV6;

ALTER TABLE dbo.Employees
	ADD CONSTRAINT PK_Employees
	PRIMARY KEY(empid);

ALTER TABLE dbo.Employees
	ADD CONSTRAINT UNQ_Employees_ssn
	UNIQUE(ssn);

-- allow nulls but non nulls must be unique
CREATE UNIQUE INDEX idx_ssn_notnull ON dbo.Employees(ssn)
	WHERE ssn IS NOT NULL;