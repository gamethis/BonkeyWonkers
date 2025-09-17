# Exercise 11

Back to [Main](../README.md)

This exercise will test your basic knowledge of Kubernetes including
deploying, updating, and modifying applications running on Kubernetes clusters.

## Prerequisites

Ensure you have access to a Kubernetes cluster (minikube, kind, or cloud
provider). The exercise assumes `kubectl` is configured and working.

## Step 1: Prepare Application Image

### Task 1.1: Create Docker Image

Before deploying to Kubernetes, you need to create a proper Docker image:

1. **Review the provided files:**
   - `helloworld.py` - Flask application with `/hello` endpoint
   - `Dockerfile` - Based on Exercise 2 pattern using `dahicks/sample:latest`

2. **Build the Docker image:**
   - Build an image named `bonkey-k8s:latest`
   - Test the image locally to ensure it works
   - Load the image into your Kubernetes environment (minikube/kind)

3. **Verify the application:**
   - The app should respond to GET requests on `/hello`
   - Should use environment variables from ConfigMap
   - Should run on port 5000

**Expected Output:**

```bash
[+] Building 5.6s (9/9) FINISHED
 => [internal] load build definition from Dockerfile
 => [1/4] FROM docker.io/dahicks/sample:latest
 => [2/4] RUN useradd --no-log-init -m -r -g root bonkey
 => [3/4] COPY helloworld.py /app/main.py
 => [4/4] RUN cd /app && pip install Flask-RESTful Flask
 => exporting to image
 => => naming to docker.io/library/bonkey-k8s:latest

{"app":"bonkey-app","data":"Hello World","version":"v1"}
```

## Step 2: Deploy Bonkey Application

### Task 2.1: Create Kubernetes Manifests

Create the following Kubernetes manifests in this directory:

1. **`bonkey-namespace.yaml`** - Create a namespace called `bonkey-app`
2. **`bonkey-deployment.yaml`** - Deploy the hello world application using
   `bonkey-k8s:latest`
   - Use 3 replicas
   - Set resource limits: CPU 100m, Memory 128Mi
   - Set resource requests: CPU 50m, Memory 64Mi
   - Add labels: `app=bonkey`, `version=v1`
3. **`bonkey-service.yaml`** - Expose the deployment via ClusterIP service
   on port 80
4. **`bonkey-configmap.yaml`** - Create a ConfigMap with greeting message:
   `message: "Hello from BonkeyWonkers!"`

### Task 2.2: Deploy to Kubernetes

Deploy all manifests to your cluster in the correct order.

Verify the deployment:

- Check all pods are running
- Check service endpoints

**Expected Output:**

```bash
namespace/bonkey-app created
configmap/bonkey-config created
deployment.apps/bonkey created
service/bonkey created

NAME                      READY   STATUS    RESTARTS   AGE
bonkey-7c8b9d5f4c-abc12   1/1     Running   0          30s
bonkey-7c8b9d5f4c-def34   1/1     Running   0          30s
bonkey-7c8b9d5f4c-ghi56   1/1     Running   0          30s

NAME     ENDPOINTS                               AGE
bonkey   10.244.0.10:5000,10.244.0.11:5000,...  30s
```

## Step 3: Application Updates

### Task 3.1: Rolling Update

Update the deployment to use a new image version:

- Change the image tag from `latest` to `v1.1` (simulated update)
- Update the version label to `v2`
- Increase replicas to 5

Apply the changes and monitor the rolling update using appropriate kubectl commands.

**Expected Output:**

```bash
deployment.apps/bonkey configured

deployment "bonkey" successfully rolled out

REVISION  CHANGE-CAUSE
1         <none>
2         <none>

NAME                      READY   STATUS    RESTARTS   AGE
bonkey-9f7d8c6e2a-xyz89   1/1     Running   0          45s
bonkey-9f7d8c6e2a-abc12   1/1     Running   0          45s
bonkey-9f7d8c6e2a-def34   1/1     Running   0          30s
bonkey-9f7d8c6e2a-ghi56   1/1     Running   0          30s
bonkey-9f7d8c6e2a-jkl78   1/1     Running   0          15s
```

### Task 3.2: Configuration Update

Modify the ConfigMap to change the greeting message to
`"Hello from Updated BonkeyWonkers!"` and restart the deployment to pick up
the new configuration.

**Expected Output:**

```bash
configmap/bonkey-config configured

deployment.apps/bonkey restarted

NAME                      READY   STATUS        RESTARTS   AGE
bonkey-9f7d8c6e2a-abc12   1/1     Terminating   0          5m
bonkey-6d4b5a8f9c-new01   1/1     Running       0          30s
bonkey-6d4b5a8f9c-new02   1/1     Running       0          30s
bonkey-6d4b5a8f9c-new03   1/1     Running       0          15s
bonkey-6d4b5a8f9c-new04   1/1     Running       0          15s
bonkey-6d4b5a8f9c-new05   1/1     Running       0          10s
```

## Step 4: Application Scaling and Management

### Task 4.1: Horizontal Pod Autoscaler (HPA)

Create an HPA that:

- Targets the bonkey deployment
- Scales between 2-10 replicas
- Based on CPU utilization (target: 70%)

Create `bonkey-hpa.yaml` and apply it.

**Expected Output:**

```bash
horizontalpodautoscaler.autoscaling/bonkey created

NAME     REFERENCE           TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
bonkey   Deployment/bonkey   <unknown>/70%   2         10        5          30s
```

### Task 4.2: Resource Management

Create a ResourceQuota for the `bonkey-app` namespace:

- Limit total CPU requests to 500m
- Limit total memory requests to 1Gi
- Limit total pods to 10

