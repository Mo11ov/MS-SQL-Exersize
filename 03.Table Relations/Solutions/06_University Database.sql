CREATE TABLE [Majors](
			 [MajorID] INT PRIMARY KEY,
			 [Name] NVARCHAR (50) NOT NULL
)

CREATE TABLE [Students](
			 [StudentID] INT PRIMARY KEY,
			 [StudentNumber] INT NOT NULL,
			 [StudentName] NVARCHAR (50) NOT NULL,
			 [MajorID] INT FOREIGN KEY REFERENCES [Majors] (MajorID) NOT NULL
)

CREATE TABLE [Payments](
			 [PaymentID] INT PRIMARY KEY,
			 [PaymentDate] DATE NOT NULL,
			 [PaymentAmount] DECIMAL (8, 2) NOT NULL,
			 [StudentID] INT FOREIGN KEY REFERENCES [Students] (StudentID) NOT NULL
)

CREATE TABLE [Subjects](
			 [SubjectID] INT PRIMARY KEY,
			 [SubjectName] NVARCHAR (50) NOT NULL
)

CREATE TABLE [Agenda](
			 [StudentID] INT FOREIGN KEY REFERENCES [Students] ([StudentID]),
			 [SubjectID] INT FOREIGN KEY REFERENCES [Subjects] ([SubjectID]),
			 PRIMARY KEY ([StudentID], [SubjectID])
)