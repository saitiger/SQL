SELECT 
v.vendor_name,
SUM(quantity_sold*price_per_unit) total_revenue
FROM 
vendors v 
JOIN
sales s 
ON v.vendor_id = s.vendor_id
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 2
