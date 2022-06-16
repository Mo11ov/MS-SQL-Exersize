USE SoftUni

--Task 13. Departments Total Salaries
  SELECT [DepartmentID], SUM([Salary])
    FROM [Employees]
GROUP BY [DepartmentID]
ORDER BY [DepartmentID]


--Task 14. Employees Minimum Salaries
  SELECT [DepartmentID], MIN([Salary]) AS [MinimumSalary]
    FROM [Employees]
   WHERE [DepartmentID] IN (2, 5, 7)
GROUP BY [DepartmentID]


--Task 15. Employees Average Salaries
SELECT * INTO [New Table]
  FROM [Employees]
 WHERE [Salary] > 30000

DELETE FROM [New Table]
      WHERE [ManagerID] = 42

UPDATE [New Table]
   SET [Salary] += 5000
 WHERE [DepartmentID] = 1

  SELECT [DepartmentID], AVG([Salary])
    FROM [New Table]
GROUP BY [DepartmentID]


--Task 16. Employees Maximum Salaries
  SELECT [DepartmentID], MAX([Salary]) AS [MaxSalary]
    FROM [Employees]
GROUP BY [DepartmentID]
  HAVING MAX([Salary]) NOT BETWEEN 30000 AND 70000


--Task 17. Employees Count Salaries
SELECT COUNT([Salary]) AS [Count]
  FROM [Employees]
 WHERE [ManagerID] IS NULL


 --Task 18. 3rd Highest Salary
  SELECT [DepartmentID], [Salary] AS [ThirdHighestSalary]
    FROM (SELECT [DepartmentID], [Salary],
         DENSE_RANK() OVER(PARTITION BY [DepartmentID] ORDER BY [Salary] DESC)
 		 AS [RankedSalary]
    FROM [Employees]) AS [Result]
   WHERE [RankedSalary] = 3
GROUP BY [DepartmentID], [Salary]


--Task 19. Salary Challenge
  SELECT TOP (10)[FirstName], [LastName], [DepartmentID]
        FROM [Employees] AS [e]
       WHERE [Salary] > (SELECT AVG([Salary])
                         FROM [Employees]
						WHERE [DepartmentID] = [e].[DepartmentID]
                     GROUP BY [DepartmentID])
    ORDER BY [DepartmentID]
