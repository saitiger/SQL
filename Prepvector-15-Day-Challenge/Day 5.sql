-- Solution 1 : Fails one test case 
SELECT 
    DATE(created_at) AS date,
    COUNT(CASE WHEN action = 'post_enter' THEN 1 END) AS total_enters,
    COUNT(CASE WHEN action = 'post_submit' THEN 1 END) AS total_submits,
    COALESCE(
        COUNT(CASE WHEN action = 'post_submit' THEN 1 END) * 1.0 / 
        NULLIF(COUNT(CASE WHEN action = 'post_enter' THEN 1 END), 0), 
        0
    ) AS success_rate
FROM events
WHERE created_at BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY date
ORDER BY date;

-- Solution 2 : Passes all the test cases
WITH jan_2020 AS (
    SELECT * 
    FROM events
    WHERE created_at BETWEEN '2020-01-01' AND '2020-01-31 23:59:59'
),
counts AS (
    SELECT 
        DATE(created_at) AS date,
        COUNT(CASE WHEN action = 'post_enter' THEN user_id END) AS total_enters,
        COUNT(CASE WHEN action = 'post_submit' 
              AND user_id IN (SELECT user_id FROM jan_2020 WHERE action = 'post_enter')
        THEN user_id END) AS total_submits
    FROM jan_2020
    GROUP BY DATE(created_at)
)
SELECT 
    date,
    total_enters,
    total_submits,
    CASE 
        WHEN total_enters = 0 THEN NULL 
        ELSE ROUND(100.0 * total_submits / total_enters, 2) 
    END AS success_rate
FROM counts
ORDER BY date;
