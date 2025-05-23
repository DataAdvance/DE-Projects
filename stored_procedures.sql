-- ================================================
-- FILE: 03_stored_procedures.sql
-- PURPOSE: Contains procedures for placing orders and replenishing stock
-- ================================================

-- Procedure: place_order
-- This procedure handles placing an order for a single product
-- It inserts the order, checks stock, deducts stock, logs inventory, and sets total amount
DELIMITER $$

CREATE PROCEDURE place_order (
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_unit_price DECIMAL(10, 2)
)
BEGIN
    DECLARE v_order_id INT;
    DECLARE v_total_amount DECIMAL(10, 2);

    -- Rollback if any step fails
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Step 1: Insert into orders
    INSERT INTO orders (customer_id, order_date, total_amount)
    VALUES (p_customer_id, NOW(), 0);
    SET v_order_id = LAST_INSERT_ID();

    -- Step 2: Stock validation
    IF (SELECT stock_quantity FROM products WHERE product_id = p_product_id) < p_quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock';
    END IF;

    -- Step 3: Insert into order_details
    INSERT INTO order_details (order_id, product_id, quantity, unit_price)
    VALUES (v_order_id, p_product_id, p_quantity, p_unit_price);

    -- Step 4: Update stock
    UPDATE products
    SET stock_quantity = stock_quantity - p_quantity
    WHERE product_id = p_product_id;

    -- Step 5: Log inventory change
    INSERT INTO inventory_logs (product_id, change_date, change_type, quantity_changed)
    VALUES (p_product_id, NOW(), 'Order', -p_quantity);

    -- Step 6: Calculate and update order total
    SET v_total_amount = p_quantity * p_unit_price;

    UPDATE orders
    SET total_amount = v_total_amount
    WHERE order_id = v_order_id;

    COMMIT;
END$$

DELIMITER ;

-- Procedure: replenish_stock
-- Automatically replenishes stock for products below reorder level and logs each replenishment
DELIMITER $$

CREATE PROCEDURE replenish_stock(IN p_replenish_quantity INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_product_id INT;
    DECLARE cur CURSOR FOR
        SELECT product_id FROM products WHERE stock_quantity < reorder_level;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    START TRANSACTION;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_product_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Add replenishment quantity to product stock
        UPDATE products
        SET stock_quantity = stock_quantity + p_replenish_quantity
        WHERE product_id = v_product_id;

        -- Log the inventory change
        INSERT INTO inventory_logs (product_id, change_date, change_type, quantity_changed)
        VALUES (v_product_id, NOW(), 'Replenishment', p_replenish_quantity);
    END LOOP;

    CLOSE cur;

    COMMIT;
END$$

DELIMITER ;