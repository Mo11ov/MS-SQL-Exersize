CREATE TABLE [Cities](
			 [CityID] INT PRIMARY KEY,
			 [Name] VARCHAR (50) NOT NULL
)

CREATE TABLE [Customers](
			 [CustomerID] INT PRIMARY KEY,
			 [Name] VARCHAR (50) NOT NULL,
			 [Birthday] DATE NOT NULL,
			 [CityID] INT FOREIGN KEY REFERENCES [Cities] (CityID) NOT NULL
)

CREATE TABLE [Orders](
			 [OrderID] INT PRIMARY KEY,
			 [CustomerID] INT FOREIGN KEY REFERENCES [Customers] (CustomerID) NOT NULL
)

CREATE TABLE [ItemTypes](
			 [ItemTypeID] INT PRIMARY KEY,
			 [Name] VARCHAR (50) NOT NULL
)

CREATE TABLE [Items](
			 [ItemID] INT PRIMARY KEY,
			 [Name] VARCHAR NOT NULL,
			 [ItemTypeID] INT FOREIGN KEY REFERENCES [ItemTypes] (ItemTypeID) NOT NULL
)

CREATE TABLE [OrderItems](
			 [OrderID] INT FOREIGN KEY REFERENCES [Orders] ([OrderID]),
			 [ItemID] INT FOREIGN KEY REFERENCES [Items] (ItemID)
			 PRIMARY KEY([OrderID], [ItemID])
)