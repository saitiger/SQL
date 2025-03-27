WITH RankedTransactions AS (
    SELECT 
        id,
        transaction_value,
        created_at,
        ROW_NUMBER() OVER (PARTITION BY DATE(created_at) ORDER BY created_at DESC) AS rnk
    FROM customer_sales
)
SELECT 
    id,
    created_at,
    transaction_value
FROM RankedTransactions
WHERE rnk = 1
ORDER BY created_at
