SELECT 
recipient,
SUM(weight_kg) total_weight
FROM 
gifts
GROUP BY 1 
ORDER BY 2 DESC
