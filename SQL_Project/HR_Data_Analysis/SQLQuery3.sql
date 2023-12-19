SELECT COUNT(DISTINCT EmployeeID) AS NumberOfEmployees
FROM General_Data;


SELECT DISTINCT JobRole
FROM General_Data;


SELECT AVG(Age) AS Average_Age
FROM General_Data;


SELECT Emp_Name,Age
FROM General_Data
WHERE YearsAtCompany>5;


SELECT COUNT(EmployeeID) AS NumberofEmployees,Department
FROM General_Data
GROUP BY Department;


SELECT g.EmployeeID,g.Emp_Name,e.JobSatisfaction
FROM General_Data g,employee_survey_data e
WHERE JobSatisfaction >=3 AND e.EmployeeID=g.EmployeeID ;



SELECT MAX(MonthlyIncome) AS Highest_Monthly_Income
FROM General_Data;


SELECT EmployeeID,Emp_Name
FROM General_Data
WHERE BusinessTravel = 'Travel_Rarely';


SELECT DISTINCT MaritalStatus AS Marital_status_categories
FROM General_Data;


SELECT EmployeeID,Emp_Name
FROM General_Data
WHERE YearsAtCompany > 2 AND YearsAtCompany < 4;


SELECT EmployeeID,Emp_Name,Current_JobRole,Previous_JobRole,Current_JobLevel,Previous_JobLevel
FROM (
	SELECT EmployeeID,Emp_Name,JobRole AS Current_JobRole,JobLevel AS Current_JobLevel,
	LAG(JobRole) OVER(PARTITION BY EmployeeID ORDER BY YearsAtCompany) AS Previous_JobRole,
	LAG(JobLevel) OVER(PARTITION BY EmployeeID ORDER BY YearsAtCompany) AS Previous_JobLevel
	FROM General_Data
) AS JobChanges
WHERE (Current_JobRole <> Previous_JobRole) or (Current_JobLevel <> Previous_JobLevel);


SELECT Department, AVG(DistanceFromHome) AS Average_Distance_From_Home
FROM General_Data
GROUP BY Department;


SELECT TOP 5 EmployeeID,Emp_Name,MonthlyIncome
FROM General_Data
ORDER BY MonthlyIncome DESC;


WITH Promotion_data AS(
	SELECT 
		COUNT(CASE WHEN YearsSinceLastPromotion <=1 THEN 1 END) AS EmployeesWithPromotionLastYear,
		COUNT(*) AS TotalEmployees
	FROM General_Data
)
SELECT EmployeesWithPromotionLastYear,TotalEmployees,(EmployeesWithPromotionLastYear*100/TotalEmployees) AS PercentagePromotedLastYear
FROM Promotion_data;


SELECT e.EmployeeID,g.Emp_Name,e.EnvironmentSatisfaction
FROM General_Data g
INNER JOIN employee_survey_data e
ON e.EmployeeID=g.EmployeeID
WHERE e.EnvironmentSatisfaction IN (
	SELECT MAX(EnvironmentSatisfaction) 
	FROM employee_survey_data
	UNION
	SELECT MIN(EnvironmentSatisfaction) 
	FROM employee_survey_data
);


SELECT EmployeeID, JobRole, MaritalStatus
FROM general_Data e1
WHERE EXISTS (
    SELECT 1
    FROM general_Data e2
    WHERE e1.EmployeeID <> e2.EmployeeID
    AND e1.JobRole = e2.JobRole
    AND e1.MaritalStatus = e2.MaritalStatus
);


SELECT g.EmployeeID,g.Emp_Name
FROM General_Data g,manager_survey_data m
WHERE m.EmployeeID=g.EmployeeID AND m.PerformanceRating = 4 AND g.TotalWorkingYears = (
SELECT MAX(TotalWorkingYears)
FROM General_Data
);


SELECT AVG(g.Age) AS Average_Age,
AVG(e.JobSatisfaction) AS Average_JobSatisfaction,g.BusinessTravel
FROM General_Data g,employee_survey_data e
WHERE g.EmployeeID=e.EmployeeID
GROUP BY g.BusinessTravel;


SELECT TOP 1 EducationField,COUNT(*) AS FieldCount
FROM General_Data
GROUP BY EducationField
ORDER BY FieldCount DESC;


SELECT EmployeeID,Emp_Name,YearsAtCompany,YearsSinceLastPromotion
FROM General_Data
WHERE YearsSinceLastPromotion = 0 
AND YearsAtCompany = (
SELECT MAX(YearsAtCompany)
FROM General_Data
);
