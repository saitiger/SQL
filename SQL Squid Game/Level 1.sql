-- SELECT * FROM player LIMIT 5 # Checking the schema 
WITH alive_with_SevereDebt AS (
SELECT id,first_name,last_name,age,status,debt,lower(vice) vice,has_close_family 
FROM player WHERE lower(status) = 'alive' AND debt>400000000
)
-- Used lower to make sure even if there is Case mismatch then it is detected
--SELECT * # Select all the columns to pass the test cases 
SELECT id,CONCAT(first_name,' ',last_name) full_name -- # Better way to have a look at the people of interest
FROM 
alive_with_SevereDebt
WHERE age>65 OR (vice = 'gambling' AND has_close_family = 'false')
