#!/bin/sh

# make sure to store api key in ~/.wakatime.cfg

# [settings]
# api_key=

API_KEY=$(grep -E '^api_key=' "$HOME/.wakatime.cfg" | cut -d'=' -f2 | xargs)

if [ -z "$API_KEY" ]; then
    echo "API key not found in ~/.wakatime.cfg"
    exit 1
fi

ENCODED_KEY=$(echo -n "$API_KEY" | base64)

HEADER="Authorization: Basic $ENCODED_KEY"

TODAY=$(date +%Y-%m-%d)
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)

URL="https://wakatime.com/api/v1/users/current/summaries?start=$YESTERDAY&end=$TODAY"

response=$(curl -s -X GET -H "$HEADER" "$URL")

if [ -z "$response" ]; then
    echo "Failed to retrieve data from WakaTime API."
    exit 1
fi

cumulative_total=$(echo "$response" | jq -r '.cumulative_total.text')

echo "$cumulative_total"

