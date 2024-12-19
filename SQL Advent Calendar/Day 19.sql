SELECT 
pb.bear_name, 
MAX(ml.food_weight_kg) AS biggest_meal_kg
FROM 
polar_bears pb 
JOIN 
meal_log ml 
ON pb.bear_id = ml.bear_id
WHERE strftime('%m-%Y', ml.date) = '12-2024'
GROUP BY 1
ORDER BY 2 DESC;
