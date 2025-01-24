SELECT 
customer_id,transaction_id,amount,
(amount - amount*0.33) discounted_amount
FROM 
(SELECT *, 
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY transaction_id) count_transactions
FROM purchases 
)A
WHERE count_transactions = 3
ORDER BY 1 
