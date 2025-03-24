-- Part 1 
SELECT 
filt.filter_name
-- ,SUM(interaction_count) total_interaction
FROM 
ar_filter_engagements eng 
JOIN 
ar_filters filt 
ON 
eng.filter_id = filt.filter_id
WHERE engagement_date 
BETWEEN '2024-07-01' AND '2024-07-31'
GROUP BY 1

-- Part 2 
WITH filter_august_count 
AS (
SELECT 
filt.filter_name,
SUM(interaction_count) total_interaction
FROM 
ar_filter_engagements eng 
JOIN 
ar_filters filt 
ON 
eng.filter_id = filt.filter_id
WHERE engagement_date 
BETWEEN '2024-08-01' AND '2024-08-31'
GROUP BY 1 
)
SELECT filter_name,total_interaction
FROM 
filter_august_count
WHERE total_interaction>1000

-- Part 3 
WITH filter_august_count AS 
(
SELECT filt.filter_name, SUM(interaction_count) total_interaction 
FROM 
ar_filter_engagements eng 
JOIN ar_filters filt 
ON 
eng.filter_id = filt.filter_id 
WHERE engagement_date BETWEEN '2024-09-01' AND '2024-09-30' 
GROUP BY 1 ) 
SELECT filter_name,total_interaction 
FROM 
filter_august_count 
ORDER BY 2 DESC LIMIT 3
