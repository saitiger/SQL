-- Clarifying Question 
-- Filtering users who have made a post but not 
-- liked or commented ? 

WITH like_comment_users AS (
SELECT 
DISTINCT(user_id) not_valid_user_id
FROM 
events 
WHERE action = 'like' OR action = 'comment'
),
valid_users AS
(
SELECT
DISTINCT(user_id) valid_users,
COUNT(DISTINCT(user_id)) valid_users_count
FROM
users 
WHERE user_id NOT IN (SELECT not_valid_user_id FROM like_comment_users)
)
SELECT 
ROUND(valid_users_count/(SELECT COUNT(user_id) FROM users)*100.0,2)
percentage 
FROM 
valid_users
