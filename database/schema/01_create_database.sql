CREATE DATABASE IF NOT EXISTS salespulse;

USE salespulse;

-- ============================================
-- 1. Sales Representatives
-- ============================================

CREATE TABLE sales_reps (
    rep_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    region VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL
);

-- ============================================
-- 2. Leads
-- ============================================

CREATE TABLE leads (
    lead_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    source VARCHAR(50) NOT NULL,
    status VARCHAR(30) NOT NULL,
    created_at DATETIME NOT NULL,
    sales_rep_id INT NOT NULL,

    FOREIGN KEY (sales_rep_id)
        REFERENCES sales_reps(rep_id)
);

-- ============================================
-- 3. Activities
-- ============================================

CREATE TABLE activities (
    activity_id INT PRIMARY KEY AUTO_INCREMENT,
    lead_id INT NOT NULL,
    sales_rep_id INT NOT NULL,
    activity_type VARCHAR(30) NOT NULL,
    activity_date DATETIME NOT NULL,
    notes VARCHAR(255),

    FOREIGN KEY (lead_id)
        REFERENCES leads(lead_id),

    FOREIGN KEY (sales_rep_id)
        REFERENCES sales_reps(rep_id)
);

-- ============================================
-- 4. Opportunities
-- ============================================

CREATE TABLE opportunities (
    opportunity_id INT PRIMARY KEY AUTO_INCREMENT,
    lead_id INT NOT NULL,
    sales_rep_id INT NOT NULL,
    stage VARCHAR(30) NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    created_at DATETIME NOT NULL,
    expected_close_date DATE,
    closed_at DATETIME,

    FOREIGN KEY (lead_id)
        REFERENCES leads(lead_id),

    FOREIGN KEY (sales_rep_id)
        REFERENCES sales_reps(rep_id)
);

-- ============================================
-- 5. Products
-- ============================================

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);

-- ============================================
-- 6. Orders
-- ============================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    opportunity_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    order_date DATETIME NOT NULL,

    FOREIGN KEY (opportunity_id)
        REFERENCES opportunities(opportunity_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);