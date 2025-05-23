-- ================================================
-- FILE: 01_create_tables.sql
-- PURPOSE: Define all database tables for the Inventory Management System
-- ================================================

-- Table: products
-- This table stores all product-related information including pricing and stock thresholds
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,                           -- Unique ID for each product
    name VARCHAR(100) NOT NULL,                              -- Product name
    category VARCHAR(50),                                    -- Product category (e.g., Electronics, Furniture)
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),        -- Product price, must be non-negative
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),-- Current stock count
    reorder_level INT NOT NULL CHECK (reorder_level >= 0)    -- Reorder threshold for replenishment
);

-- Table: customers
-- Stores information about each customer
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,                          -- Unique ID for each customer
    name VARCHAR(100) NOT NULL,                              -- Customer's full name
    email VARCHAR(100) UNIQUE NOT NULL,                      -- Unique email for login or contact
    phone_number VARCHAR(20)                                 -- Contact number
);

-- Table: orders
-- Each record represents a completed customer order
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,                             -- Unique order ID
    customer_id INT NOT NULL,                                -- Link to the customer who placed the order
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,          -- Timestamp of when the order was made
    total_amount DECIMAL(10, 2) DEFAULT 0 CHECK (total_amount >= 0), -- Total cost of the order
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) -- Enforces valid customer reference
);

-- Table: order_details
-- Represents each product in an order (1 order may contain many products)
CREATE TABLE order_details (
    order_detail_id SERIAL PRIMARY KEY,                      -- Unique ID for each order detail line
    order_id INT NOT NULL,                                   -- The related order
    product_id INT NOT NULL,                                 -- Product ordered
    quantity INT NOT NULL CHECK (quantity > 0),              -- Number of units ordered
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0), -- Price per unit at time of purchase
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE, -- Enforce referential integrity
    FOREIGN KEY (product_id) REFERENCES products(product_id)  -- Valid product reference
);

-- Table: inventory_logs
-- Keeps a historical record of all inventory changes
CREATE TABLE inventory_logs (
    log_id SERIAL PRIMARY KEY,                               -- Unique log entry ID
    product_id INT NOT NULL,                                 -- Product affected
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,         -- Time of stock change
    change_type VARCHAR(20) CHECK (change_type IN ('Order', 'Replenishment', 'Manual Adjustment')), -- Reason
    quantity_changed INT NOT NULL,                           -- Quantity added or removed (+ or -)
    FOREIGN KEY (product_id) REFERENCES products(product_id) -- Valid product reference
);