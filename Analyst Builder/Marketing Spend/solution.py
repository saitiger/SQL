import pandas as pd

marketing_spend['ROI'] = (100 * (marketing_spend['revenue_generated'] - marketing_spend['investment']) / marketing_spend['investment']).round().astype(int)

# Calculate the 75th percentile for the ROI column
top_25_threshold = marketing_spend['ROI'].quantile(0.75)

# Filter rows where ROI is greater than or equal to the 75th percentile
top_25_percent = marketing_spend[marketing_spend['ROI'] >= top_25_threshold]

top_25_percent[['campaign_id', 'campaign_name', 'ROI']].sort_values(
    by=['ROI', 'campaign_id'], ascending=[False, False]
)

