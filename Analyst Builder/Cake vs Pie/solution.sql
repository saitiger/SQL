WITH cte AS
(
SELECT date_sold,
SUM(CASE WHEN product = 'Cake' THEN amount_sold ELSE -amount_sold
END) AS difference
FROM desserts
GROUP BY date_sold
)
SELECT date_sold,abs(difference) AS difference,
CASE WHEN difference<0 THEN 'Pie' ELSE 'Cake' END AS sold_more
FROM 
cte
