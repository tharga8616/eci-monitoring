#!/bin/sh

# Graphite host:port
PORT=2003
SERVER=graphite

# ECI API query
API=/api/report/map

# ECI_URL from docker ENV
JSON=$(curl ${ECI_URL}${API})
JSON_FORMATED=$(echo $JSON |jq '.signatureCountryCount[] | {count: .count, country: .countryCode}')
COUNTRY_LIST=$(echo $JSON_FORMATED|jq -r '. | .country')


for country in $(echo $COUNTRY_LIST)
do 
	echo $country
	COUNT=$(echo $JSON_FORMATED |jq --arg COUNTRY "$country" '. | select(.country==$COUNTRY) | .count')
	echo $COUNT
	echo "eci.$ECI_NAME.$country $COUNT  `date +%s`" | nc ${SERVER} ${PORT}
	echo "eci.$ECI_NAME.$country $COUNT  `date +%s`" >> /opt/graphite/storage/eci_data_backup.raw
done


