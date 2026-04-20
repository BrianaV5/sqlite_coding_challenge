--Tool used: VS Code with SQLite Viewer extension (Florian Klampfer)
--Validation: Ran each query by right-clicking challenge.sql and using 
--"Run Query" to check results agaisnt the database

-- TASK 1: TOP 5 Customers by Total Spend
SELECT c.first_name || ' ' || c.last_name AS customer_name, SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
GROUP BY c.id, customer_name
ORDER BY total_spend DESC
LIMIT 5;

--TASK 2: Total Revenue by Product Category (All Orders)
SELECT p.category, SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON p.id = oi.product_id
GROUP BY p.category 
ORDER BY revenue DESC;

--Task 3: Employees Earning Above their Department Average
SELECT e.first_name, e.last_name, d.name AS department_name, e.salary AS employee_salary, ROUND(dept_avg.avg_salary, 2) AS department_average
FROM employees e
JOIN departments d ON d.id = e.department_id
JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_avg ON dept_avg.department_id = e.department_id
WHERE e.salary > dept_avg.avg_salary
ORDER BY d.name, e.salary DESC;

--Task 4: Cities with the Most Gold Loyalty Customers
SELECT city, COUNT(*) AS gold_customer_count
FROM customers
WHERE loyalty_level = 'Gold'
GROUP BY city
ORDER BY gold_customer_count DESC, city ASC;

--Task 4 Extension: Full Loyalty Distribution by City 
SELECT city, SUM(CASE WHEN loyalty_level = 'Gold' THEN 1 ELSE 0 END) AS gold_count,
SUM(CASE WHEN loyalty_level = 'Silver' THEN 1 ELSE 0 END) AS silver_count,
SUM(CASE WHEN loyalty_level = 'Bronze' THEN 1 ELSE 0 END) AS bronze_count
FROM customers
GROUP BY city
ORDER BY gold_count DESC, city ASC;
