import pandas as pd

products['size_change_percentage'] = round(((products['new_size'] - products['original_size']) / products['original_size']) * 100, 0)
products['price_change_percentage'] = round(((products['new_price'] - products['original_price']) / products['original_price']) * 100, 0)
products['shrinkflation_flag'] = (products['new_size'] < products['original_size']) & (products['new_price'] >= products['original_price'])
products['shrinkflation_flag'] = products['shrinkflation_flag'].map({True: 'True', False: 'False'})

products.sort_values(by='product_name', ascending=True)[['product_name', 'size_change_percentage', 'price_change_percentage', 'shrinkflation_flag']]
