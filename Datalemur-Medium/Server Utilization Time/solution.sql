WITH server_status_stats AS (
SELECT 
server_id,
status_time start_time,
LEAD(status_time) OVER(PARTITION BY server_id ORDER BY status_time) next_time,
session_status
FROM 
server_utilization
)
SELECT 
DATE_PART('days', JUSTIFY_HOURS(SUM(next_time - start_time))) AS total_uptime_days
FROM 
server_status_stats
WHERE next_time is NOT NULL AND session_status = 'start'
-- SELECT 
-- SUM(next_time - start_time)
-- FROM 
-- server_status_stats
-- WHERE next_time is NOT NULL
