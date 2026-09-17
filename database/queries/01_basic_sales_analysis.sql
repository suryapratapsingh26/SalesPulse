USE salespulse;

-- ============================================
-- SalesPulse - Basic Sales Analysis
-- ============================================


-- 1. Total number of orders
SELECT
    COUNT(*) AS total_orders
FROM orders;


-- 2. Total revenue
SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM orders;


-- 3. Average order value
SELECT
    AVG(quantity * unit_price) AS average_order_value
FROM orders;


-- 4. Total quantity sold
SELECT
    SUM(quantity) AS total_quantity_sold
FROM orders;


-- 5. Revenue by product
SELECT
    p.product_name,
    p.category,
    SUM(o.quantity) AS units_sold,
    SUM(o.quantity * o.unit_price) AS revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY revenue DESC;


-- 6. Revenue by product category
SELECT
    p.category,
    SUM(o.quantity * o.unit_price) AS revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY
    p.category
ORDER BY revenue DESC;


-- 7. Revenue by sales representative
SELECT
    sr.rep_id,
    CONCAT(sr.first_name, ' ', sr.last_name) AS sales_rep,
    SUM(o.quantity * o.unit_price) AS revenue
FROM orders o
JOIN opportunities op
    ON o.opportunity_id = op.opportunity_id
JOIN sales_reps sr
    ON op.sales_rep_id = sr.rep_id
GROUP BY
    sr.rep_id,
    sr.first_name,
    sr.last_name
ORDER BY revenue DESC;


-- 8. Orders by month
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders,
    SUM(quantity * unit_price) AS revenue
FROM orders
GROUP BY
    DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;


-- 9. Revenue by month
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(quantity * unit_price) AS revenue
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;


-- 10. Top 10 products by revenue
SELECT
    p.product_name,
    p.category,
    SUM(o.quantity * o.unit_price) AS revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY revenue DESC
LIMIT 10;
