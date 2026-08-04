## k8s: 
* "Kubernetes architecture consists of a Control Plane and Worker Nodes. The Control Plane manages the cluster using components like the API Server, etcd, Scheduler, and Controller Manager. Worker Nodes run applications using kubelet, the container runtime, and kube-proxy. When a user creates a Deployment, the request goes to the API Server, the desired state is stored in etcd, the Scheduler selects a Worker Node, kubelet creates the Pod using the container runtime, and the Controller Manager ensures the application remains in the desired state."


# Configmap
"First, I create the ConfigMap using kubectl. Then, I reference it in the Pod using either `env` with `configMapKeyRef` for individual keys or `envFrom` to import all keys as environment variables. The application can then access them like normal environment variables."