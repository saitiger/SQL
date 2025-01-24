-- SELECT
-- campaign_id,COUNT(*) as num_rows
-- FROM
-- marketing_spend
-- GROUP BY 1
-- HAVING 
-- COUNT(*)>1

-- None of the rows are repeated so we don't need to use 
-- GROUP BY when calculating the ROI

SELECT 
  campaign_id, 
  campaign_name, 
  ROUND((revenue_generated - investment) / investment * 100.0) AS ROI
FROM 
  marketing_spend
ORDER BY 
  3 DESC, 1 DESC 
LIMIT 
  (SELECT ROUND(COUNT(*) / 4.0) FROM marketing_spend);
