#!/bin/bash
# This script applies all Kubernetes manifests to deploy the application.

set -e

echo "Applying Kubernetes manifests..."

# Apply core application manifests
kubectl apply -f k8s/

# Apply security-related manifests
kubectl apply -f security/

echo "Deployment manifests applied successfully."
kubectl get pods -l app=fastapi-app
