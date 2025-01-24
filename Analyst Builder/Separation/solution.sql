-- Solution 1 
SELECT substring(id,1,5) ID, substring(id,6) First_Name
FROM 
bad_data

-- Solution 2 
SELECT
regexp_replace(CombinedColumn, '[^0-9].*', '') ID,  -- Extract numeric prefix as ID
regexp_replace(CombinedColumn, '^[0-9]+', '') FirstName -- Extract non-numeric suffix as FirstName
FROM 
YourTable
