#!/usr/bin/bash

curl -s "https://aviationweather.gov/api/data/metar?ids=KMCI&format=json&taf=false&hours=12&bbox=40%2C-90%2C45%2C-85" > aviation.json

# steps 3 and 4, pulls receiptTime and outputs the first 6
jq -r '[.[].receiptTime] | .[:6][]' aviation.json

# step 5 and 6, pulls temperatures and averages them. Outputs on one line like the example
echo -n "Average Temperature: "
jq -r '[.[].temp] | (add/length)' aviation.json

# steps 7 and 8, checks and outputs true if >half the reports were not CLR
echo -n "Mostly Cloudy: "
cloudy_count=$(jq '[.[].clouds[] | select(.cover != "CLR")] | length' aviation.json)
if [ "$cloudy_count" -gt 6 ]; then
    echo "true"
else
    echo "false"
fi