import pandas as pd;

filt = [r for r in direct_reports['position'] if 'manager' in r.lower()]

managers = direct_reports[direct_reports['position'].isin(filt)][['employee_id','position']].rename(columns = {'employee_id':'manager_id','position':'manager_title'})

merged_df = managers.merge(direct_reports,left_on = 'manager_id',right_on = 'managers_id')

merged_df.groupby(['manager_id','manager_title'])['employee_id'].count().reset_index()
