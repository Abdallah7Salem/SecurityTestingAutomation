#!/bin/bash

echo "Running API Security Tests..."

echo "Test 1: Missing Authorization"
curl -s -o /dev/null -w "%{http_code}\n" \
  -X POST "https://stg-app.bosta.co/api/v2/pickups" \
  -H "Content-Type: application/json" \
  -d '{"businessLocationId":"MFqXsoFhxO"}'

echo "Test 2: Invalid Token"
curl -s -o /dev/null -w "%{http_code}\n" \
  -X POST "https://stg-app.bosta.co/api/v2/pickups" \
  -H "Content-Type: application/json" \
  -H "Authorization: INVALIDTOKEN" \
  -d '{"businessLocationId":"MFqXsoFhxO"}'

echo "Test 3: SQL Injection"
curl -s -o /dev/null -w "%{http_code}\n" \
  -X POST "https://stg-app.bosta.co/api/v2/pickups" \
  -H "Content-Type: application/json" \
  -H "Authorization: '"$API_TOKEN"'" \
  -d '{"businessLocationId":"MFqXsoFhxO\" OR \"1\"=\"1"}'

echo "All tests finished."
