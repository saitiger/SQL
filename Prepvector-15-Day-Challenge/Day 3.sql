CREATE TABLE job_postings (
    id INT PRIMARY KEY,
    user_id INT,
    job_id INT,
    posted_date DATETIME
);

INSERT INTO job_postings (id, user_id, job_id, posted_date) VALUES
    (1, 1, 101, '2024-01-01'),
    (2, 1, 102, '2024-01-02'),
    (3, 2, 201, '2024-01-01'),
    (4, 2, 201, '2024-01-15'),
    (5, 2, 202, '2024-01-03'),
    (6, 3, 301, '2024-01-01'),
    (7, 4, 401, '2024-01-01'),
    (8, 4, 401, '2024-01-15'),
    (9, 4, 402, '2024-01-02'),
    (10, 4, 402, '2024-01-16'),
    (11, 5, 501, '2024-01-05'),
    (12, 5, 502, '2024-01-10');

"""
Given a table of job postings, write a query to retrieve the number of users that have posted each job only once and the number of users that 
have posted at least one job multiple times.
"""
    
WITH user_job_counts AS (
    SELECT user_id, job_id, COUNT(*) AS cnt
    FROM job_postings
    GROUP BY 1, 2
)
SELECT 
    SUM(CASE WHEN flag = 0 THEN 1 ELSE 0 END) AS single_post_users,
    SUM(CASE WHEN flag > 0 THEN 1 ELSE 0 END) AS multiple_post_users
FROM (
    SELECT 
        user_id,
        MAX(CASE WHEN cnt > 1 THEN 1 ELSE 0 END) AS flag
    FROM user_job_counts 
    GROUP BY 1
) x
