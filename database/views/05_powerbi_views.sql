USE salespulse;

-- ============================================================
-- SalesPulse - Power BI Dashboard Views
-- ============================================================


-- 1. Detailed sales dataset
-- Used as the main dataset for Power BI analysis.

CREATE OR REPLACE VIEW vw_sales_summary AS
SELECT
    o.order_id,
    o.order_date,
    o.quantity,
    o.unit_price,
    o.quantity * o.unit_price AS revenue,

    p.product_id,
    p.product_name,
    p.category,

    sr.rep_id,
    CONCAT(sr.first_name, ' ', sr.last_name) AS sales_rep,
    sr.region

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

JOIN opportunities op
    ON o.opportunity_id = op.opportunity_id

JOIN sales_reps sr
    ON op.sales_rep_id = sr.rep_id;


-- 2. Monthly sales summary
-- Used for revenue trends and monthly KPI analysis.

CREATE OR REPLACE VIEW vw_monthly_sales AS
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS units_sold,
    SUM(quantity * unit_price) AS revenue

FROM orders

GROUP BY DATE_FORMAT(order_date, '%Y-%m')

ORDER BY order_month;


-- 3. Sales representative performance
-- Used for sales-rep performance dashboards.

CREATE OR REPLACE VIEW vw_rep_performance AS
SELECT
    sr.rep_id,
    CONCAT(sr.first_name, ' ', sr.last_name) AS sales_rep,
    sr.region,

    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS units_sold,
    SUM(o.quantity * o.unit_price) AS revenue,
    ROUND(AVG(o.quantity * o.unit_price), 2) AS avg_order_value

FROM orders o

JOIN opportunities op
    ON o.opportunity_id = op.opportunity_id

JOIN sales_reps sr
    ON op.sales_rep_id = sr.rep_id

GROUP BY
    sr.rep_id,
    sr.first_name,
    sr.last_name,
    sr.region;


-- 4. Product performance
-- Used for product/category analysis.

CREATE OR REPLACE VIEW vw_product_performance AS
SELECT
    p.product_id,
    p.product_name,
    p.category,

    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS units_sold,
    SUM(o.quantity * o.unit_price) AS revenue

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY
    p.product_id,
    p.product_name,
    p.category;