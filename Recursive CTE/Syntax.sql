WITH [RECURSIVE] CTE_Name AS 
(
SELECT query -- Base Case : Base Case {It is non recursive}
  UNION [ALL] -- ALL doesn't remove the duplicates
SELECT query -- Recursive query using CTE_Name {Needs to include the termination condition}
)
SELECT * FROM CTE_Name

-- The recursive query using the output from the 
-- previous iteration as the input
