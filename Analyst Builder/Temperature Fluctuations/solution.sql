WITH cte AS
(
  SELECT date,temperature - lag(temperature,1) over(ORDER BY date) temp_diff 
  FROM temperatures
)
SELECT 
date 
FROM
cte 
WHERE temp_diff>0
ORDER BY 1 
