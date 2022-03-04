#!/bin/sh -l

minimum=$(curl --url 'https://phpreleases.com/api/releases/minimum-supported/active')
echo "::set-output name=releases::$minimum"
latest=$(curl --url 'https://phpreleases.com/api/releases/latest')
echo "::set-output name=releases::$latest%.*"
