#!/bin/bash

URL_AUTH="https://151dd0e4-bd8b-453b-a01c-924e75053a8b.mock.pstmn.io/auth"
URL_PARAMETERS="https://151dd0e4-bd8b-453b-a01c-924e75053a8b.mock.pstmn.io/parameters"


# 1.get the auth token from url_auth
token=$(curl -s "$URL_AUTH")

# check token
echo "token: $token"

# 2.retrieve PARAMETER1 and PARAMETER2 by passing the token via http GET parameter named 'TOKEN' in the header(-H)
response=$(curl -s -H "TOKEN: $token" "$URL_PARAMETERS")


# Extract PARAMETER1 and PARAMETER values from response (jq -r option eliminates the square brackets)
PARAMETER1=$(echo "$response" | jq -r '.PARAMETER1')
PARAMETER2=$(echo "$response" | jq -r '.PARAMETER2')

# check extracted param.
echo "p1: $PARAMETER1"
echo "p2: $PARAMETER2"

