-- Creating Business Insights and Summaries
-- Query To show all orders placed by a specific customer, including the order date, total amount, and the number of items ordered, 
SELECT
    o.order_id, -- Unique identifier for each order
    o.order_date, -- Date when the order was placed
    o.total_amount,-- Total monetary value of the order
    COUNT(od.order_detail_id) AS number_of_items -- Counts the number of individual items in the order
FROM
    Orders o -- Alias for the Orders table as 'o' 
JOIN
    OrderDetails od ON o.order_id = od.order_id
WHERE
    o.customer_id = {customer_id} 
GROUP BY
    o.order_id, o.order_date, o.total_amount
ORDER BY
    o.order_date DESC;
       
-- Customer Insights
-- categorizing customers based on spending habits:

-- To gain insight on customer spending habits 
SELECT
    c.customer_id,
    c.name AS customer_name,
    SUM(o.total_amount) AS total_spending
FROM
    Customers c
LEFT JOIN
    Orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id, c.name
ORDER BY
    total_spending DESC;
    
    
-- Categorize customers into spending tiers (Bronze, Silver, Gold)
SELECT
    customer_id,
    customer_name,
    total_spending,
    CASE
        WHEN total_spending < 1000 THEN 'Bronze'
        WHEN total_spending >= 1000 AND total_spending < 5000 THEN 'Silver'
        WHEN total_spending >= 5000 THEN 'Gold'
        ELSE 'Unknown' -- For customers with no spending (total_spending is NULL)
    END AS spending_tier -- Assigns a spending tier based on the 'total_spending' using a CASE statement

FROM (
    SELECT
        c.customer_id,
        c.name AS customer_name,
        COALESCE(SUM(o.total_amount), 0) AS total_spending
    FROM
        Customers c
    LEFT JOIN
        Orders o ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id, c.name
) AS customer_spending
ORDER BY
    total_spending DESC;
    

SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    discount_amount
FROM
    Orders
WHERE
    discount_amount > 0;
    
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.total_amount,
    o.discount_amount,
    COUNT(od.order_detail_id) AS number_of_items
FROM
    Orders o
JOIN
    OrderDetails od ON o.order_id = od.order_id
WHERE
    o.discount_amount > 0 -- Filter for orders with discounts
GROUP BY
    o.order_id, o.customer_id, o.order_date, o.total_amount, o.discount_amount
HAVING
    COUNT(od.order_detail_id) > {bulk_quantity_threshold}; -- Replace with the quantity threshold for discounts


    