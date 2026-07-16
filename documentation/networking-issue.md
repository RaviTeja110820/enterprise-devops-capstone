# Kubernetes Networking Issue Resolution

## Project

AWS Enterprise DevOps Capstone

---

# Issue Description

A networking issue was intentionally introduced by modifying the Kubernetes Service selector.

The Service selector no longer matched the labels assigned to the application Pods.

As a result, Kubernetes could not associate any Pods with the Service.

---

# Symptoms

- Application became inaccessible.
- Service had no backend endpoints.
- Port forwarding to the Service failed.

Observed output:

```text
kubectl get endpoints -n enterprise

NAME                 ENDPOINTS
enterprise-service   <none>
```

---

# Root Cause

The Service selector was incorrectly configured.

Incorrect configuration:

```yaml
selector:
  app: wrong-app
```

Application Pods were running with the following label:

```yaml
app: enterprise-app
```

Since the selector did not match the Pod labels, the Service could not discover any endpoints.

---

# Investigation Commands

The following commands were used to diagnose the issue.

Check Pods

```bash
kubectl get pods -n enterprise --show-labels
```

Check Services

```bash
kubectl get svc -n enterprise
```

Check Endpoints

```bash
kubectl get endpoints -n enterprise
```

Describe Service

```bash
kubectl describe svc enterprise-service -n enterprise
```

---

# Resolution Steps

### Step 1

Open the Kubernetes Service manifest.

```
kubernetes/service.yaml
```

---

### Step 2

Correct the Service selector.

Incorrect

```yaml
selector:
  app: wrong-app
```

Correct

```yaml
selector:
  app: enterprise-app
```

---

### Step 3

Apply the updated Service configuration.

```bash
kubectl apply -f kubernetes/service.yaml
```

---

### Step 4

Verify that Kubernetes created Service endpoints.

```bash
kubectl get endpoints -n enterprise
```

Expected output

```text
enterprise-service   10.x.x.x:3000
```

---

### Step 5

Verify application connectivity.

```bash
kubectl port-forward svc/enterprise-service 3000:80 -n enterprise
```

Open

```
http://localhost:3000
```

Expected response

```
Hello from Enterprise DevOps Capstone
```

---

# Validation

After correcting the Service selector:

- Endpoints were successfully created.
- Pods were associated with the Service.
- Port forwarding worked successfully.
- Application became accessible again.

---

# Lessons Learned

- Always verify Pod labels and Service selectors.
- Use `kubectl get endpoints` as one of the first troubleshooting commands.
- Validate Service configuration after every deployment.
- Perform Kubernetes networking verification before promoting changes to production.

---

# Conclusion

The networking issue was successfully identified and resolved by correcting the Kubernetes Service selector.

After applying the updated Service configuration, Kubernetes successfully mapped the application Pods to the Service, restoring normal network connectivity.