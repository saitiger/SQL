-- SELECT * FROM player LIMIT 5
WITH alive_with_SevereDebt AS (
SELECT id,first_name,last_name,age,status,debt,lower(vice) vice,has_close_family
FROM player WHERE lower(status) = 'alive' AND debt>400000000
)
--SELECT * 
SELECT id,CONCAT(first_name,' ',last_name) full_name 
FROM 
alive_with_SevereDebt
WHERE age>65 OR (vice = 'gambling' AND has_close_family = 'false')
