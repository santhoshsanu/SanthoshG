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