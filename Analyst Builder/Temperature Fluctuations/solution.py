import pandas as pd

temperatures[temperatures.sort_values(by='date')['temperature'].diff()>0].sort_values(by='date')['date']
