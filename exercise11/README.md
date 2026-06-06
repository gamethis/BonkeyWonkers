# Exercise 11 - Kubernetes Fundamentals

Back to [Main](../README.md)

**Time limit:** 45 minutes

## Overview

Deploy a containerized Flask application to a Kubernetes (Minikube) cluster, get
it healthy, and validate it. The provided manifests are **neither complete nor
entirely correct**:

- Some required fields are missing and marked with `# TODO` — you must write them.
- Other values are present but wrong — you must find and fix them.

Your job is to deploy the manifests, observe what goes wrong, diagnose and fix
the problems, redeploy, and validate. You are expected to work from the symptoms
without step-by-step guidance.

All resources belong to the `bonkey-app` namespace.

## Environment Setup

Run the provided setup script from the exercise directory before you start:

```shell
cd exercise11
./start.sh
```

It starts Minikube and builds the `bonkey-k8s:v1.0` image into the cluster.

**Do not modify `start.sh`, `helloworld.py`, or `Dockerfile`.**

## Provided Files

| File | Description |
|------|-------------|
| `helloworld.py` | Flask app: `/hello` greeting, `/health` probe (5000) |
| `Dockerfile` | Container image definition |
| `start.sh` | Minikube + image build |
| `bonkey-namespace.yaml` | Namespace |
| `bonkey-configmap.yaml` | Application configuration (the greeting) |
| `bonkey-deployment.yaml` | Deployment |
| `bonkey-service.yaml` | Service (port 80 → 5000) |

## Step 1: Deploy the Application

Apply the manifests in an order that satisfies Kubernetes dependencies. Expect
the application **not** to come up cleanly — that is intended.

## Step 2: Diagnose and Fix

Investigate why the application is not healthy and resolve every problem. Useful
starting points:

```shell
kubectl get pods -n bonkey-app
kubectl describe pod <pod> -n bonkey-app
kubectl logs <pod> -n bonkey-app
kubectl get endpoints bonkey -n bonkey-app
```

Both the missing (`# TODO`) fields and the incorrect values must be addressed.

## Step 3: Redeploy

Re-apply your corrected manifests and watch the rollout complete.

```shell
kubectl rollout status deployment/bonkey -n bonkey-app
```

## Step 4: Validate

Demonstrate all of the following:

- All pods are **Running and Ready**.
- `/hello` returns JSON, and the greeting comes from the ConfigMap (not the
  hardcoded default).
- The `bonkey` Service is reachable **from inside the cluster** by its DNS name
  (`bonkey.bonkey-app.svc.cluster.local`) — show the `/hello` response.

## Cleanup

Delete all resources you created during this exercise.

## Exercise 11 Complete

Proceed to [Main](../README.md).
