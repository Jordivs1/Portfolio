-- Vraag 1: Hoeveel medewerkers zijn er weggegaan vs gebleven?
SELECT attrition, COUNT(attrition) AS count_attrition
FROM HREmployeeAttrition
GROUP BY attrition;

-- Vraag 2: Wat is de gemiddelde leeftijd per afdeling?
SELECT department, AVG(age) AS average_age
FROM HREmployeeAttrition
GROUP BY department;

-- Vraag 3: Wat is het gemiddeld maandinkomen per functie?
SELECT jobrole, AVG(monthlyincome) AS average_monthlyincome
FROM HREmployeeAttrition
GROUP BY jobrole;

-- Vraag 4: Hoeveel medewerkers werken overuren?
SELECT overtime, COUNT(overtime) AS overtime_count
FROM HREmployeeAttrition
WHERE overtime = 'Yes';

-- Vraag 5: Wat is de verdeling van geslacht per afdeling?
SELECT department, gender, COUNT(gender) AS count_of_gender
FROM HREmployeeAttrition
GROUP BY department, gender;

-- Vraag 6: Wat is het gemiddeld inkomen van medewerkers die zijn weggegaan vs gebleven?
SELECT attrition, AVG(monthlyincome) AS average_income
FROM HREmployeeAttrition
GROUP BY attrition;

-- Vraag 7: Hoeveel medewerkers per opleidingsniveau zijn weggegaan?
SELECT education, attrition, COUNT(attrition) AS count_attrition
FROM HREmployeeAttrition
GROUP BY education, attrition;

-- Vraag 8: Wat is de gemiddelde afstand tot werk per afdeling?
SELECT department, AVG(distancefromhome) AS distance_to_work
FROM HREmployeeAttrition
GROUP BY department;

-- Vraag 9: Welke functie heeft de hoogste werktevredenheid?
SELECT jobrole, AVG(jobsatisfaction) AS average_satisfaction
FROM HREmployeeAttrition
GROUP BY jobrole
ORDER BY average_satisfaction DESC
LIMIT 1;

-- Vraag 10: Wat is het gemiddeld aantal jaren bij het bedrijf per jobniveau?
SELECT joblevel, AVG(totalworkingyears) AS avg_years_working
FROM HREmployeeAttrition
GROUP BY joblevel;

-- Vraag 11: Wat is het percentage vertrek per afdeling?
SELECT attrition, COUNT(attrition) * 100 / (
    SELECT COUNT(attrition)
    FROM HREmployeeAttrition) AS percentage_of_attrition
FROM HREmployeeAttrition
GROUP BY attrition;

-- Vraag 12: Welke medewerkers verdienen meer dan het gemiddelde salaris?
SELECT employeenumber
FROM HREmployeeAttrition
WHERE monthlyincome > (
    SELECT AVG(monthlyincome)
    FROM HREmployeeAttrition);

-- Vraag 13: Wat is de verdeling van werktevredenheid per leeftijdscategorie?
SELECT AVG(jobsatisfaction) AS avg_satisfaction,
CASE
    WHEN age < 30 THEN 'Young'
    WHEN age BETWEEN 30 AND 50 THEN 'Middle'
    WHEN age > 50 THEN 'Old'
END AS age_selection
FROM HREmployeeAttrition
GROUP BY age_selection;

-- Vraag 14: Welke afdeling heeft de hoogste gemiddelde salarisstijging?
SELECT department, AVG(percentsalaryhike) AS percentage_salary_hike
FROM HREmployeeAttrition
GROUP BY department
ORDER BY percentage_salary_hike DESC
LIMIT 1;

-- Vraag 15: Hoeveel medewerkers hebben meer dan 5 jaar geen promotie gehad?
SELECT COUNT(yearssincelastpr) AS years_sincelastpromotion
FROM HREmployeeAttrition
WHERE yearssincelastpr > 5;

-- Vraag 16: Wat is het gemiddeld inkomen per geslacht en afdeling?
SELECT department, gender, AVG(monthlyincome) AS avg_income
FROM HREmployeeAttrition
GROUP BY department, gender;

-- Vraag 17: Welke medewerkers hebben zowel een lage werktevredenheid als overuren?
SELECT employeenumber, jobsatisfaction, overtime
FROM HREmployeeAttrition
WHERE jobsatisfaction < 3
AND overtime = 'Yes';

-- Vraag 18: Wat is de correlatie tussen reisfrequentie en vertrek?
SELECT BusinessTravel, Attrition, COUNT(*) AS total
FROM HREmployeeAttrition
GROUP BY BusinessTravel, Attrition;

-- Vraag 19: Welke jobrollen hebben een bovengemiddeld vertrekpercentage?
SELECT jobrole,
COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100 / COUNT(*) AS percentage_of_attrition
FROM HREmployeeAttrition
GROUP BY jobrole
ORDER BY percentage_of_attrition DESC;

-- Vraag 20: Wat is de gemiddelde salarisgroei per functieniveau?
SELECT joblevel, AVG(percentsalaryhike) AS percentage_salary_hike
FROM HREmployeeAttrition
GROUP BY joblevel
ORDER BY joblevel;