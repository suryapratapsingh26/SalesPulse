USE salespulse;

-- ============================================
-- SalesPulse - Seed Data
-- ============================================

-- Allow recursive CTEs to generate a large dataset.
SET SESSION cte_max_recursion_depth = 20000;


-- ============================================
-- 1. SALES REPRESENTATIVES
-- ============================================

INSERT IGNORE INTO sales_reps
    (first_name, last_name, email, region, hire_date)
VALUES
    ('Aarav', 'Sharma', 'aarav.sharma@salespulse.com', 'North', '2022-01-15'),
    ('Ananya', 'Patel', 'ananya.patel@salespulse.com', 'West', '2022-03-10'),
    ('Rohan', 'Verma', 'rohan.verma@salespulse.com', 'North', '2022-06-20'),
    ('Priya', 'Iyer', 'priya.iyer@salespulse.com', 'South', '2022-08-05'),
    ('Arjun', 'Mehta', 'arjun.mehta@salespulse.com', 'West', '2023-01-12'),
    ('Sneha', 'Reddy', 'sneha.reddy@salespulse.com', 'South', '2023-04-18'),
    ('Kabir', 'Singh', 'kabir.singh@salespulse.com', 'East', '2023-07-25'),
    ('Ishita', 'Gupta', 'ishita.gupta@salespulse.com', 'North', '2023-09-11'),
    ('Vikram', 'Nair', 'vikram.nair@salespulse.com', 'South', '2024-02-14'),
    ('Meera', 'Joshi', 'meera.joshi@salespulse.com', 'West', '2024-05-22');


-- ============================================
-- 2. PRODUCTS
-- ============================================

INSERT IGNORE INTO products
    (product_name, category, unit_price)
VALUES
    ('CRM Starter', 'CRM', 9999.00),
    ('CRM Professional', 'CRM', 24999.00),
    ('CRM Enterprise', 'CRM', 59999.00),
    ('Marketing Automation', 'Marketing', 19999.00),
    ('Email Campaigns', 'Marketing', 7999.00),
    ('Lead Management', 'Sales', 14999.00),
    ('Sales Automation', 'Sales', 29999.00),
    ('Pipeline Management', 'Sales', 17999.00),
    ('Analytics Basic', 'Analytics', 12999.00),
    ('Analytics Pro', 'Analytics', 34999.00),
    ('Analytics Enterprise', 'Analytics', 69999.00),
    ('Customer Support', 'Support', 15999.00),
    ('Helpdesk Pro', 'Support', 27999.00),
    ('WhatsApp Integration', 'Integration', 8999.00),
    ('API Integration', 'Integration', 22999.00),
    ('Data Connector', 'Integration', 18999.00),
    ('BI Reporting', 'Analytics', 39999.00),
    ('Advanced Reporting', 'Analytics', 54999.00),
    ('Mobile CRM', 'CRM', 11999.00),
    ('Security Suite', 'Security', 31999.00);


-- ============================================
-- 3. LEADS
-- Generate 5,000 realistic leads
-- ============================================

INSERT IGNORE INTO leads
    (
        first_name,
        last_name,
        email,
        source,
        status,
        created_at,
        sales_rep_id
    )
WITH RECURSIVE numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 5000
)
SELECT
    CONCAT('Lead', n),
    CONCAT('Customer', n),
    CONCAT('lead', n, '@example.com'),

    CASE MOD(n, 6)
        WHEN 0 THEN 'Website'
        WHEN 1 THEN 'LinkedIn'
        WHEN 2 THEN 'Google Ads'
        WHEN 3 THEN 'Referral'
        WHEN 4 THEN 'Email Campaign'
        ELSE 'Cold Outreach'
    END,

    CASE MOD(n, 5)
        WHEN 0 THEN 'New'
        WHEN 1 THEN 'Contacted'
        WHEN 2 THEN 'Qualified'
        WHEN 3 THEN 'Converted'
        ELSE 'Lost'
    END,

    DATE_ADD(
        '2024-01-01',
        INTERVAL MOD(n * 7, 900) DAY
    ),

    MOD(n - 1, 10) + 1

FROM numbers;


-- ============================================
-- 4. ACTIVITIES
-- Generate 15,000 activities
-- 3 activities per lead
-- ============================================

INSERT IGNORE INTO activities
    (
        lead_id,
        sales_rep_id,
        activity_type,
        activity_date,
        notes
    )
WITH RECURSIVE numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 15000
)
SELECT
    MOD(n - 1, 5000) + 1,

    MOD(MOD(n - 1, 5000), 10) + 1,

    CASE MOD(n, 5)
        WHEN 0 THEN 'Call'
        WHEN 1 THEN 'Email'
        WHEN 2 THEN 'Meeting'
        WHEN 3 THEN 'Demo'
        ELSE 'Follow-up'
    END,

    DATE_ADD(
        '2024-01-01',
        INTERVAL MOD(n * 3, 900) DAY
    ),

    CASE MOD(n, 5)
        WHEN 0 THEN 'Discussed product requirements'
        WHEN 1 THEN 'Sent product information'
        WHEN 2 THEN 'Discussed business requirements'
        WHEN 3 THEN 'Product demonstration completed'
        ELSE 'Follow-up with prospect'
    END

FROM numbers;


-- ============================================
-- 5. OPPORTUNITIES
-- Generate 2,000 opportunities
-- ============================================

INSERT INTO opportunities
    (
        lead_id,
        sales_rep_id,
        stage,
        amount,
        created_at,
        expected_close_date,
        closed_at
    )
WITH RECURSIVE numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 2000
)
SELECT
    n,

    MOD(n - 1, 10) + 1,

    CASE MOD(n, 6)
        WHEN 0 THEN 'New'
        WHEN 1 THEN 'Qualified'
        WHEN 2 THEN 'Proposal'
        WHEN 3 THEN 'Negotiation'
        WHEN 4 THEN 'Won'
        ELSE 'Lost'
    END,

    10000 + MOD(n * 731, 90000),

    DATE_ADD(
        '2024-02-01',
        INTERVAL MOD(n * 5, 800) DAY
    ),

    DATE_ADD(
        '2024-04-01',
        INTERVAL MOD(n * 7, 800) DAY
    ),

    CASE
        WHEN MOD(n, 6) IN (4, 5)
        THEN DATE_ADD(
            '2024-04-01',
            INTERVAL MOD(n * 7, 800) DAY
        )
        ELSE NULL
    END

FROM numbers;


-- ============================================
-- 6. ORDERS
-- Generate 4,000 orders
-- ============================================

INSERT IGNORE INTO orders
    (
        opportunity_id,
        product_id,
        quantity,
        unit_price,
        order_date
    )
WITH RECURSIVE numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 4000
)
SELECT
    MOD(n - 1, 2000) + 1,

    MOD(n - 1, 20) + 1,

    MOD(n, 5) + 1,

    (
        SELECT unit_price
        FROM products
        WHERE product_id = MOD(n - 1, 20) + 1
    ),

    DATE_ADD(
        '2024-04-01',
        INTERVAL MOD(n * 11, 800) DAY
    )

FROM numbers;


-- ============================================
-- DATA VALIDATION
-- ============================================

SELECT 'sales_reps' AS table_name, COUNT(*) AS record_count
FROM sales_reps

UNION ALL

SELECT 'leads', COUNT(*)
FROM leads

UNION ALL

SELECT 'activities', COUNT(*)
FROM activities

UNION ALL

SELECT 'opportunities', COUNT(*)
FROM opportunities

UNION ALL

SELECT 'products', COUNT(*)
FROM products

UNION ALL

SELECT 'orders', COUNT(*)
FROM orders;