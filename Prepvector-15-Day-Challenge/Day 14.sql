CREATE TABLE transactions (
id INT PRIMARY KEY,
product_id INT,
quantity INT,
created_at TIMESTAMP,
FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO transactions (id, product_id, quantity, created_at) VALUES
(1, 101, 2, '2019-01-15 10:00:00'),
(2, 102, 1, '2019-01-20 12:30:00'),
(3, 101, 3, '2019-02-10 14:00:00'),
(4, 103, 1, '2019-02-25 16:15:00'),
(5, 102, 4, '2019-03-05 09:30:00'),
(6, 101, 1, '2019-03-18 13:45:00');

CREATE TABLE products (
id INT PRIMARY KEY,
price DECIMAL(10, 2)
);

INSERT INTO products (id, price) VALUES
(101, 20.00),
(102, 15.00),
(103, 30.00);

"""
Given a table of transactions and products, write a function to get the month_over_month change in revenue for the year 2019. 
Make sure to round month_over_month to 2 decimal places.
"""

WITH monthly_revenue AS (
    SELECT
        CAST(strftime('%m', created_at) AS INTEGER) AS month,
        SUM(quantity * price) AS current_revenue
    FROM transactions t 
    JOIN products p ON t.product_id = p.id
    WHERE created_at > '2019-01-01' AND created_at < '2020-01-01'
    GROUP BY month
), 
previous_month_revenue AS (
    SELECT
        *,
        LAG(current_revenue) OVER(ORDER BY month) AS prev_month
    FROM monthly_revenue
)
SELECT
    month,
    ROUND(
        CASE
            WHEN prev_month IS NULL THEN NULL
            ELSE ((current_revenue - prev_month) * 100.0) / prev_month
        END,
        2
    ) AS month_over_month
FROM previous_month_revenue;
