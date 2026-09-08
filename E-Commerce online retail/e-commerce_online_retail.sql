-- Vraag 1: Hoeveel unieke klanten zijn er per land?
SELECT country, COUNT(DISTINCT customerid) AS customer_count
FROM orders
GROUP BY country;

-- Vraag 2: Hoeveel unieke producten zijn er?
SELECT COUNT(DISTINCT description) AS product_count
FROM products;

-- Vraag 3: Wat zijn de top 5 best verkochte producten op basis van aantal?
SELECT description, SUM(quantity) AS product_count
FROM products
GROUP BY description
ORDER BY product_count DESC
LIMIT 5;

-- Vraag 4: Wat is de gemiddelde prijs per product?
SELECT AVG(unitprice) AS average_product_price
FROM products;

-- Vraag 5: Hoeveel orders zijn er per maand?
SELECT 
    substr(invoicedate, 1, instr(invoicedate, '/') - 1) AS month,
    COUNT(invoiceno) AS order_count
FROM orders
GROUP BY month
ORDER BY CAST(month AS INTEGER);

-- Vraag 6: Wat is de totale omzet per land?
SELECT orders.country, SUM(products.quantity * products.unitprice) AS total_revenue
FROM orders
INNER JOIN products 
    ON products.invoiceno = orders.invoiceno
GROUP BY orders.country;

-- Vraag 7: Welke klant heeft het meeste uitgegeven?
SELECT orders.customerid, SUM(products.quantity * products.unitprice) AS total_spend
FROM orders
INNER JOIN products
    ON products.invoiceno = orders.invoiceno
WHERE orders.customerid IS NOT NULL
GROUP BY customerid
ORDER BY total_spend DESC
LIMIT 1;

-- Vraag 8: Wat is de totale omzet per product inclusief land?
SELECT orders.country, products.description, SUM(products.quantity * products.unitprice) AS total_revenue
FROM orders 
INNER JOIN products
    ON orders.invoiceno = products.invoiceno
GROUP BY country, description;

-- Vraag 9: Welke landen hebben meer dan 1000 orders geplaatst?
SELECT country, COUNT(orders.invoiceno) AS order_count
FROM orders
GROUP BY country
HAVING order_count > 1000;

-- Vraag 10: Hoeveel unieke producten zijn er per order?
SELECT invoiceno, COUNT(DISTINCT description) AS unique_products
FROM products
GROUP BY invoiceno;

-- Vraag 11: Wat is de gemiddelde orderwaarde per land?
SELECT orders.country, SUM(products.quantity * products.unitprice) / COUNT(DISTINCT orders.invoiceno) AS avg_order_value
FROM orders
INNER JOIN products 
    ON orders.invoiceno = products.invoiceno
GROUP BY orders.country;

-- Vraag 12: Welke producten zijn besteld door klanten uit het Verenigd Koninkrijk?
SELECT orders.country, products.description
FROM orders 
RIGHT JOIN products
    ON orders.invoiceno = products.invoiceno
WHERE orders.country = 'United Kingdom';

-- Vraag 13: Welke klanten hebben meer dan 10 verschillende producten besteld?
SELECT orders.customerid, COUNT(DISTINCT description) AS product_count
FROM orders
JOIN products
    ON orders.invoiceno = products.invoiceno
GROUP BY orders.customerid
HAVING product_count > 10;

-- Vraag 14: Wat is de totale omzet per kwartaal?
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

-- Vraag 15: Wat is het percentage van de totale omzet per land?
SELECT orders.country, SUM(quantity * unitprice) * 100 / (
    SELECT SUM(quantity * unitprice) FROM products) AS total_revenue_percentage
FROM orders 
JOIN products
    ON products.invoiceno = orders.invoiceno
GROUP BY orders.country;

-- Vraag 16: Welke klanten hebben in zowel 2010 als 2011 besteld?
SELECT customerid, substr(invoicedate, instr(invoicedate, '/') + instr(substr(invoicedate, instr(invoicedate, '/') + 1), '/') + 1, 4) AS year
FROM orders 
WHERE year IN ('2010', '2011');

-- Vraag 17: Wat is de duurste order per land?
SELECT orders.country, products.invoiceno, MAX(quantity * unitprice)
FROM products
INNER JOIN orders
    ON orders.invoiceno = products.invoiceno
GROUP BY orders.country;

-- Vraag 18: Welke producten zijn nooit besteld door klanten uit Duitsland?
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

-- Vraag 19: Wat is de totale omzet per klant inclusief land?
SELECT orders.customerid, orders.country, SUM(products.quantity * products.unitprice) AS total_revenue
FROM orders
INNER JOIN products 
    ON products.invoiceno = orders.invoiceno
GROUP BY orders.country, orders.customerid;

-- Vraag 20: Welke klant heeft het grootste aantal unieke producten besteld?
SELECT orders.customerid, COUNT(DISTINCT products.description) AS product_count
FROM orders
INNER JOIN products
    ON orders.invoiceno = products.invoiceno
GROUP BY customerid
ORDER BY product_count DESC
LIMIT 1;