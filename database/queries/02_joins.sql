USE salespulse;

SELECT
    sr.rep_id,
    CONCAT(sr.first_name, ' ', sr.last_name) AS sales_rep,
    SUM(o.quantity * o.unit_price) AS total_revenue
FROM orders o
JOIN opportunities op
    ON o.opportunity_id = op.opportunity_id
JOIN sales_reps sr
    ON op.sales_rep_id = sr.rep_id
GROUP BY
    sr.rep_id,
    sr.first_name,
    sr.last_name
ORDER BY total_revenue DESC;