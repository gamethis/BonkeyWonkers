#!/bin/bash
# Minikube Setup
# Run this script when you need to use Kubernetes/Minikube

echo "Starting Minikube"
echo "=============================================="

minikube start --driver=docker --memory=6144 --cpus=2

echo ""
minikube status

echo ""
echo "Starting Minikube dashboard in background..."
minikube dashboard &

echo ""
echo "Minikube setup complete!"
echo "Dashboard available at the URL shown above"
