#!/bin/bash
# This script deploys the application by substituting the image placeholder and applying all manifests.

set -e

# The script accepts an optional argument for the full image name with tag.
# If no argument is provided, it defaults to 'fastapi-app:latest'.
if [ -z "$1" ]; then
    echo "No image specified. Defaulting to 'fastapi-app:latest'."
    FULL_IMAGE_NAME="fastapi-app:latest"
else
    FULL_IMAGE_NAME=$1
fi

echo "Applying base Kubernetes manifests (excluding deployment)..."
# Substitute the placeholder in the deployment manifest
sed "s|DOCKER_IMAGE_PLACEHOLDER|$FULL_IMAGE_NAME|g" k8s/deployment.yaml

echo "Deploying application with image: $FULL_IMAGE_NAME"
kubectl apply -f k8s/

kubectl apply -f security/

echo "Waiting for deployment rollout to complete..."
kubectl rollout status deployment/fastapi-app

echo "Deployment successful."
kubectl get pods -l app=fastapi-app
