SELECT 
a.activity_name,
AVG(ar.rating)
FROM
activities a 
JOIN
activity_ratings ar 
ON 
a.activity_id = ar.activity_id
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 2
