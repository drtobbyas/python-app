# Production-Ready FastAPI Service

This project provides a comprehensive setup for deploying a FastAPI application to a Kubernetes cluster, following production-ready best practices.

## Features

- **Containerization**: Multi-stage, security-hardened Dockerfile.
- **Kubernetes Deployment**: Full set of manifests for deployment, service, config, secrets, autoscaling, and security.
- **CI/CD**: Automated testing and deployment pipeline using GitHub Actions.
- **Monitoring**: Prometheus metrics endpoint and a sample Grafana dashboard.
- **Security**: RBAC, Network Policies, and Pod Security Policies.
- **Automation**: Scripts for deployment, health checks, and rollbacks.

## Prerequisites

- Docker
- kubectl
- A Kubernetes cluster
- A Docker Hub account
- A configured `kubeconfig` file

## Setup and Deployment

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd python-test
    ```

2.  **Configure Secrets:**
    - In your GitHub repository, go to `Settings > Secrets and variables > Actions` and add the following secrets:
      - `DOCKERHUB_USERNAME`: Your Docker Hub username.
      - `DOCKERHUB_TOKEN`: A Docker Hub access token.
      - `KUBE_CONFIG_DATA`: The base64-encoded content of your `kubeconfig` file.

3.  **Manual Deployment (Optional):**
    - To deploy manually, you can use the provided script:
    ```bash
    ./scripts/deploy.sh
    ```

4.  **CI/CD Deployment:**
    - Push a commit to the `main` branch to trigger the GitHub Actions workflow, which will automatically test, build, and deploy the application.

## Usage

- **Health Check:**
  ```bash
  ./scripts/health-check.sh
  ```

- **Rollback:**
  ```bash
  ./scripts/rollback.sh
  ```
