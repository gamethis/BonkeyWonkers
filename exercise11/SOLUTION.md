Here is a comprehensive summary of all the manifest fixes and triage commands we used to get the entire `bonkey` stack running perfectly.

---

## 📄 Summary of Manifest Updates

### 1. `bonkey-deployment.yaml`

We resolved the `ImagePullBackOff` issue, updated the failing health probe paths, injected the environment variable securely from the ConfigMap, and added resource limits.

```yaml
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: bonkey # Kept as "bonkey" to align with the Service selector
    spec:
      containers:
        - name: bonkey
          image: bonkey-k8s:v1.0
          imagePullPolicy: IfNotPresent # FIX: Prevents Minikube from checking Docker Hub
          ports:
            - containerPort: 5000
          livenessProbe:
            httpGet:
              path: /health # FIX: Changed from /healthz to match helloworld.py
              port: 5000
          readinessProbe:
            httpGet:
              path: /health # FIX: Changed from /healthz to match helloworld.py
              port: 5000
          env:
            - name: GREETING # FIX: Injected GREETING dynamically from ConfigMap
              valueFrom:
                configMapKeyRef:
                  name: bonkey-config
                  key: greeting
          resources: # FIX: Set resource allocations
            requests:
              memory: "128Mi"
              cpu: "100m"
            limits:
              memory: "256Mi"
              cpu: "500m"

```

### 2. `bonkey-service.yaml`

We updated the routing mechanism to ensure the Service could locate the Pods.

```yaml
spec:
  type: ClusterIP
  selector:
    app: bonkey # FIX: Changed from "bonkey-app" to "bonkey" to match Pod labels
  ports:
    - name: http
      port: 80
      targetPort: 5000

```

---

## 💻 Summary of CLI Commands Used

### 🛠️ Cluster Triage & Management

* **Target the custom namespace:**
```bash
kubectl get pods -n bonkey-app

```


* **Permanently switch context to save keystrokes:**
```bash
kubectl config set-context --current --namespace=bonkey-app

```


* **Verify endpoints are mapped to the Service:**
```bash
kubectl get endpoints bonkey -n bonkey-app

```



### 🔍 Log Analysis & Debugging

* **Stream application-specific runtime logs:**
```bash
kubectl logs -n bonkey-app -l app=bonkey --tail=20

```


* **Tunnel traffic directly to your host machine:**
```bash
kubectl port-forward svc/bonkey 8080:80 -n bonkey-app

```



### 🧪 In-Cluster Connectivity Validation (Bonus)

* **Open an interactive shell inside an application container:**
```bash
kubectl exec -it <pod-name> -n bonkey-app -- /bin/bash

```


* **Layer 7 (Application) Verification (From inside the pod shell):**
```bash
curl -i http://10.244.0.15:5000/hello

```


* **Layer 4 (Transport) Verification (From inside the pod shell):**
```bash
nc -zv 10.244.0.15 5000

```



---

### 🧹 Final Cleanup

To cleanly delete all the resources from Exercise 11 and prevent ongoing background resource allocation, execute this from your exercise folder:

```bash
kubectl delete -f .

```

You've officially mastered Level 1 Kubernetes troubleshooting! Would you like to proceed to **Module 3** and see how **Helm** packages these exact types of manifests?