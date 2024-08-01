SELECT *
FROM PortfolioProject..US_Chronic_Disease_Indicators

SELECT *
FROM PortfolioProject..US_Chronic_Disease_Indicators
WHERE Question = 'Life expectancy at birth'
AND Stratification1 IN ('Male', 'Female')
ORDER BY YearStart, LocationDesc

SELECT *
FROM PortfolioProject..US_Chronic_Disease_Indicators
WHERE Question = 'Diabetes Among Adults'
AND Stratification1 IN ('Male', 'Female')
AND DataValueType = 'Age-adjusted Prevalence'
ORDER BY YearStart, LocationDesc

SELECT *
FROM PortfolioProject..US_Chronic_Disease_Indicators
WHERE Question = 'Colon and rectum (colorectal) cancer mortality among all people, underlying cause'
--AND LocationDesc = 'Alabama'
AND DataValueType = 'Number'
AND YearStart = '2016'
ORDER BY YearStart, LocationDesc

SELECT *
FROM PortfolioProject..US_Chronic_Disease_Indicators
WHERE Question = 'Colon and rectum (colorectal) cancer mortality among all people, underlying cause'
AND DataValueType = 'Age-Adjusted Rate'
AND YearStart = '2016'
ORDER BY YearStart, LocationDesc

SELECT *
FROM PortfolioProject..US_Chronic_Disease_Indicators
WHERE Question = 'Invasive cancer (all sites combined), incidence'
--AND LocationDesc = 'Alabama'
AND DataValueType = 'Age-Adjusted Rate'
AND YearStart = '2016'
ORDER BY YearStart, LocationDesc

SELECT *
FROM PortfolioProject..US_Chronic_Disease_Indicators
WHERE Topic = 'Cancer'
--AND LocationDesc = 'Alabama'
AND DataValueType = 'Age-Adjusted Rate'
--AND YearStart = '2016'
ORDER BY YearStart, LocationDesc

SELECT *
FROM PortfolioProject..US_Chronic_Disease_Indicators
WHERE Topic = 'Cardiovascular Disease'
AND Question = 'High blood pressure among adults'
--AND LocationDesc = 'Alabama'
AND DataValueType = 'Age-Adjusted Prevalence'
--AND YearStart = '2016'
ORDER BY YearStart, LocationDesc

