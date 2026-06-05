# Exercise 11 — Assessor Evaluation Guide

This document is for the assessor. Do not share with candidates.

---

## Scoring Summary

| Section | Points |
|---------|--------|
| 1 — Deploy the Application | 25 |
| 2 — Application Updates | 20 |
| 3 — Scaling and Resource Management | 20 |
| 4 — Troubleshooting | 20 |
| 5 — Advanced Configuration | 15 |
| **Total** | **100** |

Pass threshold: 70 points. Sections 1 and 4 are the strongest signal for
fundamentals — a candidate who cannot complete Section 1 or Section 4 is
unlikely to pass regardless of score elsewhere.

---

## Section 1: Deploy the Application (25 pts)

### What to verify

```sh
kubectl get pods -n bonkey-app
kubectl get endpoints bonkey -n bonkey-app
kubectl port-forward svc/bonkey 8080:80 -n bonkey-app
curl localhost:8080/hello
```

### Scoring

| Criterion | Points |
|-----------|--------|
| All 3 pods Running and Ready | 5 |
| `/hello` returns JSON with greeting from ConfigMap | 5 |
| Liveness and readiness probes configured correctly (`/health`, port 5000) | 5 |
| Resource requests AND limits set on the container | 5 |
| Resources applied in correct dependency order (namespace → configmap → deployment → service) | 5 |

### Acceptable resource values

Requests and limits do not need to match the reference values exactly, but the
candidate should be able to justify their choices. Red flags:

- Requests equal to limits with very high values (no understanding of burstable QoS)
- No requests set at all (HPA requires requests to function)
- Memory limit below what Flask reasonably needs (~64Mi minimum)
- Probes pointing to `/hello` instead of `/health` — acceptable but shows less
  awareness of the health check endpoint distinction

### Common mistakes

- Applying deployment before namespace or configmap exists
- Setting `imagePullPolicy: Always` on a locally-loaded Minikube image (pods
  will fail to start)
- Probe `initialDelaySeconds` too low causing restart loops on slow start

---

## Section 2: Application Updates (20 pts)

### 2.1 Rolling Update — What to verify

```sh
kubectl rollout status deployment/bonkey -n bonkey-app
kubectl rollout history deployment/bonkey -n bonkey-app
kubectl get pods -n bonkey-app
```

| Criterion | Points |
|-----------|--------|
| Image tag updated to `v1.1` | 3 |
| Replicas scaled to 5 | 3 |
| Can show rollout history (revision 2 present) | 2 |
| No downtime during update (maxUnavailable: 0 preserved) | 2 |

**Strong signal:** Candidate uses `kubectl rollout status` to watch the update
rather than just applying and immediately checking.

**Weak signal:** Candidate deletes and recreates pods manually instead of using
`kubectl apply` or `kubectl set image`.

### 2.2 Configuration Update — What to verify

```sh
kubectl get configmap bonkey-config -n bonkey-app -o yaml
curl localhost:8080/hello  # after port-forward
```

| Criterion | Points |
|-----------|--------|
| ConfigMap updated with new message | 3 |
| Deployment restarted so pods pick up new env var | 4 |
| Live app returns updated greeting | 3 |

**Key knowledge signal:** ConfigMap changes do NOT automatically propagate to
env vars — pods must be restarted. A candidate who knows this without being
told demonstrates solid fundamentals. A candidate who edits the ConfigMap and
checks immediately without restarting, then wonders why it didn't update, shows
a gap.

---

## Section 3: Scaling and Resource Management (20 pts)

### 3.1 HPA — What to verify

```sh
kubectl get hpa -n bonkey-app
kubectl describe hpa bonkey -n bonkey-app
```

| Criterion | Points |
|-----------|--------|
| HPA targets the bonkey Deployment | 3 |
| minReplicas and maxReplicas are set and sensible | 3 |
| CPU target is set (any reasonable percentage 50–80%) | 2 |
| Candidate can justify their chosen values | 2 |

**Prerequisite check:** HPA requires resource requests to be set on the
container to calculate utilization. If the candidate did not set requests in
Section 1, HPA targets will show `<unknown>`. Use this as a teaching moment or
deduction if they cannot diagnose the cause.

### 3.2 ResourceQuota — What to verify

```sh
kubectl describe resourcequota bonkey-quota -n bonkey-app
```

| Criterion | Points |
|-----------|--------|
| Quota applied to `bonkey-app` namespace | 3 |
| Values are internally consistent (pod limit ≥ HPA maxReplicas, CPU quota ≥ maxReplicas × request) | 4 |
| Candidate can read and interpret the `Used` vs `Hard` output | 3 |

