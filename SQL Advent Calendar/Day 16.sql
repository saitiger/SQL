SELECT 
category,
SUM(quantity_sold*price_per_unit) total_sales
FROM
candy_sales
GROUP BY 1
