import pandas as pd

employees['birth_date'] = pd.to_datetime(employees['birth_date'])

employees.sort_values(by = 'birth_date')['employee_id'][:3]
