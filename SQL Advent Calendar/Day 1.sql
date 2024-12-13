SELECT customer_name
FROM
rentals
GROUP BY 1 
HAVING COUNT(distinct activity)>1
