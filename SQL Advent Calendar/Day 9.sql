WITH CalorieDensity AS (
    SELECT
        m.dish_name,
        e.event_name,
        (m.calories / m.weight_g) AS calorie_density
    FROM
        menu m
    INNER JOIN
        events e ON m.event_id = e.event_id
),
RankedDishes AS (
    SELECT
        cd.dish_name,
        cd.event_name,
        cd.calorie_density,
        ROW_NUMBER() OVER (PARTITION BY cd.event_name ORDER BY cd.calorie_density DESC) rnk
    FROM
        CalorieDensity cd
)
SELECT
    dish_name,
    event_name,
    calorie_density
FROM
    RankedDishes
WHERE
    rnk <= 3
ORDER BY
    event_name,
    rnk
