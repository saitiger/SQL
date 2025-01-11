-- Solution 1 

SELECT shape,
EXTRACT(MONTH FROM date) AS month,
AVG(average_completion_time) AS avg_time
FROM honeycomb_game
WHERE 
EXTRACT(month from date) IN
(SELECT month 
FROM 
(SELECT month,
RANK() OVER(ORDER BY avg_temperature) coldest_month,
RANK() OVER(ORDER BY avg_temperature DESC) hottest_month
FROM 
monthly_temperatures)x
WHERE 
coldest_month = 1 OR hottest_month = 1)
AND date>= CURRENT_DATE - INTERVAL '20 years'
GROUP BY 1, 2
ORDER BY 3              

-- Solution 2 
WITH temperature_extremes AS (
    SELECT month 
    FROM monthly_temperatures 
    WHERE avg_temperature = (SELECT MAX(avg_temperature) FROM monthly_temperatures)
        OR avg_temperature = (SELECT MIN(avg_temperature) FROM monthly_temperatures)
)
SELECT 
    h.shape,
    EXTRACT(MONTH FROM h.date) AS month,
    AVG(h.average_completion_time) AS avg_time
FROM honeycomb_game h
WHERE EXTRACT(MONTH FROM h.date) IN (
    SELECT month FROM temperature_extremes
)
AND h.date >= CURRENT_DATE - INTERVAL '20 years'
GROUP BY h.shape, EXTRACT(MONTH FROM h.date)
ORDER BY avg_time;
