--Task 01. Employees with Salary Above 35000
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000 
AS
SELECT [FirstName], [LastName]
  FROM [Employees]
 WHERE [Salary] > 35000


 --Task 02. Employees with Salary Above Number
 CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber (@Input DECIMAL(18,4))
 AS
 SELECT [FirstName], [LastName]
   FROM [Employees]
  WHERE [Salary] >= @Input 

  --Task 03. Town Names Starting With
CREATE PROCEDURE usp_GetTownsStartingWith (@inputChar VARCHAR(10))
AS
SELECT [Name] AS [Town]
  FROM [Towns]
 WHERE [Name] LIKE @inputChar + '%'


  --Task 04. Employees from Town
CREATE PROCEDURE usp_GetEmployeesFromTown (@inputTown VARCHAR(50))
AS
SELECT [e].[FirstName], [e].[LastName]
  FROM [Employees] AS [e]
  JOIN [Addresses] AS [a] ON [e].[AddressID] = [a].[AddressID]
  JOIN [Towns] AS [t] ON [a].[TownID] = [t].[TownID]
 WHERE [t].[Name] = @inputTown


--Task 05. Salary Level Function
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @result VARCHAR(10)

	IF (@salary < 30000)
		SET @result = 'Low'
	ELSE IF(@salary BETWEEN 30000 AND 50000)
		SET @result = 'Average'
	ELSE 
		SET @result = 'High'
	RETURN @result
END

--Task 06. Employees by Salary Level
CREATE PROCEDURE usp_EmployeesBySalaryLevel (@salaryLevel VARCHAR(10))
AS
SELECT [FirstName], [LastName]
  FROM [Employees]
 WHERE dbo.ufn_GetSalaryLevel([Salary]) = @salaryLevel


 --Task 07. Define Function
 CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(20), @word VARCHAR (20))
RETURNS BIT
AS
BEGIN 
	DECLARE @count INT = 1

	WHILE(@count <= LEN(@word))
		BEGIN 
			DECLARE @currChar CHAR(1) = SUBSTRING(@word, @count, 1)

			IF(CHARINDEX(@currChar, @setOfLetters) = 0)
				RETURN 0

			SET @count +=1
		END
	RETURN 1
END

--Task 08. Delete Employees and Departments
CREATE PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
ALTER TABLE [Departments]
ALTER COLUMN [ManagerID] INT NULL

DELETE   
  FROM [EmployeesProjects]
 WHERE [EmployeeID] IN (SELECT [EmployeeID] FROM [Employees] WHERE [DepartmentID] = @departmentId)
 
UPDATE [Employees]
   SET [ManagerID] = NULL
 WHERE [ManagerID] IN (SELECT [EmployeeID] FROM [Employees] WHERE [DepartmentID] = @departmentId)

UPDATE [Departments]
   SET [ManagerID] = NULL
 WHERE [ManagerID] IN (SELECT [EmployeeID] FROM [Employees] WHERE [DepartmentID] = @departmentId)

DELETE
  FROM [Employees]
 WHERE [DepartmentID] = @departmentId

DELETE 
  FROM [Departments]
 WHERE [DepartmentID] = @departmentId


SELECT COUNT(*)
  FROM [Employees]
 WHERE [DepartmentID] = @departmentId
