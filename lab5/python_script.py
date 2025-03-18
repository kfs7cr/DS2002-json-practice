#!/home/codespace/.python/current/bin/python3

import json
import pandas as pd

with open('/workspaces/DS2002-json-practice/data/schacon.repos.json', 'r') as file:
    data = json.load(file)

# iii. assembling name, html_url, updated_at,visibility via c. Using json_normalize from the Pandas library
normalized_data = pd.json_normalize(data)[['name','html_url','updated_at','visibility']]

# iv. exports the first 5 lines to chacon.csv
normalized_data.head(5).to_csv('chacon.csv', index=False, header=False)