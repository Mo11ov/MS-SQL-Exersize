-- Task 08. Employees with Three Projects
 CREATE PROCEDURE usp_AssignProject(@emloyeeId INT, @projectID INT)
               AS
BEGIN TRANSACTION

DECLARE @projectsCount INT = (SELECT COUNT(*)
                            FROM [Employees] AS [e]
                            JOIN [EmployeesProjects] AS [ep] ON [ep].EmployeeID = [e].[EmployeeID]
                            JOIN [Projects] AS [p] ON [p].[ProjectID] = [ep].[ProjectID]
                           WHERE [e].[EmployeeID] = @emloyeeId)

IF @projectsCount >= 3
BEGIN
	ROLLBACK
	RAISERROR ('The employee has too many projects!', 16, 1)
	RETURN
END

INSERT INTO [EmployeesProjects]([EmployeeID], [ProjectID])
     VALUES (@emloyeeId, @projectID)

COMMIT

-- Task 09. Delete Employees
CREATE TABLE [Deleted_Employees](
	[EmployeeId] INT PRIMARY KEY,
	[FirstName] VARCHAR (50) NOT NULL,
	[LastName] VARCHAR (50) NOT NULL,
	[MiddleName] VARCHAR (50),
	[JobTitle] VARCHAR (50) NOT NULL,
	[DepartmentId] INT NOT NULL,
	[Salary] MONEY NOT NULL
)

CREATE TRIGGER tr_DeletedEmploees
            ON [Employees]
    FOR DELETE
            AS

BEGIN
	INSERT INTO [Deleted_Employees](
	            [FirstName], [LastName], [MiddleName], [JobTitle], [DepartmentId], [Salary])
	     SELECT [FirstName], [LastName], [MiddleName], [JobTitle], [DepartmentId], [Salary]
	       FROM [deleted]
END
