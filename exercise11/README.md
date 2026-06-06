# Exercise 11 - Kubernetes: Deploy & Troubleshoot

Back to [Main](../README.md)

**Time limit:** 45 minutes

## Overview

Deploy a containerized Flask application to a Kubernetes (Minikube) cluster, get
it healthy, and validate it. The provided manifests are **neither complete nor
entirely correct**:

- Some required fields are missing and marked with `# TODO` — you must write them.
- Other values are present but wrong — you must find and fix them.

Deploy the manifests, observe what goes wrong, diagnose and fix the problems,
redeploy, and validate. You are expected to work from the symptoms without
step-by-step guidance.

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

### 1.1 Apply the Manifests

Apply the provided manifests in an order that satisfies Kubernetes
dependencies.

```bash
Use the kubectl Command-Line Interface (CLI)
```

**Expected Result**: Resources are created in the `bonkey-app` namespace, but
the application does **not** come up cleanly. This is intended.

## Step 2: Diagnose and Fix

### 2.1 Investigate

Inspect the failing resources and determine why the application is not healthy.

```bash
Use the kubectl Command-Line Interface (CLI)
```

**Expected Result**: You identify each problem from its symptoms — for example
pods that will not start, pods that never become Ready, or a Service with no
endpoints.

### 2.2 Correct the Manifests

Fix the incorrect values and complete the fields marked `# TODO`.

```bash
Edit the appropriate manifest files
```

**Requirement**: Address both the incorrect values and the missing (`# TODO`)
fields.

## Step 3: Redeploy

### 3.1 Re-apply and Watch the Rollout

Apply your corrected manifests and watch the Deployment roll out.

```bash
Use the kubectl Command-Line Interface (CLI)
```

**Expected Result**: The rollout completes and all pods become Ready.

## Step 4: Validate

### 4.1 Verify Pods and Endpoints

Confirm the workload is healthy.

```bash
Use the kubectl Command-Line Interface (CLI)
```

**Expected Result**: All pods are Running and Ready, and the Service has
endpoints.

### 4.2 Verify the Application Response

Confirm the application returns the greeting from the ConfigMap.

```bash
Use the kubectl Command-Line Interface (CLI)
```

**Expected Result**: `/hello` returns JSON whose greeting comes from the
ConfigMap, not the hardcoded default.

### 4.3 Verify In-Cluster Reachability

Confirm the Service is reachable from inside the cluster by its DNS name.

```bash
Use the kubectl Command-Line Interface (CLI)
```

**Expected Result**: A request to the Service's in-cluster DNS name returns the
`/hello` response.

## Cleanup

Delete all resources you created during this exercise.

```bash
Use the kubectl Command-Line Interface (CLI)
```

## Exercise 11 Complete

Proceed to [Main](../README.md).
