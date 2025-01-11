SELECT eq.supplier_id
FROM
equipment eq 
JOIN
failure_incidents fi
ON 
eq.id = fi.failed_equipment_id
WHERE game_type = 
-- # Filters the game with the most failures (Red Light Green Light)
(SELECT 
game_type
FROM
failure_incidents f 
JOIN            
equipment e 
ON 
f.failed_equipment_id = e.id
GROUP BY 1
ORDER BY COUNT(*) DESC
LIMIT 1)
GROUP BY 1 
ORDER BY COUNT(fi.failed_equipment_id)DESC LIMIT 1       
-- # Most Failed Supplier 29

SELECT 
FLOOR(AVG((fi.failure_date - eq.installation_date)/365.2425)) avg_lifespan
FROM
equipment eq 
JOIN
failure_incidents fi
ON 
eq.id = fi.failed_equipment_id
WHERE eq.supplier_id = 29 

-- Solution 2 
WITH MostFailedGameType AS (
    SELECT e.game_type
    FROM equipment e
    JOIN failure_incidents fi ON e.id = fi.failed_equipment_id
    GROUP BY e.game_type
    ORDER BY COUNT(*) DESC
    LIMIT 1
),
WorstSupplier AS (
    SELECT e.supplier_id
    FROM equipment e
    JOIN failure_incidents fi ON e.id = fi.failed_equipment_id
    WHERE e.game_type = (SELECT game_type FROM MostFailedGameType)
    GROUP BY e.supplier_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
SELECT 
    FLOOR(AVG((fi.failure_date - e.installation_date) / 365.2425)) AS avg_lifespan_years
FROM equipment e
JOIN failure_incidents fi ON e.id = fi.failed_equipment_id
WHERE e.supplier_id = (SELECT supplier_id FROM WorstSupplier);
