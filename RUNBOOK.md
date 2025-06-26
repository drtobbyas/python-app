# Operations Runbook: FastAPI Service

This runbook provides procedures for common operational tasks and troubleshooting scenarios.

## Common Operations

### Checking Deployment Status

To check the status of the deployment and its pods:

```bash
kubectl get deployment fastapi-app
kubectl get pods -l app=fastapi-app
```

### Viewing Application Logs

To view the logs from a specific application pod:

```bash
# Get the name of a pod first
POD_NAME=$(kubectl get pods -l app=fastapi-app -o jsonpath="{.items[0].metadata.name}")

# Tail the logs
kubectl logs -f $POD_NAME
```

## Troubleshooting

### Scenario: Pods are in a `CrashLoopBackOff` state

1.  **Check Pod Logs:**
    - Use the `kubectl logs` command (see above) to inspect the logs for errors. Common issues include configuration errors, application exceptions, or problems connecting to dependencies.

2.  **Describe the Pod:**
    - Get more details about the pod's state and events:
    ```bash
    kubectl describe pod <pod-name>
    ```
    - Look for events that indicate why the pod is failing (e.g., image pull errors, readiness probe failures).

### Scenario: Health Check Fails

1.  **Verify Service and Endpoints:**
    - Ensure the `fastapi-app-service` exists and is correctly pointing to the application pods.
    ```bash
    kubectl describe svc fastapi-app-service
    ```

2.  **Check Network Policies:**
    - If a network policy is in place, ensure it allows traffic from your health check source to the application pods on port 8000.

3.  **Manual Port-Forward:**
    - Manually port-forward to a pod to isolate the issue:
    ```bash
    kubectl port-forward <pod-name> 8080:8000
    curl http://localhost:8080/health
    ```
