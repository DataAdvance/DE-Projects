-- ================================================
-- FILE: 02_views.sql
-- PURPOSE: Define views for simplified reporting and data analysis
-- ================================================

-- View: order_summary_view
-- This view combines orders, customers, and order details to show a complete summary
CREATE OR REPLACE VIEW order_summary_view AS
SELECT
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.total_amount,
    SUM(od.quantity) AS total_items                    -- Sum of items for each order
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id;

-- View: low_stock_view
-- Shows products that are below their reorder threshold
CREATE OR REPLACE VIEW low_stock_view AS
SELECT
    product_id,
    name,
    stock_quantity,
    reorder_level
FROM products
WHERE stock_quantity < reorder_level;

-- View: customer_tiers_view
-- Categorizes customers based on their total spending across all orders
CREATE OR REPLACE VIEW customer_tiers_view AS
SELECT
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent,
    CASE
        WHEN SUM(o.total_amount) >= 1000 THEN 'Gold'   -- High-value customers
        WHEN SUM(o.total_amount) >= 500 THEN 'Silver'  -- Mid-range customers
        ELSE 'Bronze'                                  -- All others
    END AS tier
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;