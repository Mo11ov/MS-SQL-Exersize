--Task 01. Records’ Count 
SELECT COUNT(*) AS [Count]
  FROM [WizzardDeposits]


--Task 02. Longest Magic Wand
SELECT MAX([MagicWandSize]) AS [LongestMagicWand]
  FROM [WizzardDeposits]


--Task 03. Longest Magic Wand per Deposit Groups
  SELECT [DepositGroup], MAX([MagicWandSize]) AS [LongestMagicWand]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]


--Task 04. Smallest Deposit Group per Magic Wand Size*
SELECT TOP (2)[DepositGroup]  
      FROM [WizzardDeposits]
  GROUP BY [DepositGroup]
  ORDER BY AVG([MagicWandSize]) 
    

--Task 05. Deposits Sum
  SELECT [DepositGroup], SUM([DepositAmount]) AS [TotalSum]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]


--Task 06. Deposits Sum for Ollivander Family
  SELECT [DepositGroup], SUM([DepositAmount]) AS [TotalSum]
    FROM [WizzardDeposits]
   WHERE [MagicWandCreator] = 'Ollivander family' 
GROUP BY [DepositGroup]


--Task 07. Deposits Filter
  SELECT [DepositGroup], SUM([DepositAmount]) AS [TotalSum]
    FROM [WizzardDeposits]
   WHERE [MagicWandCreator] = 'Ollivander family' 
GROUP BY [DepositGroup]
  HAVING SUM([DepositAmount]) < 150000
ORDER BY [TotalSum] DESC


--Task 08. Deposit Charge
  SELECT [DepositGroup], [MagicWandCreator], MIN([DepositCharge]) AS [MinDepositCharge]
    FROM [WizzardDeposits]
GROUP BY [MagicWandCreator], [DepositGroup]
ORDER BY [MagicWandCreator], [DepositGroup]


-- Task 09. Age Groups
  SELECT [AgeGroup], COUNT(*) AS [WizardCount]
    FROM (SELECT [Age],
          CASE
  	        WHEN [Age] BETWEEN 0 AND 10 THEN '[0-10]'
  		    WHEN [Age] BETWEEN 11 AND 20 THEN '[11-20]'
  		    WHEN [Age] BETWEEN 21 AND 30 THEN '[21-30]'
  		    WHEN [Age] BETWEEN 31 AND 40 THEN '[31-40]'
  		    WHEN [Age] BETWEEN 41 AND 50 THEN '[41-50]'
  		    WHEN [Age] BETWEEN 51 AND 60 THEN '[51-60]'
  		    ELSE '[61+]'
          END AS [AgeGroup]
    FROM [WizzardDeposits]) AS Result
GROUP BY [AgeGroup]

--Task 10. First Letter
  SELECT LEFT([FirstName], 1) AS [FirstLetter]
    FROM [WizzardDeposits]
   WHERE [DepositGroup] = 'Troll Chest'
GROUP BY LEFT([FirstName], 1)
 

-- Task 11. Average Interest
  SELECT [DepositGroup], [IsDepositExpired], AVG([DepositInterest]) AS [AverageInterest]
    FROM [WizzardDeposits]
   WHERE [DepositStartDate]  > '01-01-1985'
GROUP BY [DepositGroup], [IsDepositExpired]
ORDER BY [DepositGroup] DESC, [IsDepositExpired]

-- Task 12. Rich Wizard, Poor Wizard
  SELECT SUM([H].[DepositAmount] - [G].[DepositAmount]) AS [SumDifference]
    FROM [WizzardDeposits] AS [H]
	JOIN [WizzardDeposits] AS [G] ON [H].[Id] + 1 = [G].[Id] 