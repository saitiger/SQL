SELECT 
    p.bear_id,
    p.bear_name,
    SUM(t.distance_km) AS total_distance_traveled
FROM
    polar_bears p
JOIN
    tracking t 
ON 
    p.bear_id = t.bear_id
WHERE 
    strftime('%m', t.date) = '12' 
    AND strftime('%Y', t.date) = '2024'
GROUP BY 
    p.bear_id, p.bear_name
ORDER BY 
    total_distance_traveled DESC
LIMIT 3
