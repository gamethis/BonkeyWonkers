# Exercise 11 — Kubernetes Fundamentals Assessment

Back to [Main](../README.md)

## Overview

You will deploy, manage, and troubleshoot a containerized Flask application on a
Kubernetes cluster. Starter files are provided — read them before beginning. You
are expected to determine the correct approach for each requirement without
step-by-step guidance.

**Time limit:** 90 minutes

## Environment Setup

A Minikube cluster and pre-built application image are required. Run the
provided setup script from the exercise directory before starting the assessment:

```shell
cd exercise11
./start.sh
```

The script starts Minikube and builds the `bonkey-k8s:latest` image into the
local registry. Do not modify `start.sh`, `helloworld.py`, or `Dockerfile`.

## Provided Files

Review all provided files before beginning:

| File | Description |
|------|-------------|
| `helloworld.py` | Flask application source |
| `Dockerfile` | Container image definition |
| `start.sh` | Environment setup script |
| `bonkey-namespace.yaml` | Namespace definition |
| `bonkey-configmap.yaml` | Application configuration |
| `bonkey-deployment.yaml` | Deployment manifest (incomplete) |
| `bonkey-service.yaml` | Service definition |
| `bonkey-hpa.yaml` | HorizontalPodAutoscaler (incomplete) |
| `bonkey-resourcequota.yaml` | ResourceQuota (incomplete) |
| `bonkey-ingress.yaml` | Ingress definition |
| `bonkey-pvc.yaml` | PersistentVolumeClaim (incomplete) |

Manifests marked **incomplete** require you to fill in missing values before
applying them. All resources belong to the `bonkey-app` namespace unless stated
otherwise.

---

## Section 1: Deploy the Application

Complete the incomplete manifests and deploy the full application stack. Resources
must be applied in an order that satisfies Kubernetes dependencies.

**Requirements:**

- All three pods are running and ready
- The application responds correctly to requests on the `/hello` endpoint
- The greeting message is sourced from the ConfigMap, not hardcoded
- Liveness and readiness probes are correctly configured and passing
- Resource requests and limits are set on the container

---

## Section 2: Application Updates

### 2.1 Rolling Update

Update the running deployment so that:

- The image tag is changed to `v1.1`
- The deployment runs 5 replicas
- The update completes with zero downtime
- You can demonstrate the rollout history

### 2.2 Configuration Update

Update the greeting message to `"Hello from Updated BonkeyWonkers!"` and apply
it to the running pods without manually deleting them.

Demonstrate that the live application reflects the new message.

---

## Section 3: Scaling and Resource Management

### 3.1 Horizontal Pod Autoscaler

Complete and apply `bonkey-hpa.yaml`. The HPA must:

- Target the bonkey Deployment
- Scale between a minimum and maximum replica count of your choosing
- Trigger scaling based on CPU utilization at a threshold you consider appropriate

Justify your chosen values.

### 3.2 Resource Quota

Complete and apply `bonkey-resourcequota.yaml` to enforce namespace-level
resource limits. Choose values that are consistent with the workload's requests
and the HPA's maximum replica count.

Demonstrate that the quota is active and show current utilization against the limits.

---

## Section 4: Troubleshooting

### 4.1 Pod Debugging

Scale the deployment down to 1 replica. Without deleting any pods:

- Retrieve and show the application logs
- Show the full event history for a running pod
- Access a shell inside the running container and list the contents of the
  application directory

### 4.2 Network Verification

Without using `kubectl port-forward` from your local machine, verify that the
bonkey Service is reachable from within the cluster and that DNS resolution
works for the service. Show the response from the `/hello` endpoint.

---

## Section 5: Advanced Configuration

### 5.1 Ingress with TLS

The `bonkey-ingress.yaml` is provided. Before applying it:

1. Generate a self-signed TLS certificate for the hostname defined in the Ingress
2. Store it as a Kubernetes Secret with the name referenced in the Ingress spec
3. Apply the Ingress and verify it is configured correctly

### 5.2 Persistent Storage

Complete and apply `bonkey-pvc.yaml`. Then update the Deployment to:

- Mount the volume at `/data`
- Include an init container that writes the current timestamp to
  `/data/init-timestamp.txt` before the main container starts

Verify that the init container ran and that the file exists with the correct
content after pods restart.

---

## Cleanup

Delete all resources created during this exercise.

---

## Submission

For each section, be prepared to:

1. Show the relevant running resources with `kubectl`
2. Explain the choices you made for any values you filled in
3. Describe what would happen if a specific manifest field were changed or removed
