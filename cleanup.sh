#!/bin/bash

# # Secrets
API_KEY=$(cat ".cloudflare-secrets/.api-key")
EMAIL=$(cat ".cloudflare-secrets/.email")

if [ -f CERTBOT_$CERTBOT_DOMAIN/ZONE_ID ]; then
        ZONE_ID=$(cat CERTBOT_$CERTBOT_DOMAIN/ZONE_ID)
        rm -f CERTBOT_$CERTBOT_DOMAIN/ZONE_ID
fi

if [ -f CERTBOT_$CERTBOT_DOMAIN/RECORD_ID ]; then
        RECORD_ID=$(cat CERTBOT_$CERTBOT_DOMAIN/RECORD_ID)
        rm -f CERTBOT_$CERTBOT_DOMAIN/RECORD_ID
fi

# Remove the challenge TXT record from the zone
if [ -n "${ZONE_ID}" ]; then
    if [ -n "${RECORD_ID}" ]; then
        curl -s -X DELETE "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
                -H "X-Auth-Email: $EMAIL" \
                -H "X-Auth-Key: $API_KEY" \
                -H "Content-Type: application/json"
    fi
fi
