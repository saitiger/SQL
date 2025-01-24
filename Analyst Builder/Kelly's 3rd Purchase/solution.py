purchases['rn'] = purchases.groupby('customer_id')['transaction_id'].rank()

third_transaction = purchases[purchases['rn'] == 3].copy()

third_transaction['discounted_amount'] = round(third_transaction['amount'] * 0.67, 2)

third_transaction[['customer_id', 'transaction_id', 'amount', 'discounted_amount']].sort_values('customer_id')
