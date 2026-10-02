-- Overzicht van de dataset
SELECT *
FROM BankChurners;

-- Vraag 1: Hoeveel klanten zijn er weggegaan vs gebleven?
SELECT attrition_flag, COUNT(attrition_flag)
FROM BankChurners
GROUP BY attrition_flag;

-- Vraag 2: Wat is de gemiddelde leeftijd per kaartype?
SELECT card_category, AVG(customer_age)
FROM BankChurners
GROUP BY card_category;

-- Vraag 3: Wat is de gemiddelde kredietlimiet per inkomenscategorie?
SELECT income_category, AVG(credit_limit) 
FROM BankChurners
GROUP BY income_category;

-- Vraag 4: Hoeveel klanten per opleidingsniveau zijn weggegaan?
SELECT education_level, COUNT(attrition_flag)
FROM BankChurners
WHERE attrition_flag LIKE 'Attrited%'
GROUP BY education_level;

-- Vraag 5: Wat is de gemiddelde kredietlimiet van weggegane klanten vs gebleven klanten?
SELECT attrition_flag, AVG(credit_limit)
FROM BankChurners
GROUP BY attrition_flag;

-- Vraag 6: Welke top 5 klanten hebben de hoogste kredietlimiet?
SELECT clientnum, credit_limit
FROM BankChurners
ORDER BY credit_limit DESC
LIMIT 5;

-- Vraag 7: Wat is het percentage weggegane klanten per geslacht?
SELECT gender, COUNT(attrition_flag) * 100 / (
    SELECT COUNT(attrition_flag)
    FROM BankChurners)
FROM BankChurners
GROUP BY gender;

-- Vraag 8: Wat is de gemiddelde inactiviteitsperiode van weggegane klanten vs gebleven klanten?
SELECT attrition_flag, AVG(months_inactive)
FROM BankChurners
GROUP BY attrition_flag;

-- Vraag 9: Welke inkomenscategorie heeft de hoogste gemiddelde transactiewaarde?
SELECT income_category, AVG(total_trans_amt)
FROM BankChurners
GROUP BY income_category;

-- Vraag 10: Hoeveel klanten hebben meer dan 10 transacties gemaakt en zijn toch weggegaan?
SELECT COUNT(clientnum) AS total_customers_left
FROM BankChurners
WHERE total_trans_ct > 10 
AND attrition_flag = 'Attrited Customer';

-- Vraag 11: Wat is de verdeling van kaarttypes per geslacht?
SELECT gender, card_category, COUNT(card_category)
FROM BankChurners
GROUP BY gender, card_category;

-- Vraag 12: Wat is de gemiddelde kredietlimiet van klanten die meer dan 3 maanden inactief zijn geweest?
SELECT AVG(credit_limit) AS average_credit_limit
FROM BankChurners
WHERE months_inactive > 3;

-- Vraag 13: Wat is de totale transactiewaarde per burgerlijke staat?
SELECT marital_status, SUM(total_trans_amt)
FROM BankChurners
GROUP BY marital_status;

-- Vraag 14: Welke klanten hebben een kredietlimiet boven het gemiddelde én zijn weggegaan?
SELECT clientnum, credit_limit
FROM BankChurners
WHERE credit_limit > (
    SELECT AVG(credit_limit)
    FROM BankChurners)
AND attrition_flag = 'Attrited Customer';

-- Vraag 15: Wat is het gemiddeld aantal contactmomenten van weggegane klanten vs gebleven klanten?
SELECT attrition_flag, AVG(contacts_count_1) AS avg_number_of_contacts
FROM BankChurners
GROUP BY attrition_flag;

-- Vraag 16: Wat is de verdeling van kaarttypes per inkomenscategorie?
SELECT income_category, card_category, COUNT(card_category) AS number_of_cards
FROM BankChurners
GROUP BY income_category, card_category;

-- Vraag 17: Welke leeftijdscategorie heeft de hoogste churn rate?
SELECT attrition_flag, COUNT(attrition_flag),
CASE 
    WHEN customer_age < 30 THEN 'Young'
    WHEN customer_age BETWEEN 30 AND 50 THEN 'Middle age'
    WHEN customer_age > 50 THEN 'Old' 
END AS age_selection
FROM BankChurners
GROUP BY age_selection, attrition_flag;

-- Vraag 18: Wat is de gemiddelde utilisatierate per kaartype?
SELECT card_category, AVG(avg_utilization) AS average_utilization
FROM BankChurners
GROUP BY card_category;

-- Vraag 19: Wat is de gemiddelde transactiewaarde per aantal contactmomenten?
SELECT contacts_count_1, AVG(total_trans_ct) AS average_transaction_value
FROM BankChurners
GROUP BY contacts_count_1;

-- Vraag 20: Wat is het percentage klanten per inkomenscategorie dat is weggegaan?
SELECT income_category, COUNT(clientnum) * 100 / (
    SELECT COUNT(clientnum)
    FROM BankChurners) AS percentage
FROM BankChurners
WHERE attrition_flag = 'Attrited Customer'
GROUP BY income_category;