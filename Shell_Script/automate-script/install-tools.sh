#!/bin/bash

set -e

# Install eksctl
echo "==> Installing eksctl..."
ARCH=amd64
PLATFORM="$(uname -s)_$ARCH"
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_${PLATFORM}.tar.gz"
tar -xzf "eksctl_${PLATFORM}.tar.gz" -C /tmp && rm "eksctl_${PLATFORM}.tar.gz"
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# Install kubectl
echo "==> Installing kubectl..."
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256)  kubectl" | sha256sum -c
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
rm kubectl.sha256
kubectl version --client 

# Install Helm
echo "==> Installing Helm..."
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm get_helm.sh
helm version --short

# Create EKS cluster
CLUSTER_YAML="cluster.yaml"
if [ ! -f "$CLUSTER_YAML" ]; then
  echo "❌ Error: $CLUSTER_YAML not found!"
  exit 1
fi

CLUSTER_NAME=$(yq e '.metadata.name' "$CLUSTER_YAML")
REGION=$(yq e '.metadata.region' "$CLUSTER_YAML")

echo "==> Creating EKS cluster using eksctl..."
eksctl create cluster -f "$CLUSTER_YAML"

echo "==> Updating kubeconfig to connect kubectl to your EKS cluster..."
aws eks update-kubeconfig --region "$REGION" --name "$CLUSTER_NAME"

echo "✅ EKS cluster '$CLUSTER_NAME' is ready and kubectl is configured."
