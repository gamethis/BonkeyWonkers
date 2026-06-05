#!/bin/bash
# Exercise 11 - Start Minikube and build the application image
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Start Minikube ---
if minikube status &>/dev/null 2>&1; then
  echo "Minikube is already running."
  minikube status
else
  echo "Starting Minikube..."
  minikube start --driver=docker --memory=6144 --cpus=2
  minikube status
fi

echo ""

# --- Build application image ---
echo "Building bonkey-k8s:latest Docker image..."
cd "$SCRIPT_DIR"
docker build -t bonkey-k8s:latest .

# --- Load image into Minikube's registry ---
echo "Loading bonkey-k8s:latest into Minikube..."
minikube image load bonkey-k8s:latest

echo ""
echo "================================================================"
echo "  Kubernetes cluster is ready."
echo ""
echo "  Verify the cluster:    kubectl get nodes"
echo "  Verify the image:      minikube image ls | grep bonkey-k8s"
echo ""
echo "  When ready, apply manifests in order:"
echo "    kubectl apply -f bonkey-namespace.yaml"
echo "    kubectl apply -f bonkey-configmap.yaml"
echo "    kubectl apply -f bonkey-deployment.yaml"
echo "    kubectl apply -f bonkey-service.yaml"
echo "================================================================"