Create `bonkey-resourcequota.yaml` and apply it.

**Expected Output:**

```bash
resourcequota/bonkey-quota created

NAME           AGE   REQUEST                                            LIMIT
bonkey-quota   30s   requests.cpu: 250m/500m, requests.memory: 320Mi/1Gi, pods: 5/10
```

## Step 5: Monitoring and Troubleshooting

### Task 5.1: Pod Debugging

Simulate an application issue:

1. Scale down one pod manually
2. Use appropriate commands to examine pod logs
3. Use describe commands to check pod events
4. Access a running pod and check the filesystem

**Expected Output:**

```bash
deployment.apps/bonkey scaled

bonkey-6d4b5a8f9c-new01   1/1     Running   0          10m
{"timestamp":"2025-09-17T10:30:00Z","level":"info","message":"Server started"}
{"timestamp":"2025-09-17T10:31:15Z","level":"info","message":"Health check"}

Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  10m   default-scheduler  Successfully assigned bonkey-app/bonkey...
  Normal  Pulled     10m   kubelet            Container image "dahicks/sample:v1.1"
  Normal  Created    10m   kubelet            Created container bonkey-container
  Normal  Started    10m   kubelet            Started container bonkey-container

/app # ls -la
total 16
drwxr-xr-x    1 bonkey   root          4096 Sep 17 10:30 .
drwxr-xr-x    1 root     root          4096 Sep 17 10:30 ..
-rw-r--r--    1 bonkey   root           512 Sep 17 10:30 main.py
```

### Task 5.2: Network Testing

Test service connectivity:

1. Create a temporary pod for testing with curl
2. From inside the test pod, curl the bonkey service
3. Test DNS resolution for the service

**Expected Output:**

```bash
pod/test-pod created

If you don't see a command prompt, try pressing enter.
/ $ curl bonkey.bonkey-app.svc.cluster.local
{
  "data": "Hello from Updated BonkeyWonkers!"
}

/ $ nslookup bonkey.bonkey-app.svc.cluster.local
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      bonkey.bonkey-app.svc.cluster.local
Address 1: 10.96.100.200 bonkey.bonkey-app.svc.cluster.local

pod "test-pod" deleted
```

## Step 6: Advanced Configurations

### Task 6.1: Ingress Controller

Create `bonkey-ingress.yaml` to expose the application externally:

- Use host: `bonkey.local`
- Path: `/`
- Enable TLS with a self-signed certificate (create as Secret)

**Expected Output:**

```bash
secret/bonkey-tls created
ingress.networking.k8s.io/bonkey created

NAME     CLASS    HOSTS          ADDRESS        PORTS     AGE
bonkey   <none>   bonkey.local   192.168.1.100  80, 443   30s
```

### Task 6.2: Persistent Storage

Add persistent storage to the deployment:

1. Create `bonkey-pvc.yaml` - PersistentVolumeClaim for 1Gi storage
2. Update the deployment to mount the volume at `/data`
3. Add an init container that creates a file in `/data` with timestamp

**Expected Output:**

```bash
persistentvolumeclaim/bonkey-storage created
deployment.apps/bonkey configured

NAME                      READY   STATUS     RESTARTS   AGE
bonkey-init-abc123        0/1     Init:0/1   0          10s
bonkey-7f8e9d6c5b-new01   1/1     Running    0          45s

/ $ ls -la /data/
total 12
drwxrwxrwx    2 root     root          4096 Sep 17 10:45 .
drwxr-xr-x    1 root     root          4096 Sep 17 10:45 ..
-rw-r--r--    1 root     root            29 Sep 17 10:45 init-timestamp.txt

/ $ cat /data/init-timestamp.txt
2025-09-17T10:45:30Z
```

## Validation Steps

### Verification Commands

Use appropriate kubectl commands to verify your setup and check:

- All resources in the namespace
- Resource usage of pods
- HPA status
- Application endpoint accessibility
- Resource quota usage

**Expected Verification Output:**

```bash
NAME                      READY   STATUS    RESTARTS   AGE
pod/bonkey-7f8e9d6c5b-a1b2c   1/1     Running   0          5m
pod/bonkey-7f8e9d6c5b-d3e4f   1/1     Running   0          5m
pod/bonkey-7f8e9d6c5b-g5h6i   1/1     Running   0          5m
pod/bonkey-7f8e9d6c5b-j7k8l   1/1     Running   0          5m
pod/bonkey-7f8e9d6c5b-m9n0o   1/1     Running   0          5m

NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/bonkey  ClusterIP   10.96.100.200   <none>        80/TCP    15m

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/bonkey   5/5     5            5           15m

NAME     REFERENCE           TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
bonkey   Deployment/bonkey   45%/70%   2         10        5          10m

NAME           AGE   REQUEST                                            LIMIT
bonkey-quota   10m   requests.cpu: 250m/500m, requests.memory: 320Mi/1Gi, pods: 5/10

Forwarding from 127.0.0.1:8080 -> 5000
Forwarding from [::1]:8080 -> 5000
{
  "data": "Hello from Updated BonkeyWonkers!"
}
```

## Expected Output

After completing all tasks, you should have:

- A running application with 5 replicas (or auto-scaled based on load)
- A working service exposing the application
- An HPA managing scaling based on CPU
- A ResourceQuota limiting resource consumption
- Persistent storage mounted and accessible
- External access via Ingress (if applicable to your cluster)

## Cleanup

When finished, clean up all resources by deleting the namespace.

**Expected Cleanup Output:**

```bash
namespace "bonkey-app" deleted
```

## Exercise 11 Complete

Proceed to [Main](../README.md)
