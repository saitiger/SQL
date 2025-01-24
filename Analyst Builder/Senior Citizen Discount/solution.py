import pandas as pd
from datetime import datetime

customers['birth_date'] = pd.to_datetime(customers['birth_date'])
current_date = datetime(2023, 1, 1)
customers['Age'] = (current_date - customers['birth_date']).dt.days // 365
senior_customers = customers[customers['Age'] >= 55]
senior_customers[['customer_id']].sort_values(by='customer_id')
