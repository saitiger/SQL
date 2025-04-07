CREATE TABLE events (
user_id INT,
created_at DATETIME,
action VARCHAR(20)
);

INSERT INTO events VALUES
(1, '2020-01-01 10:00:00', 'post_enter'),
(1, '2020-01-01 10:05:00', 'post_submit'),
(2, '2020-01-01 11:00:00', 'post_enter'),
(2, '2020-01-01 11:10:00', 'post_canceled'),
(3, '2020-01-01 15:00:00', 'post_enter'),
(3, '2020-01-01 15:30:00', 'post_submit'),
(4, '2020-01-02 09:00:00', 'post_enter'),
(4, '2020-01-02 09:15:00', 'post_canceled'),
(5, '2020-01-02 10:00:00', 'post_enter'),
(5, '2020-01-02 10:10:00', 'post_canceled'),
(10, '2020-01-15 14:00:00', 'post_enter'),
(10, '2020-01-15 14:30:00', 'post_submit'),
(6, '2019-12-31 23:55:00', 'post_enter'),
(6, '2020-01-01 00:05:00', 'post_submit'),
(7, '2020-02-01 00:00:00', 'post_enter'),
(7, '2020-02-01 00:10:00', 'post_submit'),
(8, '2019-01-15 10:00:00', 'post_enter'),
(8, '2019-01-15 10:30:00', 'post_submit'),
(9, '2021-01-01 09:00:00', 'post_enter'),
(9, '2021-01-01 09:10:00', 'post_canceled');

"""
Consider the events table, which contains information about the phases of writing a new social media post.

The action column can have values post_enter, post_submit, or post_canceled for when a user starts to write (post_enter), 
ends up canceling their post (post_cancel), or posts it (post_submit). Write a query to get the post-success rate for each day in the month of January 2020.

Note: Post Success Rate is defined as the number of posts submitted (post_submit) divided by the number of posts entered (post_enter) for each day.
"""

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
