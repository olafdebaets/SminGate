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


# generate deployment for hello-world app
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: hello-world
  name: hello-world
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello-world
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: hello-world
    spec:
      containers:
      - image: alpine:latest # used alpine image to recreate hello world app
        name: hello-world
        command: ["/bin/sh"]
        args: ["-c", "echo HELLO WORLD, $PARAMETER1 - $PARAMETER2"]
        resources: {}
EOF

# check output of the pod with label app=hello-world
kubectl logs --selector app=hello-world




