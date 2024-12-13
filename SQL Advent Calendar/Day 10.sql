SELECT *,
(CASE WHEN 
percentage_completed>=75 THEN 'GREEN'
WHEN percentage_completed>=50 AND percentage_completed<75 THEN 'YELLOW'
ELSE 'RED'
END) SUCESS_CATEGORY
FROM(
SELECT
friend_name,
COUNT(resolution) num_of_resolutions,
SUM(is_completed) num_of_completed_resolutions,
100.0*SUM(is_completed)/COUNT(resolution) percentage_completed
FROM
resolutions 
GROUP BY friend_name
)x
GROUP BY friend_name
