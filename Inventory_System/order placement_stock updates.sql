-- Handling order placements
-- when an order is placed the sql query below is exacted,to check if the stock requested is sufficient
SELECT stock_quantity
FROM Products
WHERE product_id = product_id;

-- If sufficient stock is available for all products, a new record is inserted into the Orders table
INSERT INTO Orders (customer_id, order_date)
VALUES ({customer_id}, NOW());-- where {customer_id} is a placeholder for an actual customer id like ('John Doe', 'john.doe@example.com', '123-456-7890)

-- Assume we have a list of products in the order table with their quantities:
-- [(product_id_1, quantity_1), (product_id_2, quantity_2), ...],we want to select and view the price for the ordered products

FOR EACH (product_id,quantity) IN order_items:
    SELECT price 
    FROM Products 
    WHERE product_id = product_id;
    
-- A new record is inserted into the 'OrderDetails' table to link the order with the specific product,the quantity ordered, and the price at the time of purchase.

INSERT INTO OrderDetails (order_id, product_id, quantity, price)
VALUES (order_id, product_id, quantity, product_price);

-- Update Product Stock
-- For each product in the order, the stock_quantity in the Products table needs to be updated by subtracting the ordered quantity.
UPDATE Products
SET stock_quantity = stock_quantity - quantity
WHERE product_id = {product_id}; -- where product id is an actual product_id eg.('1', 'Laptop', 'Electronics', '1200.00', '50', '10')


