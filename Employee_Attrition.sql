create database employee_attrition
go
use employee_attrition

--1. Total employees and attrition rate
SELECT 
    COUNT(*) AS EmployeeCount,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS Total_Attrition,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Percentage
FROM employee_attritions;

select * from employee_attritions

 --2. Attrition by Department

SELECT 
    Department,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS Attrition_Count,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM employee_attritions
GROUP BY Department
ORDER BY Attrition_Rate DESC;


--3. Attrition by Age Group

SELECT 
    CASE 
        WHEN Age < 30 THEN '<30'
        WHEN Age BETWEEN 30 AND 40 THEN '30-40'
        ELSE '>40'
    END AS AgeGroup,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS Attrition_Count,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM employee_attritions
GROUP BY 
    CASE 
        WHEN Age < 30 THEN '<30'
        WHEN Age BETWEEN 30 AND 40 THEN '30-40'
        ELSE '>40'
    END;

    --4. Attrition by OverTime and Income Level
    
    SELECT 
    OverTime,
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low'
        WHEN MonthlyIncome < 7000 THEN 'Medium'
        ELSE 'High'
    END AS Income_Bucket,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS Attrition_Count,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM employee_attritions
GROUP BY OverTime,
         CASE 
            WHEN MonthlyIncome < 3000 THEN 'Low'
            WHEN MonthlyIncome < 7000 THEN 'Medium'
            ELSE 'High'
         END
ORDER BY OverTime, Attrition_Rate DESC;


--Top 10 Job Roles with Highest Attrition Rate
SELECT 
    JobRole,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS Attrition_Count,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM employee_attritions
GROUP BY JobRole
ORDER BY Attrition_Rate DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
