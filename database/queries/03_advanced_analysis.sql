USE salespulse;

-- 1. Sales representative performance
SELECT
    sr.rep_id,
    CONCAT(sr.first_name, ' ', sr.last_name) AS sales_rep,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity * o.unit_price) AS total_revenue,
    AVG(o.quantity * o.unit_price) AS avg_order_value
FROM orders o
JOIN opportunities op
    ON o.opportunity_id = op.opportunity_id
JOIN sales_reps sr
    ON op.sales_rep_id = sr.rep_id
GROUP BY sr.rep_id, sr.first_name, sr.last_name
ORDER BY total_revenue DESC;


-- 2. Revenue by category
SELECT
    p.category,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS units_sold,
    SUM(o.quantity * o.unit_price) AS revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;


-- 3. Monthly revenue
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(order_id) AS total_orders,
    SUM(quantity * unit_price) AS revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;


-- 4. Top 10 products
SELECT
    p.product_name,
    p.category,
    SUM(o.quantity) AS units_sold,
    SUM(o.quantity * o.unit_price) AS revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;