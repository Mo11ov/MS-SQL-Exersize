  SELECT [c].[CountryCode],
         COUNT([mc].[MountainId]) AS [MountainRanges]
    FROM [Countries] AS c
    JOIN [MountainsCountries] AS mc ON [c].[CountryCode] = [mc].[CountryCode]
   WHERE [c].[CountryCode] IN ('US', 'BG', 'RU')
GROUP BY [c].[CountryCode]