SELECT 
DISTINCT(v.vendor_name)
FROM 
vendors v 
JOIN 
item_prices ip 
ON v.vendor_id = ip.vendor_id
WHERE price_usd<=10

-- Solution 2: Without Distinct {Performace of Group By is better than distinct, especially on larger dataset }
SELECT 
v.vendor_name
FROM 
vendors v 
JOIN 
item_prices ip 
ON v.vendor_id = ip.vendor_id
WHERE price_usd<=10
GROUP BY 1
