-- Question 1: How many unique customers are there per country?
SELECT country, COUNT(DISTINCT customerid) AS customer_count
FROM orders
GROUP BY country;

-- Question 2: How many unique products are there?
SELECT COUNT(DISTINCT description) AS product_count
FROM products;

-- Question 3: What are the top 5 best-selling products by quantity?
SELECT description, SUM(quantity) AS product_count
FROM products
GROUP BY description
ORDER BY product_count DESC
LIMIT 5;

-- Question 4: What is the average price per product?
SELECT AVG(unitprice) AS average_product_price
FROM products;

-- Question 5: How many orders are there per month?
SELECT
    substr(invoicedate, 1, instr(invoicedate, '/') - 1) AS month,
    COUNT(invoiceno) AS order_count
FROM orders
GROUP BY month
ORDER BY CAST(month AS INTEGER);

-- Question 6: What is the total revenue per country?
SELECT orders.country, SUM(products.quantity * products.unitprice) AS total_revenue
FROM orders
INNER JOIN products
    ON products.invoiceno = orders.invoiceno
GROUP BY orders.country;

-- Question 7: Which customer has spent the most?
SELECT orders.customerid, SUM(products.quantity * products.unitprice) AS total_spend
FROM orders
INNER JOIN products
    ON products.invoiceno = orders.invoiceno
WHERE orders.customerid IS NOT NULL
GROUP BY customerid
ORDER BY total_spend DESC
LIMIT 1;

-- Question 8: What is the total revenue per product, including country?
SELECT orders.country, products.description, SUM(products.quantity * products.unitprice) AS total_revenue
FROM orders
INNER JOIN products
    ON orders.invoiceno = products.invoiceno
GROUP BY country, description;

-- Question 9: Which countries placed more than 1000 orders?
SELECT country, COUNT(orders.invoiceno) AS order_count
FROM orders
GROUP BY country
HAVING order_count > 1000;

-- Question 10: How many unique products are there per order?
SELECT invoiceno, COUNT(DISTINCT description) AS unique_products
FROM products
GROUP BY invoiceno;

-- Question 11: What is the average order value per country?
SELECT orders.country, SUM(products.quantity * products.unitprice) / COUNT(DISTINCT orders.invoiceno) AS avg_order_value
FROM orders
INNER JOIN products
    ON orders.invoiceno = products.invoiceno
GROUP BY orders.country;

-- Question 12: Which products were ordered by customers from the United Kingdom?
SELECT orders.country, products.description
FROM orders
RIGHT JOIN products
    ON orders.invoiceno = products.invoiceno
WHERE orders.country = 'United Kingdom';

-- Question 13: Which customers ordered more than 10 different products?
SELECT orders.customerid, COUNT(DISTINCT description) AS product_count
FROM orders
JOIN products
    ON orders.invoiceno = products.invoiceno
GROUP BY orders.customerid
HAVING product_count > 10;

-- Question 14: What is the total revenue per quarter?
SELECT SUM(products.quantity * products.unitprice) AS total_revenue,
    CASE
        WHEN 0 + CAST(substr(invoicedate, 1, instr(invoicedate, '/') - 1) AS INTEGER) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN 0 + CAST(substr(invoicedate, 1, instr(invoicedate, '/') - 1) AS INTEGER) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN 0 + CAST(substr(invoicedate, 1, instr(invoicedate, '/') - 1) AS INTEGER) BETWEEN 7 AND 9 THEN 'Q3'
        WHEN 0 + CAST(substr(invoicedate, 1, instr(invoicedate, '/') - 1) AS INTEGER) BETWEEN 10 AND 12 THEN 'Q4'
    END AS quarter
FROM orders
JOIN products
    ON products.invoiceno = orders.invoiceno
GROUP BY quarter;

-- Question 15: What percentage of total revenue does each country represent?
SELECT orders.country, SUM(quantity * unitprice) * 100 / (
    SELECT SUM(quantity * unitprice) FROM products) AS total_revenue_percentage
FROM orders
JOIN products
    ON products.invoiceno = orders.invoiceno
GROUP BY orders.country;

-- Question 16: Which customers ordered in both 2010 and 2011?
SELECT customerid, substr(invoicedate, instr(invoicedate, '/') + instr(substr(invoicedate, instr(invoicedate, '/') + 1), '/') + 1, 4) AS year
FROM orders
WHERE year IN ('2010', '2011');

-- Question 17: What is the most expensive order per country?
SELECT orders.country, products.invoiceno, MAX(quantity * unitprice)
FROM products
INNER JOIN orders
    ON orders.invoiceno = products.invoiceno
GROUP BY orders.country;

-- Question 18: Which products were never ordered by customers from Germany?
SELECT orders.country, products.description
FROM orders
RIGHT JOIN products
    ON orders.invoiceno = products.invoiceno
WHERE products.description NOT IN (
    SELECT products.description
    FROM products
    INNER JOIN orders
        ON orders.invoiceno = products.invoiceno
    WHERE orders.country = 'Germany');

-- Question 19: What is the total revenue per customer, including country?
SELECT orders.customerid, orders.country, SUM(products.quantity * products.unitprice) AS total_revenue
FROM orders
INNER JOIN products
    ON products.invoiceno = orders.invoiceno
GROUP BY orders.country, orders.customerid;

-- Question 20: Which customer ordered the largest number of unique products?
SELECT orders.customerid, COUNT(DISTINCT products.description) AS product_count
FROM orders
INNER JOIN products
    ON orders.invoiceno = products.invoiceno
GROUP BY customerid
ORDER BY product_count DESC
LIMIT 1;
