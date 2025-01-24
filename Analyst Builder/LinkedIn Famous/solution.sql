SELECT post_id, (actions / impressions * 100) popularity
FROM 
linkedin_posts
WHERE (actions /impressions * 100) >= 1.0
ORDER BY 2 DESC
