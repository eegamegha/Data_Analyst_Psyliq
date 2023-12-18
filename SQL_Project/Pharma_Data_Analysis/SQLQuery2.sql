SELECT * FROM Pharma_data;


SELECT COUNT(DISTINCT Country) AS UniqueCountriesCount
FROM Pharma_data;


SELECT Customer_Name
FROM Pharma_data
WHERE Channel = 'Retail';


SELECT SUM(Quantity) AS TotalQuantity
FROM Pharma_data
WHERE Product_Class = 'Antibiotics';


SELECT DISTINCT Month
FROM Pharma_data;


SELECT Year,SUM(Sales) AS TotalSales
FROM Pharma_data
GROUP BY Year;


SELECT TOP 1 Customer_Name,MAX(Sales) AS HighestSales
FROM Pharma_data
GROUP BY Customer_Name
ORDER BY HighestSales DESC;


SELECT DISTINCT(a.[Name_of_Sales_Rep]) 
FROM pharma_data a 
JOIN pharma_data m ON a.Manager = m.[Name_of_Sales_Rep] 
WHERE m.Manager = 'James Goodwill' 
 AND a.[Sales_Team] = 'Sales Rep'; 


 SELECT TOP 5 City,SUM(Sales) AS HighestSales
 FROM Pharma_data
 GROUP BY City
 ORDER BY HighestSales DESC;


 SELECT Sub_channel,AVG(Price) AS AveragePrice
 FROM Pharma_data 
 GROUP BY Sub_channel;


--SELECT e.Employee_Name, p.*
--FROM Employees AS e
--JOIN pharma_data AS p ON e.Name_of_Sales_Rep = p.Name_of_Sales_Rep;


SELECT *
FROM Pharma_data
WHERE City = 'Rendsburg' AND Year = '2018';


SELECT Year,Month,Product_Class
FROM Pharma_data
GROUP BY Year,Month,Product_Class
ORDER BY Year,Month,Product_Class;


SELECT TOP 3 Name_of_Sales_Rep,SUM(Sales) AS HighestSales
FROM Pharma_data
WHERE Year = 2019
GROUP BY Name_of_Sales_Rep
ORDER BY HighestSales;


WITH MonthlyTotalSales AS (
    SELECT 
        Year AS SalesYear,
        Month AS SalesMonth,
        Sub_channel,
        SUM(Sales) AS MonthlySales
    FROM Pharma_data
    GROUP BY Year,Month,Sub_channel
),
AverageMonthlySales AS (
    SELECT 
        Sub_channel,
        AVG(MonthlySales) AS AvgMonthlySales
    FROM MonthlyTotalSales
    GROUP BY Sub_channel
)
SELECT 
    Sub_channel,
    AVG(AvgMonthlySales) AS AverageMonthlySales
FROM AverageMonthlySales
GROUP BY Sub_channel;


SELECT 
    Product_Class,
    SUM(Sales) AS TotalSales,
    AVG(Price) AS AveragePrice,
    SUM(Quantity) AS TotalQuantity
FROM Pharma_data
GROUP BY Product_Class;


WITH RankedSales AS (
	SELECT Customer_Name,Year AS SalesYear,SUM(Sales) AS TotalSales,
	ROW_NUMBER() OVER(PARTITION BY Year ORDER BY SUM(Sales) DESC) AS SalesRank
	FROM Pharma_data
	GROUP BY Customer_Name,Year
)
SELECT Customer_Name,SalesYear,TotalSales
FROM RankedSales
WHERE SalesRank <=5;


WITH SalesByYear AS (
	SELECT Year As SalesYear,Country,SUM(Sales) AS TotalSales
	FROM Pharma_data
	GROUP BY Year,Country
)
SELECT Country,SalesYear,TotalSales,
LAG(TotalSales) OVER(PARTITION BY Country ORDER BY SalesYear) AS PreviousYearSales,
CASE
	WHEN LAG(TotalSales) OVER(PARTITION BY Country ORDER BY SalesYear) IS NULL THEN NULL
	ELSE (TotalSales -LAG(TotalSales) OVER(PARTITION BY Country ORDER BY SalesYear)) / LAG(TotalSales) OVER (PARTITION BY Country ORDER BY SalesYear) *100
END AS YearOverYearGrowth
FROM SalesByYear
ORDER BY Country,SalesYear;


SELECT Year, Month, MIN(Sales) AS LowestSales
FROM Pharma_data
GROUP BY Year, Month
ORDER BY Year;


WITH SubChannelSales AS (
    SELECT
        Country,Sub_channel,SUM(Sales) AS TotalSales,
        RANK() OVER(PARTITION BY Sub_Channel ORDER BY SUM(Sales) DESC) AS CountryRank
    FROM Pharma_data
    GROUP BY Country,Sub_Channel
)
SELECT Country,Sub_Channel,TotalSales,CountryRank
FROM SubChannelSales
WHERE CountryRank = 1
ORDER BY Sub_Channel;
