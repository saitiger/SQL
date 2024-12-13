SELECT 
candy_name,candy_category,calories,
RANK() OVER(PARTITION BY candy_category 
ORDER BY calories DESC)
AS
calorie_rank
FROM
candy_nutrition
ORDER BY 4
