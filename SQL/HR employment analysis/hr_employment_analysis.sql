-- Question 1: How many employees left vs. stayed?
SELECT attrition, COUNT(attrition) AS count_attrition
FROM HREmployeeAttrition
GROUP BY attrition;

-- Question 2: What is the average age per department?
SELECT department, AVG(age) AS average_age
FROM HREmployeeAttrition
GROUP BY department;

-- Question 3: What is the average monthly income per job role?
SELECT jobrole, AVG(monthlyincome) AS average_monthlyincome
FROM HREmployeeAttrition
GROUP BY jobrole;

-- Question 4: How many employees work overtime?
SELECT overtime, COUNT(overtime) AS overtime_count
FROM HREmployeeAttrition
WHERE overtime = 'Yes';

-- Question 5: What is the gender distribution per department?
SELECT department, gender, COUNT(gender) AS count_of_gender
FROM HREmployeeAttrition
GROUP BY department, gender;

-- Question 6: What is the average income of employees who left vs. stayed?
SELECT attrition, AVG(monthlyincome) AS average_income
FROM HREmployeeAttrition
GROUP BY attrition;

-- Question 7: How many employees per education level left?
SELECT education, attrition, COUNT(attrition) AS count_attrition
FROM HREmployeeAttrition
GROUP BY education, attrition;

-- Question 8: What is the average distance from home per department?
SELECT department, AVG(distancefromhome) AS distance_to_work
FROM HREmployeeAttrition
GROUP BY department;

-- Question 9: Which job role has the highest job satisfaction?
SELECT jobrole, AVG(jobsatisfaction) AS average_satisfaction
FROM HREmployeeAttrition
GROUP BY jobrole
ORDER BY average_satisfaction DESC
LIMIT 1;

-- Question 10: What is the average number of years at the company per job level?
SELECT joblevel, AVG(totalworkingyears) AS avg_years_working
FROM HREmployeeAttrition
GROUP BY joblevel;

-- Question 11: What is the attrition percentage per department?
SELECT attrition, COUNT(attrition) * 100 / (
    SELECT COUNT(attrition)
    FROM HREmployeeAttrition) AS percentage_of_attrition
FROM HREmployeeAttrition
GROUP BY attrition;

-- Question 12: Which employees earn more than the average salary?
SELECT employeenumber
FROM HREmployeeAttrition
WHERE monthlyincome > (
    SELECT AVG(monthlyincome)
    FROM HREmployeeAttrition);

-- Question 13: What is the distribution of job satisfaction per age category?
SELECT AVG(jobsatisfaction) AS avg_satisfaction,
CASE
    WHEN age < 30 THEN 'Young'
    WHEN age BETWEEN 30 AND 50 THEN 'Middle'
    WHEN age > 50 THEN 'Old'
END AS age_selection
FROM HREmployeeAttrition
GROUP BY age_selection;

-- Question 14: Which department has the highest average salary increase?
SELECT department, AVG(percentsalaryhike) AS percentage_salary_hike
FROM HREmployeeAttrition
GROUP BY department
ORDER BY percentage_salary_hike DESC
LIMIT 1;

-- Question 15: How many employees have gone more than 5 years without a promotion?
SELECT COUNT(yearssincelastpr) AS years_sincelastpromotion
FROM HREmployeeAttrition
WHERE yearssincelastpr > 5;

-- Question 16: What is the average income per gender and department?
SELECT department, gender, AVG(monthlyincome) AS avg_income
FROM HREmployeeAttrition
GROUP BY department, gender;

-- Question 17: Which employees have both low job satisfaction and work overtime?
SELECT employeenumber, jobsatisfaction, overtime
FROM HREmployeeAttrition
WHERE jobsatisfaction < 3
AND overtime = 'Yes';

-- Question 18: What is the relationship between travel frequency and attrition?
SELECT BusinessTravel, Attrition, COUNT(*) AS total
FROM HREmployeeAttrition
GROUP BY BusinessTravel, Attrition;

-- Question 19: Which job roles have an above-average attrition rate?
SELECT jobrole,
COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100 / COUNT(*) AS percentage_of_attrition
FROM HREmployeeAttrition
GROUP BY jobrole
ORDER BY percentage_of_attrition DESC;

-- Question 20: What is the average salary growth per job level?
SELECT joblevel, AVG(percentsalaryhike) AS percentage_salary_hike
FROM HREmployeeAttrition
GROUP BY joblevel
ORDER BY joblevel;
