-- Task 01.Create Table Logs
CREATE TABLE [Logs](
	[LogId] INT PRIMARY KEY IDENTITY,
	[AccountId] INT FOREIGN KEY REFERENCES [Accounts](Id) NOT NULL,
	[OldSum] MONEY NOT NULL,
	[NewSum] MONEY NOT NULL
)


CREATE TRIGGER tr_LogsForBallanceChangeToAccount
            ON [Accounts]
    FOR UPDATE
            AS

BEGIN
   INSERT INTO [Logs]([AccountId], [OldSum], [NewSum])
        SELECT [i].[AccountHolderId], [d].[Balance], [i].[Balance]
          FROM [inserted] AS i
          JOIN [deleted] AS d ON [i].[Id] = [d].[Id]
END


-- Task 02.Create Table Emails
CREATE TABLE NotificationEmails(
	[Id] INT PRIMARY KEY IDENTITY,
	[Recipient] INT FOREIGN KEY REFERENCES [Accounts](Id) NOT NULL,
	[Subject] VARCHAR(100) NOT NULL,
	[Body] VARCHAR (255) NOT NULL
)

CREATE TRIGGER tr_NotificationEmailForNewInsertedRecord
            ON [Logs]
    FOR INSERT
            AS

BEGIN
   INSERT INTO [NotificationEmails]([Recipient], [Subject], [Body])
        SELECT [i].[AccountId],
		       'Balance change for account: ' + CAST([i].[AccountId] AS VARCHAR),
			   'On' + CAST(GETDATE()AS VARCHAR) + 'your balance was changed from ' + 
			   CAST([i].[OldSum] AS VARCHAR) + 'to ' + CAST([i].[NewSum] AS VARCHAR)
		  FROM [inserted] AS [i]
END


-- Task 03. Deposit Money
 CREATE PROCEDURE usp_DepositMoney (@AccountId INT, @MoneyAmount DECIMAL (15, 4))
               AS
BEGIN TRANSACTION

IF(SELECT [Id] FROM Accounts WHERE [Id] = @AccountId) IS NULL
BEGIN
	ROLLBACK
	RAISERROR ('Invalid Id', 16, 1)
	RETURN
END

IF(@MoneyAmount < 0)
BEGIN
	ROLLBACK
	RAISERROR ('Negative money', 16, 1)
	RETURN
END

UPDATE [Accounts]
   SET [Balance] += @MoneyAmount
 WHERE [Id] = @AccountId
COMMIT


-- Task 04.Withdraw Money Procedure
 CREATE PROCEDURE usp_WithdrawMoney (@AccountId INT, @MoneyAmount DECIMAL (15, 4))
               AS
BEGIN TRANSACTION

IF(SELECT [Id] 
     FROM [Accounts] 
	WHERE [Id] = @AccountId) = 0
BEGIN
	ROLLBACK
	RAISERROR ('Invalid Id', 16, 1)
	RETURN
END

IF(@MoneyAmount < 0)
BEGIN
	ROLLBACK
	RAISERROR ('Negative money', 16, 1)
	RETURN
END

DECLARE @accountMoney DECIMAL(15, 4) = (SELECT [Balance] 
                                          FROM [Accounts]
                                         WHERE [Id] = @AccountId)

IF @accountMoney - @MoneyAmount < 0
BEGIN
	ROLLBACK
	RAISERROR ('Insufficient money', 16, 1)
	RETURN
END

UPDATE [Accounts]
   SET [Balance] -= @MoneyAmount
 WHERE [Id] = @AccountId

COMMIT


-- Task 05. Money Transfer
 CREATE PROCEDURE usp_TransferMoney(@SenderId INT, @ReceiverId INT, @Amount DECIMAL (15, 4))
               AS
BEGIN TRANSACTION

IF @Amount < 0
BEGIN
	ROLLBACK
	RAISERROR ('Negative money', 16, 1)
	RETURN
END

EXEC usp_WithdrawMoney @SenderId, @Amount
EXEC usp_DepositMoney @ReceiverId, @Amount

COMMIT