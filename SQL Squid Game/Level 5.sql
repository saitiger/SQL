SELECT 
WITH 
alive_players AS
(
SELECT id,first_name 
FROM 
player
WHERE status = 'alive'
),
eligible_interaction AS(
SELECT 
*
FROM
Daily_interactions
WHERE player1_id = 456 or player2_id = 456
AND player1_id IN (SELECT id FROM alive_players)
AND player2_id IN (SELECT id FROM alive_players)
UNION
SELECT 
*
FROM
Daily_interactions
WHERE player2_id = 456 or player1_id = 456
AND player1_id IN (SELECT id FROM alive_players)
AND player2_id IN (SELECT id FROM alive_players) 
)
SELECT player1_id,
COUNT(*) cnt
FROM eligible_interaction
WHERE player1_id<>456
GROUP BY 1
UNION
SELECT player2_id,
COUNT(*) cnt
FROM eligible_interaction
WHERE player2_id<>456
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 1

SELECT 
  p1.first_name AS player1_name,
  p2.first_name AS player2_name,
  COUNT(*) AS interaction_count
FROM daily_interactions di
JOIN player p1 ON p1.id = 456
JOIN player p2 ON p2.id = 390
WHERE (di.player1_id = 456 AND di.player2_id = 390)
   OR (di.player1_id = 390 AND di.player2_id = 456)
GROUP BY p1.first_name, p2.first_name;

-- Solution 2 
SELECT 
  CASE 
    WHEN player1_id = 456 THEN player2_id 
    ELSE player1_id 
  END AS other_player_id
FROM daily_interactions
WHERE player1_id = 456 OR player2_id = 456
GROUP BY other_player_id
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT 
  p1.first_name AS player1_name,
  p2.first_name AS player2_name,
  COUNT(*) AS interaction_count
FROM daily_interactions di
JOIN player p1 ON p1.id = 456
JOIN player p2 ON p2.id = 390
WHERE (di.player1_id = 456 AND di.player2_id = 390)
   OR (di.player1_id = 390 AND di.player2_id = 456)
GROUP BY p1.first_name, p2.first_name;
