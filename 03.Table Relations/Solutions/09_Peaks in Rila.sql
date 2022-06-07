SELECT [MountainRange], [PeakName], [Elevation]
  FROM [Mountains]
  JOIN [Peaks]
    ON Mountains.Id = Peaks.MountainId
 WHERE [MountainRange] = 'Rila'
 Order BY [Elevation] DESC