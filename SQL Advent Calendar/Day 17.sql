SELECT 
prank_name,location
FROM
grinch_pranks
WHERE 
lower(difficulty) = 'expert'
OR
lower(difficulty) = 'advanced'
ORDER BY 1 DESC,2 DESC
