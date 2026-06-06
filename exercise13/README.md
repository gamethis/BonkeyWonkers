# Exercise 13 - Kubernetes: Helm & Kustomize

Back to [Main](../README.md)

**Time limit:** 20 minutes

## Overview

Package and deploy the bonkey app two ways — with **Helm** and with
**Kustomize**. Some of the provided files are broken or incomplete: parts are
marked `# TODO` for you to write, and other values are wrong and must be fixed.
Deploy each, observe what goes wrong, fix or complete it, and validate.

Helm resources go in the `bonkey-helm` namespace; Kustomize resources go in
`bonkey-kustomize`.

## Environment Setup

```shell
cd exercise13
./start.sh
```

It starts Minikube and builds the `bonkey-k8s:v1.0` image. `helm` and `kubectl`
(with built-in Kustomize) are pre-installed.

**Do not modify `start.sh`, `helloworld.py`, or `Dockerfile`.**

## Provided Files

| File | Description |
|------|-------------|
| `helloworld.py` / `Dockerfile` / `start.sh` | App and setup (do-not-edit) |
| `chart/` | A Helm chart for the bonkey app |
| `kustomize/base/` | Kustomize base manifests |
| `kustomize/overlays/prod/` | A `prod` overlay |

## Part A: Helm

### A.1 Install the Chart

Install the chart into the `bonkey-helm` namespace.

```bash
Use the helm Command-Line Interface (CLI)
```

**Expected Result**: The release installs, but the app does not come up
correctly as shipped.

### A.2 Fix and Re-install

Resolve what prevents the app from running, then install (or upgrade) the
release so `/hello` serves the greeting `Hello from Helm` — set that value
through Helm, **without editing the chart's default**.

```bash
Use the helm Command-Line Interface (CLI)
```

**Expected Result**: The release is deployed, its pods are Ready, and `/hello`
returns `Hello from Helm`.

## Part B: Kustomize

### B.1 Build the Prod Overlay

Render (or apply) the `prod` overlay.

```bash
Use the kubectl Command-Line Interface (CLI)
```

**Expected Result**: The build fails as shipped — resolve what stops it.

### B.2 Complete and Apply the Overlay

Complete the overlay's `# TODO` items, then apply it.

```bash
Edit the overlay, then use the kubectl Command-Line Interface (CLI)
```

**Requirement**: The applied resources are name-prefixed `prod-`, the Deployment
runs **3 replicas**, and the image is pinned through the overlay.

## Part C: Validate

### C.1 Validate Helm

```bash
Use the helm and kubectl Command-Line Interfaces (CLIs)
```

**Expected Result**: The release is listed and healthy, its pods are Ready, and
`/hello` returns `Hello from Helm` from inside the cluster.

### C.2 Validate Kustomize

```bash
Use the kubectl Command-Line Interface (CLI)
```

**Expected Result**: `prod-bonkey` resources exist in `bonkey-kustomize` with 3
replicas Ready, and `/hello` responds.

## Cleanup

Remove the Helm release and the Kustomize resources you created.

```bash
Use the helm and kubectl Command-Line Interfaces (CLIs)
```

## Exercise 13 Complete

Proceed to [Main](../README.md).
