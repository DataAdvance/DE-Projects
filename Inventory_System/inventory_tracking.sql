-- Record Inventory Changes
INSERT INTO InventoryLogs (product_id, change_date, change_quantity, reason)
VALUES (product_id, NOW(), -quantity, 'Order placed - Order ID: order_id');

-- Calculate and Update Total Order Amount 
-- After all the order details have been recorded, 
-- the total amount for the order can be calculated by summing the product of quantity and price for each item in the OrderDetails table
SELECT SUM(quantity * price) AS total_amount
FROM OrderDetails
WHERE order_id = {order_id};


UPDATE Orders
SET total_amount = {calculated_total_amount}
WHERE order_id = {order_id};

-- Tracking Inventory Changes
-- When new stock arrives for a product, 
-- the replenished quantity is added by updating the stock_quantity in the Products table
UPDATE Products
SET stock_quantity = stock_quantity + {replenished_quantity}
WHERE product_id = {product_id};

-- Record the inventory change in the InventoryLogs table
INSERT INTO InventoryLogs (product_id, change_date, change_quantity, reason)
VALUES ({product_id}, NOW(), {replenished_quantity}, 'Stock replenished - Batch ID: {batch_id}');

-- Retrieving Inventory Change History
SELECT log_id, change_date, change_quantity, reason
FROM InventoryLogs
WHERE product_id = {product_id}
ORDER BY change_date DESC;
