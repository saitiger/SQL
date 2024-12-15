WITH Recursive cte AS (
SELECT MIN(period_start) AS dates, MAX(period_end) AS max_date
FROM sales
UNION ALL 
SELECT 
dateadd(day, 1, dates) AS dates, 
max_date
FROM cte
WHERE dates < max_date
)
SELECT
product_id,
year(dates) AS report_year,
sum(average_daily_sales) AS total_amount
FROM cte
GROUP BY 1,2
ORDER BY 1,2
