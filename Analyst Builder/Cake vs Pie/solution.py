import pandas as pd

# Solution 1 : Converting the SQL logic to pandas 
result = (
    desserts.groupby('date_sold')
    .apply(lambda group: pd.Series({
        'difference': abs(
            group.loc[group['product'] == 'Cake', 'amount_sold'].sum() -
            group.loc[group['product'] == 'Pie', 'amount_sold'].sum()
        ),
        'sold_more': 'Cake' if 
            group.loc[group['product'] == 'Cake', 'amount_sold'].sum() >
            group.loc[group['product'] == 'Pie', 'amount_sold'].sum() 
            else 'Pie'
    }))
    .reset_index()
)

result = result.sort_values(by='date_sold')
result

# Solution 2 : Pythonic way 
cake_sales = desserts[desserts['product'] == 'Cake'].groupby('date_sold')['amount_sold'].sum()
pie_sales = desserts[desserts['product'] == 'Pie'].groupby('date_sold')['amount_sold'].sum()

result = pd.DataFrame({
    'difference': (cake_sales - pie_sales).abs().astype('int'),
    'sold_more': np.where(cake_sales > pie_sales, 'Cake', 'Pie')
}).reset_index()
result = result.rename(columns={'index': 'date_sold'})

result = result[['date_sold', 'difference', 'sold_more']]

# Solution 3 : Using Pivot_table (Credits : Analyst Builder instructor tab)
desserts['amount_sold'].fillna(0, inplace=True)

pivot_df = desserts.pivot(index='date_sold', columns='product', values='amount_sold')

pivot_df['difference'] = abs(pivot_df['Cake'] - pivot_df['Pie'])
pivot_df['sold_more'] = pivot_df.apply(lambda row: 'Cake' if row['Cake'] > row['Pie'] else 'Pie', axis=1)

final = pivot_df.reset_index().sort_values(by='date_sold')

final[['date_sold', 'difference', 'sold_more']]
