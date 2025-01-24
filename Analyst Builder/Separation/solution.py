import pandas as pd

# Solution 1 : When we know the length of the ID {As per the question}
bad_data['ID'] = bad_data['id'].str[:5]
bad_data['FirstName'] = bad_data['id'].str[5:]
# Can drop if the purpose is to fix the dataset else just view the data
# bad_data.drop(columns = 'id',axis = 1,inplace = True)
# bad_data
bad_data[['ID', 'FirstName']]

# Solution 2 
bad_data['ID'] = bad_data['id'].str.extract(r'^(\d+)')  # Extract numeric prefix as ID
bad_data['FirstName'] = bad_data['id'].str.extract(r'(\D+)$')  # Extract non-numeric suffix as FirstName
bad_data[['ID', 'FirstName']]
