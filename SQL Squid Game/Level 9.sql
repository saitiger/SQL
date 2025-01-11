WITH recent_squidgame_time AS (-- Most recent Squid Game 
SELECT date, start_time, end_time
FROM game_schedule
WHERE type = 'Squid Game' 
ORDER BY date DESC
LIMIT 1)
SELECT g.id AS guard_id, g.assigned_post, g.shift_start, g.shift_end, 
dl.door_location, dl.access_time
FROM guard g
JOIN recent_squidgame_time rst
ON g.shift_start < rst.end_time AND g.shift_end > rst.start_time
LEFT JOIN daily_door_access_logs dl
ON dl.guard_id = g.id
AND dl.access_time<g.shift_end
WHERE g.assigned_post<>dl.door_location
-- Upper Management is the room of interest accessed by Guard Number 31               

SELECT
g.id,dl.access_time
FROM daily_door_access_logs dl
JOIN guard g 
ON g.id = dl.guard_id
WHERE dl.door_location = 'Upper Management'
AND dl.access_time BETWEEN '11:00:00'::time AND '12:00:00'::time
AND g.id != 31                
