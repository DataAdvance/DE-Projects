SELECT
    product_id,
    name,
    stock_quantity,
    reorder_level
FROM
    Products
WHERE
    stock_quantity < reorder_level;
    
    
UPDATE Products
SET stock_quantity = stock_quantity + {replenished_quantity}
WHERE product_id = {product_id};


INSERT INTO InventoryLogs (product_id, change_date, change_quantity, reason)
VALUES ({product_id}, NOW(), {replenished_quantity}, 'Stock replenished - Received batch ID: {batch_id}');


-- Example update query (assuming a 'customer_tier' column exists in Customers table)
UPDATE Customers
SET customer_tier = CASE
    WHEN (SELECT SUM(o.total_amount) FROM Orders o WHERE o.customer_id = Customers.customer_id) < 1000 THEN 'Bronze'
    WHEN (SELECT SUM(o.total_amount) FROM Orders o WHERE o.customer_id = Customers.customer_id) >= 1000 AND (SELECT SUM(o.total_amount) FROM Orders o WHERE o.customer_id = Customers.customer_id) < 5000 THEN 'Silver'
    WHEN (SELECT SUM(o.total_amount) FROM Orders o WHERE o.customer_id = Customers.customer_id) >= 5000 THEN 'Gold'
    ELSE 'Unknown'
END;


