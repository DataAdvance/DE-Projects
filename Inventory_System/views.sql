 -- We want to Generate reports to see which products are low on stock and need to be replenished
-- To identify products where the stock level is below the reorder point we go to the order table
SELECT
    product_id,
    product_name,
    stock_quantity,
    reorder_level -- the minimum stock level at which a product should be reordered
FROM
    Products
WHERE
    stock_quantity < reorder_level;