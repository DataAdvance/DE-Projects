-- ================================================
-- FILE: 04_triggers.sql
-- PURPOSE: Automatically update inventory and log changes when new order details are added
-- ================================================

-- Trigger: after_order_detail_insert
-- Automatically deducts stock and logs the change every time a new order item is added
DELIMITER $$

CREATE TRIGGER after_order_detail_insert
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    -- Deduct stock from product
    UPDATE products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;

    -- Record inventory adjustment
    INSERT INTO inventory_logs (product_id, change_date, change_type, quantity_changed)
    VALUES (NEW.product_id, NOW(), 'Order', -NEW.quantity);
END$$

DELIMITER ;