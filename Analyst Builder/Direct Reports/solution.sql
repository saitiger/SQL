WITH cte AS (
SELECT employee_id manager_id ,position manager_position
FROM 
direct_reports 
WHERE position LIKE '%Manager%'
)
SELECT manager_id,manager_position,
COUNT(*) direct_reports 
FROM 
cte c
JOIN 
direct_reports d
ON 
c.manager_id = d.managers_id
GROUP BY 1,2
