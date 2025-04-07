CREATE TABLE users (
id INTEGER PRIMARY KEY,
username VARCHAR(50)
);

INSERT INTO users (id, username) VALUES
(1, 'john_doe'),
(2, 'jane_smith'),
(3, 'bob_wilson');

CREATE TABLE song_plays (
id INTEGER PRIMARY KEY,
played_at DATETIME,
user_id INTEGER,
song_id INTEGER
);

INSERT INTO song_plays (id, played_at, user_id, song_id) VALUES
(1, '2024-01-01 10:00:00', 1, 101),
(2, '2024-01-01 14:00:00', 1, 101),
(3, '2024-01-02 09:00:00', 1, 102),
(4, '2024-01-03 16:00:00', 1, 103),
(5, '2024-01-04 11:00:00', 1, 104),
(6, '2024-01-01 09:00:00', 2, 201),
(7, '2024-01-01 15:00:00', 2, 202),
(8, '2024-01-02 10:00:00', 2, 203),
(9, '2024-01-02 14:00:00', 2, 203),
(10, '2024-01-01 12:00:00', 3, 301),
(11, '2024-01-02 13:00:00', 3, 302);

"""
Given a table of song_plays and a table of users, write a query to extract the earliest date each user played their third unique song and order by date played.
"""
  
WITH unique_songs AS (
    SELECT 
        user_id, 
        song_id, 
        MIN(played_at) AS played_at
    FROM song_plays
    GROUP BY user_id, song_id
),
rank_cte AS (
    SELECT
        user_id, 
        song_id, 
        played_at,
        RANK() OVER (PARTITION BY user_id ORDER BY played_at) AS rank_val
    FROM unique_songs
)
SELECT
    u.username AS username,
    r.song_id AS song_id,
    r.played_at AS played_at
FROM users u
JOIN rank_cte r
    ON u.id = r.user_id AND r.rank_val = 3
ORDER BY r.played_at;
