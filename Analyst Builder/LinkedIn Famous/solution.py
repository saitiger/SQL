import pandas as pd;

linkedin_posts['popularity'] = 100.0*linkedin_posts['actions']/linkedin_posts['impressions']

linkedin_posts[linkedin_posts['popularity']>=1].sort_values(by = 'popularity',ascending = False)[['post_id','popularity']]
