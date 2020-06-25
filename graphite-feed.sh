#!/bin/bash

PORT=2003
SERVER=graphite
ECI_URL="https://eci.ec.europa.eu/012/public/"
API="api/report/map"
JSON=$(curl ${ECI_URL}${API})
JSON_FORMATED=$(echo $JSON |jq '.signatureCountryCount[] | {count: .count, country: .countryCode}')
COUNTRY_LIST=$(echo $JSON_FORMATED|jq -r '. | .country')


for country in $(echo $COUNTRY_LIST)
do
        echo $country
        COUNT=$(echo $JSON_FORMATED |jq --arg COUNTRY "$country" '. | select(.country==$COUNTRY) | .count')
        echo $COUNT
        echo "local.finning.$country $COUNT  `date +%s`" | nc ${SERVER} ${PORT}
done
