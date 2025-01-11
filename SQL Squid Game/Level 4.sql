SELECT team_id,
ROUND(AVG(age),2) average_age, -- Don't use Round to pass the test case 
CASE WHEN AVG(age)<40 THEN 'Fit' WHEN AVG(age)>=40 AND AVG(age)<=50 THEN 'Grizzled' 
ELSE 'Elderly' END 
age_category,
RANK() OVER(ORDER BY AVG(age) DESC) age_rank
FROM 
player
WHERE status = 'alive'
GROUP BY team_id 
HAVING COUNT(*)=10
ORDER BY 4
