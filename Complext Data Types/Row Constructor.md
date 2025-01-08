A ROW expression allows you to construct ROW values, which can represent anonymous records, 
specific table row types, or custom composite types

The ROW constructor creates a composite value (like a single record or row) from multiple individual values. 
It's similar to creating a tuple or struct in other programming languages.

Example : 

CREATE TYPE scd_type AS (
    scoring_class VARCHAR,
    is_active BOOLEAN,
    start_date DATE,
    end_date DATE
);

-- Sample data
WITH player_status AS (
    SELECT 
        'John Smith' as player_name,
        'Rookie' as scoring_class,
        true as is_active,
        '2024-01-01' as current_season
),

player_history AS (
    SELECT 
        'John Smith' as player_name,
        'Amateur' as scoring_class,
        false as is_active,
        '2023-01-01' as start_season,
        '2023-12-31' as end_season
)

SELECT 
    ps.player_name,
    UNNEST(ARRAY[
        ROW(
            ph.scoring_class,    -- 'Amateur'
            ph.is_active,        -- false
            ph.start_season,     -- '2023-01-01'
            ph.end_season        -- '2023-12-31'
        )::scd_type,
        ROW(
            ps.scoring_class,    -- 'Rookie'
            ps.is_active,        -- true
            ps.current_season,   -- '2024-01-01'
            ps.current_season    -- '2024-01-01'
        )::scd_type
    ]) as records
FROM player_status ps
JOIN player_history ph ON ps.player_name = ph.player_name;

Output 
player_name  | records
-------------+----------------------------------------
John Smith   | (Amateur, false, 2023-01-01, 2023-12-31)

John Smith   | (Rookie, true, 2024-01-01, 2024-01-01)

The first ROW shows John's historical status as an Amateur player
The second ROW shows his current status as a Rookie
Both records are cast to scd_type to ensure they have the same structure
UNNEST spreads these two records into separate rows

References : 
[Stackoverflow](https://stackoverflow.com/questions/32164926/what-is-a-row-constructor-used-for)

[SCD Modeling ](https://github.com/saitiger/Data-Engineering/blob/main/Dimensional%20Modeling/SCD%20Modeling.sql)
