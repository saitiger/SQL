-- 1. Daily, Weekly, and Monthly Active Users
WITH user_metrics AS (
    SELECT 
        d.full_date,
        COUNT(DISTINCT fs.user_id) as daily_active_users,
        COUNT(DISTINCT CASE 
            WHEN d.full_date >= DATE_TRUNC('week', fs.streaming_date_id)
            THEN fs.user_id END) as weekly_active_users,
        COUNT(DISTINCT CASE 
            WHEN d.full_date >= DATE_TRUNC('month', fs.streaming_date_id)
            THEN fs.user_id END) as monthly_active_users
    FROM Dim_Date d
    LEFT JOIN Fact_Streaming fs ON d.date_id = fs.streaming_date_id
    GROUP BY d.full_date
)
SELECT * FROM user_metrics
ORDER BY full_date;

-- 2. Average Viewing Time per User by Device Type
SELECT 
    u.user_id,
    d.device_type,
    AVG(fs.duration_minutes) as avg_viewing_minutes,
    COUNT(DISTINCT fs.content_id) as unique_content_watched
FROM Fact_Streaming fs
JOIN Dim_User u ON fs.user_id = u.user_id
JOIN Dim_Device d ON fs.device_id = d.device_id
GROUP BY u.user_id, d.device_type;

-- 3. Content Popularity Analysis
SELECT 
    c.content_name,
    c.primary_genre,
    COUNT(DISTINCT fs.user_id) as unique_viewers,
    AVG(fs.watch_completion_rate) as avg_completion_rate,
    AVG(fs.user_rating) as avg_rating
FROM Fact_Streaming fs
JOIN Dim_Content c ON fs.content_id = c.content_id
GROUP BY c.content_name, c.primary_genre
ORDER BY unique_viewers DESC;

-- 4. Release Day Viewership
SELECT 
    c.content_name,
    COUNT(DISTINCT fs.user_id) as release_day_viewers,
    AVG(fs.duration_minutes) as avg_viewing_duration
FROM Fact_Streaming fs
JOIN Dim_Content c ON fs.content_id = c.content_id
WHERE fs.streaming_date_id = c.release_date_id
GROUP BY c.content_name
ORDER BY release_day_viewers DESC;

-- 5. Churn Risk Analysis
WITH user_activity AS (
    SELECT 
        user_id,
        MAX(streaming_date_id) as last_activity_date,
        COUNT(*) as total_streams,
        AVG(duration_minutes) as avg_duration
    FROM Fact_Streaming
    GROUP BY user_id
)
SELECT 
    u.user_id,
    u.user_name,
    DATEDIFF(day, ua.last_activity_date, CURRENT_DATE) as days_since_last_activity,
    ua.total_streams,
    ua.avg_duration,
    CASE 
        WHEN DATEDIFF(day, ua.last_activity_date, CURRENT_DATE) > 30 THEN 'High Risk'
        WHEN DATEDIFF(day, ua.last_activity_date, CURRENT_DATE) > 14 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END as churn_risk
FROM Dim_User u
JOIN user_activity ua ON u.user_id = ua.user_id;

-- 6. Content Binge-Watching Patterns
WITH viewing_sessions AS (
    SELECT 
        user_id,
        content_id,
        streaming_date_id,
        COUNT(*) as episodes_watched,
        SUM(duration_minutes) as total_duration
    FROM Fact_Streaming
    GROUP BY user_id, content_id, streaming_date_id
    HAVING COUNT(*) >= 3
)
SELECT 
    u.user_name,
    c.content_name,
    vs.episodes_watched,
    vs.total_duration
FROM viewing_sessions vs
JOIN Dim_User u ON vs.user_id = u.user_id
JOIN Dim_Content c ON vs.content_id = c.content_id
ORDER BY vs.episodes_watched DESC;

-- 7. User Engagement by Time of Day
SELECT 
    EXTRACT(HOUR FROM fs.start_time) as hour_of_day,
    COUNT(*) as total_streams,
    COUNT(DISTINCT fs.user_id) as unique_users,
    AVG(fs.duration_minutes) as avg_duration
FROM Fact_Streaming fs
GROUP BY EXTRACT(HOUR FROM fs.start_time)
ORDER BY hour_of_day;

-- 8. Subscription Plan Analysis
SELECT 
    p.plan_name,
    COUNT(DISTINCT s.user_id) as total_subscribers,
    AVG(fs.duration_minutes) as avg_viewing_time,
    COUNT(DISTINCT fs.content_id) as unique_content_watched
FROM Dim_Plan p
JOIN Dim_Subscription s ON p.plan_id = s.plan_id
JOIN Fact_Streaming fs ON s.subscription_id = fs.subscription_id
WHERE s.is_active = true
GROUP BY p.plan_name;
