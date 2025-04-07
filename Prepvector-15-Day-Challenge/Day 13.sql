CREATE TABLE users (
id INTEGER PRIMARY KEY,
name VARCHAR(100),
birthdate DATETIME
);

INSERT INTO users (id, name, birthdate) VALUES
(1, 'Alice', '1995-05-15'),
(2, 'Bob', '1985-03-20'),
(3, 'Charlie', '2005-07-10'),
(4, 'David', '1955-11-30'),
(5, 'Eve', '2015-09-25'),
(6, 'Frank', '1935-02-14'),
(7, 'Grace', '1975-12-01');

CREATE TABLE search_events (
search_id INTEGER PRIMARY KEY,
query VARCHAR(255),
has_clicked BOOLEAN,
user_id INTEGER,
search_time DATETIME,
FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO search_events (search_id, query, has_clicked, user_id, search_time) VALUES

(1, 'travel', TRUE, 1, '2021-03-15 10:00:00'),
(2, 'books', FALSE, 1, '2021-03-15 11:00:00'),
(3, 'cars', TRUE, 2, '2021-05-20 14:30:00'),
(4, 'tech', TRUE, 2, '2021-05-20 15:00:00'),
(5, 'games', FALSE, 3, '2021-07-10 16:45:00'),
(6, 'music', FALSE, 3, '2021-07-10 17:00:00'),
(7, 'retirement', TRUE, 4, '2021-09-05 09:15:00'),
(8, 'health', FALSE, 4, '2021-09-05 10:00:00'),
(9, 'toys', FALSE, 5, '2021-11-25 13:20:00'),
(10, 'genealogy', TRUE, 6, '2021-12-01 11:30:00'),
(11, 'history', TRUE, 6, '2021-12-01 12:00:00'),
(12, 'finance', TRUE, 7, '2021-02-15 08:45:00'),
(13, 'investing', FALSE, 7, '2021-02-15 09:00:00');

"""
Given two tables, search_events and users, write a query to find the three age groups (bucketed by decade: 0-9, 10-19, 20-29, …,80-89, 90-99, 
with the end point included) with the highest clickthrough rate in 2021. If two or more groups have the same clickthrough rate, the older group should have priority.

Hint: if a user that clicked the link on 1/1/2021 who is 29 years old on that day and has a birthday tomorrow on 2/1/2021, 
they fall into the [20-29] category. If the same user clicked on another link on 2/1/2021, he turned 30 and will fall into the [30-39] category.
"""

WITH search_2021 AS (
    -- Filter search events to only 2021
    SELECT *
    FROM search_events
    WHERE search_time BETWEEN '2021-01-01' AND '2021-12-31'
),

search_with_age AS (
    -- Calculate exact age at time of search
    SELECT
        s.search_id,
        s.user_id,
        s.has_clicked,
        s.search_time,
        u.birthdate,
        -- Calculate age considering whether birthday has occurred yet this year
        CAST(strftime('%Y', s.search_time) AS INTEGER) - CAST(strftime('%Y', u.birthdate) AS INTEGER)
        - CASE WHEN strftime('%m-%d', s.search_time) < strftime('%m-%d', u.birthdate) THEN 1 ELSE 0 END 
        AS age
    FROM search_2021 s
    JOIN users u ON s.user_id = u.id
),

search_with_age_group AS (
    -- Bucket ages into decade groups (0-9, 10-19, etc.)
    SELECT *,
        (age / 10) * 10 AS age_group_start,
        ((age / 10) * 10) || '-' || ((age / 10) * 10 + 9) AS age_group
    FROM search_with_age
),

age_group_stats AS (
    -- Calculate CTR for each age group
    SELECT
        age_group,
        COUNT(*) AS total_searches,
        SUM(CASE WHEN has_clicked THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS ctr
    FROM search_with_age_group
    GROUP BY age_group
)

-- Final result: top 3 age groups by CTR (older groups break ties)
SELECT 
    age_group, 
    ROUND(ctr, 3) AS ctr
FROM age_group_stats
ORDER BY 
    ctr DESC,
    CAST(SUBSTR(age_group, 1, INSTR(age_group, '-') - 1) AS INTEGER) DESC
LIMIT 3;
