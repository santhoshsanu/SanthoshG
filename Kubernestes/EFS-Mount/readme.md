### Step 1: Enable IAM OIDC Provider (if not already)

```sh
eksctl utils associate-iam-oidc-provider \
  --region <your-region> \
  --cluster <your-cluster-name> \
  --approve
```

### Step 2: Create IAM Policy for EFS CSI Driver

```sh
curl -o efs-csi-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-efs-csi-driver/master/docs/iam-policy-example.json
```

#### Create the policy:

```sh
aws iam create-policy \
  --policy-name AmazonEKS_EFS_CSI_Driver_Policy \
  --policy-document file://efs-csi-policy.json
```

### Step 3: Create IAM Role and Service Account

```sh
eksctl create iamserviceaccount \
  --name efs-csi-controller-sa \
  --namespace kube-system \
  --cluster <your-cluster-name> \
  --attach-policy-arn arn:aws:iam::<your-account-id>:policy/AmazonEKS_EFS_CSI_Driver_Policy \
  --approve \
  --region <your-region>
```

### Step 4: Add Helm Repo & Install the Driver

```sh
helm repo add aws-efs-csi-driver https://kubernetes-sigs.github.io/aws-efs-csi-driver/
helm repo update

helm upgrade --install aws-efs-csi-driver \
  aws-efs-csi-driver/aws-efs-csi-driver \
  --namespace kube-system \
  --set controller.serviceAccount.create=false \
  --set controller.serviceAccount.name=efs-csi-controller-sa
```

### Step 5: Create a StorageClass (optional)

```sh
# efs-sc.yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: efs-sc
provisioner: efs.csi.aws.com
```

### Step 6: Create PersistentVolume (PV) and PersistentVolumeClaim (PVC)

```sh
# efs-pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: efs-pv
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  storageClassName: efs-sc
  csi:
    driver: efs.csi.aws.com
    volumeHandle: <your-efs-id>
```


---

```sh
# efs-pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: efs-pvc
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: efs-sc
  resources:
    requests:
      storage: 5Gi
```



```sh
aws eks create-addon --cluster-name managed-cluster --addon-name aws-efs-csi-driver \
  --service-account-role-arn $EFS_CSI_ADDON_ROLE
aws eks wait addon-active --cluster-name managed-cluster --addon-name aws-efs-csi-driver
```



# efs-pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: efs-pv
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  storageClassName: efs-sc
  csi:
    driver: efs.csi.aws.com
    volumeHandle: fs-0ef8c38a2223c0e78  # <- Just the EFS FileSystem ID (NO access point)




---

apiVersion: v1
kind: Pod
metadata:
  name: efs-demo-pod
spec:
  containers:
  - name: efs-demo-container
    image: nginx  # Replace with your application container image
    volumeMounts:
    - mountPath: /mnt/efs  # The path inside the container where the volume will be mounted
      name: efs-storage
  volumes:
  - name: efs-storage
    persistentVolumeClaim:
      claimName: efs-pvc