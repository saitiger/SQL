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
