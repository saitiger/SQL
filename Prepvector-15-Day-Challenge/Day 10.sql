CREATE TABLE likes (
user_id VARCHAR(50),
created_at DATETIME,
liker_id VARCHAR(50)
);

INSERT INTO likes (user_id, created_at, liker_id) VALUES
('A', '2024-01-01 10:00:00', 'B'),
('B', '2024-01-01 11:00:00', 'C'),
('B', '2024-01-01 12:00:00', 'D'),
('B', '2024-01-01 13:00:00', 'E'),
('C', '2024-01-02 10:00:00', 'A'),
('D', '2024-01-02 14:00:00', 'E'),
('E', '2024-01-02 15:00:00', 'F'),
('B', '2024-01-03 09:00:00', 'G'),
('H', '2024-01-03 10:00:00', 'A'),
('B', '2024-01-03 11:00:00', 'C'),
('I', '2024-01-03 12:00:00', 'I');

"""
A dating website’s schema is represented by a table of people that like other people. The table has three columns. 
One column is the user_id, another column is the liker_id which is the user_id of the user doing the liking, and the last column is the date time that the like occurred.
Write a query to count the number of liker’s likers (the users that like the likers) if the liker has one.
"""

SELECT users.user_id AS user,  
       COUNT(DISTINCT likers.liker_id) AS count  
FROM likes users    
JOIN likes likers   
ON users.liker_id = likers.user_id  
GROUP BY users.user_id  
ORDER BY users.user_id;  
