#!/bin/sh -l

Minimum=$(curl -k --url 'https://phpreleases.com/api/releases/minimum-supported/active' | jq -r '(.major|tostring) + "." + (.minor|tostring)')
Latest=$(curl -k --url 'https://phpreleases.com/api/releases/latest' | jq -r 'split(".") | .[0] + "." + .[1]')

echo "::set-output name=range::{\"include\":[{\"php\":\"${Minimum}\"},{\"php\":\"${Latest}\"}]}"
