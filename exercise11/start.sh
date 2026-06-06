#!/bin/bash
# Exercise 11 - start Minikube and build the bonkey-k8s image
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
echo "Image available in-cluster:"
minikube image ls | grep bonkey-k8s || true

echo ""
echo "Setup complete. Begin with the manifests in this directory, e.g.:"
echo "  kubectl apply -f bonkey-namespace.yaml"
