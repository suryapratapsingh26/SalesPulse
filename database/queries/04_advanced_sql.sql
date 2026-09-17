USE salespulse;

-- 1. Rank sales representatives by revenue
WITH rep_revenue AS (
    SELECT
        sr.rep_id,
        CONCAT(sr.first_name, ' ', sr.last_name) AS sales_rep,
        SUM(o.quantity * o.unit_price) AS revenue
    FROM orders o
    JOIN opportunities op
        ON o.opportunity_id = op.opportunity_id
    JOIN sales_reps sr
        ON op.sales_rep_id = sr.rep_id
    GROUP BY sr.rep_id, sr.first_name, sr.last_name
)
SELECT
    rep_id,
    sales_rep,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM rep_revenue
ORDER BY revenue_rank;


-- 2. Monthly revenue with previous month comparison
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        SUM(quantity * unit_price) AS revenue
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    order_month,
    revenue,
    LAG(revenue) OVER (ORDER BY order_month) AS previous_month_revenue,
    revenue - LAG(revenue) OVER (ORDER BY order_month) AS revenue_change
FROM monthly_sales
ORDER BY order_month;


-- 3. Top 3 products in each category
WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(o.quantity * o.unit_price) AS revenue
    FROM orders o
    JOIN products p
        ON o.product_id = p.product_id
    GROUP BY p.product_id, p.product_name, p.category
),
ranked_products AS (
    SELECT
        product_name,
        category,
        revenue,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS category_rank
    FROM product_revenue
)
SELECT
    product_name,
    category,
    revenue,
    category_rank
FROM ranked_products
WHERE category_rank <= 3
ORDER BY category, category_rank;


-- 4. Overall sales KPIs
SELECT
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_units_sold,
    SUM(quantity * unit_price) AS total_revenue,
    ROUND(AVG(quantity * unit_price), 2) AS average_order_value,
    MIN(quantity * unit_price) AS smallest_order,
    MAX(quantity * unit_price) AS largest_order
FROM orders;