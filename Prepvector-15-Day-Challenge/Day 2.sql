SELECT 
ROUND(100.0 * 
SUM(CASE WHEN t.shipping_address = u.address THEN 1 ELSE 0 END) -- Orders with shipping address as the home address
/ 
COUNT(*),2) AS home_address_percent -- Total number of transactions
FROM 
transactions t 
JOIN 
users u 
ON 
t.user_id = u.id
