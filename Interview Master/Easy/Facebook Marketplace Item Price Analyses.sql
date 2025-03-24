-- Part 1 
SELECT 
category,
ROUND(AVG(price),2) avg_price_category
FROM 
Listings 
GROUP BY 1

-- Part 2 
SELECT 
city
FROM
Listings
GROUP BY 1 
ORDER BY AVG(PRICE)
LIMIT 1
