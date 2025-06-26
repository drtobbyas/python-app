#!/bin/bash
# This script checks the health of the deployed application.

set -e

SERVICE_NAME="fastapi-app-service"
NAMESPACE="default"
LOCAL_PORT=8080
REMOTE_PORT=80

echo "Checking application health by port-forwarding service '$SERVICE_NAME'..."

# Start port-forwarding in the background
kubectl port-forward svc/$SERVICE_NAME -n $NAMESPACE $LOCAL_PORT:$REMOTE_PORT &>
/dev/null &
PF_PID=$!

# Allow time for port-forwarding to establish
sleep 2

# Check the health endpoint
STATUS_CODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" http://localhost:$LOCAL_PORT/health)

# Kill the port-forwarding process
kill $PF_PID

if [ "$STATUS_CODE" -eq 200 ]; then
  echo "\nHealth check PASSED. Application is healthy."
  exit 0
else
  echo "\nHealth check FAILED. Status code: $STATUS_CODE"
  exit 1
fi
