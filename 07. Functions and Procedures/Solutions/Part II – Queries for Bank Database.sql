--Task 09. Find Full Name
CREATE PROCEDURE usp_GetHoldersFullName 
AS
SELECT [FirstName] + ' ' + [LastName] AS [Full Name] 
  FROM [AccountHolders]


--Task 10. People with Balance Higher Than
CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan (@input DECIMAL (14,2))
AS
  SELECT [FirstName], [LastName]
    FROM [AccountHolders] AS [ah]
    JOIN [Accounts] AS [a] ON [ah].Id = [a].[AccountHolderId]
GROUP BY [FirstName], [LastName]
  HAVING SUM([Balance]) > @input
ORDER BY [FirstName], [LastName]


--Task 11. Future Value Function
CREATE FUNCTION ufn_CalculateFutureValue (@sum DECIMAL(14,2), @interestRate FLOAT, @years INT)
RETURNS DECIMAL(16,4)
BEGIN 
	DECLARE @FinalSum DECIMAL(16,4)
	SET @FinalSum = (@sum * POWER((1 + @interestRate), @years))
	RETURN @FinalSum
END


--Task 12. Calculating Interest
CREATE PROCEDURE usp_CalculateFutureValueForAccount (@accountID INT, @interestRate FLOAT)
AS
SELECT [ah].[Id] AS [Account Id],
       [ah].[FirstName] AS [First Name],
	   [ah].[LastName] AS [Last Name],
	   [a].[Balance] AS [Current Balance],
	   (SELECT dbo.ufn_CalculateFutureValue([a].[Balance], @interestRate, 5))
	   AS [Balance in 5 years]
  FROM [AccountHolders] AS [ah]
  JOIN [Accounts] AS [a] ON [a].AccountHolderId = [ah].[Id]
 WHERE [a].[Id] = @accountID