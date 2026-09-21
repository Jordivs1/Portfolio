-- Overview of the dataset
SELECT *
FROM BankChurners;

-- Question 1: How many customers left vs. stayed?
SELECT attrition_flag, COUNT(attrition_flag)
FROM BankChurners
GROUP BY attrition_flag;

-- Question 2: What is the average age per card category?
SELECT card_category, AVG(customer_age)
FROM BankChurners
GROUP BY card_category;

-- Question 3: What is the average credit limit per income category?
SELECT income_category, AVG(credit_limit)
FROM BankChurners
GROUP BY income_category;

-- Question 4: How many customers per education level left?
SELECT education_level, COUNT(attrition_flag)
FROM BankChurners
WHERE attrition_flag LIKE 'Attrited%'
GROUP BY education_level;

-- Question 5: What is the average credit limit of churned vs. retained customers?
SELECT attrition_flag, AVG(credit_limit)
FROM BankChurners
GROUP BY attrition_flag;

-- Question 6: Which top 5 customers have the highest credit limit?
SELECT clientnum, credit_limit
FROM BankChurners
ORDER BY credit_limit DESC
LIMIT 5;
