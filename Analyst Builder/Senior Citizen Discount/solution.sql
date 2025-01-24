WITH cte AS (
SELECT *,
EXTRACT(YEAR FROM AGE('2023-01-01', birth_date)) age
FROM 
customers
)
SELECT customer_id
FROM 
cte 
WHERE age>=55
ORDER BY 1
