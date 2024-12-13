SELECT 
sg.globe_name,
COUNT(f.figurine_id) num_of_figurines
,sg.material
FROM
snow_globes sg
JOIN
figurines f 
ON
sg.globe_id = f.globe_id
GROUP BY 1,3
ORDER BY 2 DESC
LIMIT 3
