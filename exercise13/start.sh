#!/bin/bash
# Exercise 13 - start Minikube and build the bonkey-k8s image
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Ensuring Minikube is running..."
if ! minikube status >/dev/null 2>&1; then
  minikube start --driver=docker --memory=6144 --cpus=2
fi

echo "Building bonkey-k8s:v1.0 into Minikube..."
minikube image build -t bonkey-k8s:v1.0 .

echo ""
echo "Tooling:"
helm version --short 2>/dev/null || echo "  helm: NOT FOUND"
kubectl version --client -o yaml >/dev/null 2>&1 \
  && echo "  kubectl + built-in kustomize (kubectl apply -k) available"

echo ""
echo "Setup complete. See README.md for the Helm and Kustomize tasks."
