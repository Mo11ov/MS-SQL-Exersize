SELECT [e].[EmployeeID], [e].[FirstName],
       [e].[ManagerID], 
       [em].[FirstName] AS [ManagerName]
  FROM [Employees] AS e
  JOIN [Employees] AS em ON [e].[ManagerID] = [em].[EmployeeID]
 WHERE [e].[ManagerID] IN (3, 7)

