#!/bin/bash
# This script rolls back the deployment to the previous version.

set -e

DEPLOYMENT_NAME="fastapi-app"

echo "Rolling back deployment '$DEPLOYMENT_NAME'..."

kubectl rollout undo deployment/$DEPLOYMENT_NAME

echo "Rollback initiated. Checking status..."
kubectl rollout status deployment/$DEPLOYMENT_NAME