**Strong signal:** Candidate sets pod limit to match or exceed HPA maxReplicas
and calculates CPU quota as `maxReplicas × per-pod request`. This shows they
understand how quotas interact with scaling.

**Weak signal:** Arbitrary values with no rationale, or values that would
prevent the HPA from ever reaching maxReplicas.

---

## Section 4: Troubleshooting (20 pts)

### 4.1 Pod Debugging — What to verify

Watch the candidate work through this section without prompting.

| Criterion | Points |
|-----------|--------|
| Scales deployment without deleting pods directly | 2 |
| Retrieves logs from the correct pod | 3 |
| Uses `kubectl describe pod` to show events | 3 |
| Successfully execs into the container and navigates the filesystem | 4 |
| Identifies the correct application directory (`/app`) | 3 |

**Strong signal:** Candidate uses `-n bonkey-app` consistently without being
reminded. Uses `kubectl logs -f` or `--tail` for live log tailing. Uses
`kubectl exec -it -- /bin/sh` (not bash, since the base image may not have it).

**Weak signal:** Candidate gets confused about which pod to exec into when
multiple pods exist, or cannot find the application in the container filesystem.

### 4.2 Network Verification — What to verify

The candidate must demonstrate in-cluster connectivity. Accept any valid
approach — the most common is launching a temporary pod:

```sh
kubectl run test --image=curlimages/curl -it --rm --restart=Never \
  -n bonkey-app -- curl bonkey.bonkey-app.svc.cluster.local/hello
```

| Criterion | Points |
|-----------|--------|
| Uses in-cluster DNS name (not localhost or node IP) | 3 |
| Correctly identifies the full DNS pattern (`<svc>.<ns>.svc.cluster.local`) | 2 |
| Gets a valid response from `/hello` | 2 |

**Strong signal:** Candidate knows the Kubernetes DNS naming convention without
looking it up. Can explain why `bonkey.bonkey-app.svc.cluster.local` resolves
within the cluster.

---

## Section 5: Advanced Configuration (15 pts)

### 5.1 Ingress with TLS — What to verify

```sh
kubectl get ingress -n bonkey-app
kubectl get secret bonkey-tls -n bonkey-app
kubectl describe ingress bonkey -n bonkey-app
```

| Criterion | Points |
|-----------|--------|
| Self-signed cert generated correctly (openssl or equivalent) | 2 |
| TLS Secret created with correct name (`bonkey-tls`) and type (`kubernetes.io/tls`) | 3 |
| Ingress applies without errors | 2 |

**Note:** Full end-to-end TLS testing requires Minikube's ingress addon and
`/etc/hosts` entry for `bonkey.local`. Partial credit if the resources are
correctly configured but not reachable end-to-end.

### 5.2 PVC and Init Container — What to verify

```sh
kubectl get pvc -n bonkey-app
kubectl get pods -n bonkey-app
kubectl exec -n bonkey-app <pod> -- cat /data/init-timestamp.txt
```

| Criterion | Points |
|-----------|--------|
| PVC created with appropriate access mode (`ReadWriteOnce`) and size | 2 |
| Deployment updated with `volumes` and `volumeMounts` | 2 |
| Init container defined and writes timestamp to `/data/init-timestamp.txt` | 2 |
| File exists with a valid timestamp after pod restart | 2 |

**Strong signal:** Candidate knows that init containers run to completion before
the main container starts, and uses this to explain ordering guarantees.
Candidate chooses `ReadWriteOnce` and can explain why `ReadWriteMany` is
unnecessary for this workload.

---

## Interview Follow-up Questions

Use these after the exercise to probe depth of understanding:

1. **Probes:** "What is the difference between a liveness probe and a readiness
   probe? What happens to traffic if only the readiness probe fails?"

2. **Rolling update:** "If `maxUnavailable` were set to 1 instead of 0, what
   would change during a rolling update?"

3. **HPA:** "Why does the HPA need resource requests to be set? What does it
   show if they aren't?"

4. **ConfigMap:** "If you mounted the ConfigMap as a volume instead of env vars,
   would pods pick up changes automatically without a restart?"

5. **Namespace DNS:** "A pod in the `default` namespace wants to reach the
   bonkey service. What DNS name would it use?"

6. **PVC:** "What happens to the data in the PVC if the deployment is deleted?
   What if the namespace is deleted?"

7. **ResourceQuota + HPA interaction:** "If your ResourceQuota's pod limit is
   less than the HPA's maxReplicas, what happens when the HPA tries to scale up?"
