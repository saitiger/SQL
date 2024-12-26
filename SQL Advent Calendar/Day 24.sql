SELECT*,
SUM(gifts_delivered) OVER (ORDER BY delivery_date) total_gifts_delivered
FROM
deliveries
