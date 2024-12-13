SELECT 
sr.region,
AVG(sn.snowfall_inches) average_snowfall
FROM
ski_resorts sr 
JOIN 
snowfall sn
ON 
sr.resort_id = sn.resort_id
GROUP BY region 
ORDER BY 2 DESC
