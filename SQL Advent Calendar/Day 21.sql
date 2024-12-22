SELECT 
recipient_type,
SUM(weight_kg) AS total_weight,
ROUND((SUM(weight_kg) / (SELECT SUM(weight_kg) FROM gifts)) * 100, 2) AS weight_percentage
FROM 
gifts
GROUP BY 1
