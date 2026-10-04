## Health Probes
One-line Summary
Startup Probe → Checks if the application has started successfully.
Readiness Probe → Checks if the application is ready to receive traffic.
Liveness Probe → Checks if the application is still healthy; if not, Kubernetes restarts the container.
Real-world example

A Spring Boot application takes 60 seconds to start:

Startup Probe: Waits until the application finishes starting.
Readiness Probe: After startup, allows traffic only when the app is ready (for example, after connecting to the database).
Liveness Probe: Continues checking the application while it's running. If it hangs or becomes unresponsive, Kubernetes restarts the container.



# Kubernetes Health Probes: Quick Reference

Reference for the liveness probe, readiness probe, and graceful shutdown settings in the `backend` Deployment (`product-catalog` namespace).

## How it works in this config

|                     | Liveness                 | Readiness                       |
|---------------------|--------------------------|---------------------------------|
| First check after   | 60s                      | 45s                             |
| Checks every        | 15s                      | 10s                             |
| Fails after         | 3 in a row (about 45s)   | 3 in a row (about 30s)          |
| Action              | Restart container        | Remove from Service endpoints   |

## Config being explained

```yaml
# ── Liveness Probe — restart pod if app is hung ──────────────────
livenessProbe:
  httpGet:
    path: /api/products/health
    port: 8080
  initialDelaySeconds: 60   # give Spring Boot time to start
  periodSeconds: 15
  failureThreshold: 3
# ── Readiness Probe — only send traffic when app is ready ────────
readinessProbe:
  httpGet:
    path: /api/products/health
    port: 8080
  initialDelaySeconds: 45
  periodSeconds: 10
  failureThreshold: 3
# Graceful shutdown — wait for in-flight requests to finish
terminationGracePeriodSeconds: 30
```

## Field definitions

### `livenessProbe`
Checks whether the app is still alive and not stuck (hung or deadlocked).
If it keeps failing, Kubernetes restarts the container.

### `readinessProbe`
Checks whether the app is ready to accept user traffic.
If it fails, the pod keeps running but is removed from the Service, so it receives no requests. It is added back automatically once the check passes again.

### `httpGet`
Tells Kubernetes to run the check as an HTTP GET request, similar to `curl`. The kubelet on the node sends the request.
A response with status 200 to 399 counts as success; anything else (such as 500 or 503) counts as a failure.

### `path: /api/products/health`
The URL path the probe calls on your app.
This should be a lightweight endpoint that only returns success when the app is healthy.

### `port: 8080`
The container port the probe sends the request to.
It matches the port your Spring Boot app listens on.

### `initialDelaySeconds`
How long Kubernetes waits after the container starts before the first check.
Spring Boot starts slowly, so this prevents false failures during startup (liveness: 60s, readiness: 45s).

### `periodSeconds`
How often the check runs after the first one.
Liveness checks every 15s and readiness every 10s.

### `failureThreshold`
How many failed checks in a row are needed before Kubernetes takes action.
With 3 failures, the time to act is about 3 x periodSeconds (liveness: about 45s, readiness: about 30s).

### `terminationGracePeriodSeconds: 30`
How long a pod gets to shut down cleanly after Kubernetes tells it to stop.
In-flight requests can finish within these 30 seconds; after that, the pod is force-killed.

## Defaults not set in this config

### `timeoutSeconds` (default: 1)
How long Kubernetes waits for a response before counting the check as failed.
If Spring Boot is slow to answer, consider raising this value.

### `successThreshold` (default: 1)
How many passing checks in a row are needed to mark the probe as healthy again.
For readiness, one success is enough to put the pod back into the Service.

## Quick summary

- **Liveness** answers "Is the app stuck?" and the fix is a **restart**.
- **Readiness** answers "Can the app handle traffic right now?" and the fix is to **stop sending traffic** until it recovers.
- With `maxUnavailable: 0`, readiness also makes rolling updates safe: the old pod stays up until the new pod is ready.
