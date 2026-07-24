ALTER TABLE dbo.Employees
	ADD CONSTRAINT CHK_Employees_Salary
	CHECK(salary>0.00);