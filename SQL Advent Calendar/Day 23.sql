WITH CTE AS (
SELECT 
weight
-
LAG(weight,1) OVER(ORDER BY day_of_month)
AS 
weight_change
FROM
grinch_weight_log
)
SELECT * 
FROM 
CTE 
WHERE 
weight_change IS NOT NULL
