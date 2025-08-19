### Retrieve your cluster’s OIDC issuer ID and store it in a variable. 
```sh
cluster_name=<my-cluster>
oidc_id=$(aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
echo $oidc_id
```

###  Determine whether an IAM OIDC provider with your cluster’s issuer ID is already in your account.
```sh
aws iam list-open-id-connect-providers | grep $oidc_id | cut -d "/" -f4
```
### Note: If output is returned, then you already have an IAM OIDC provider for your cluster and you can skip the next step. If no output is returned, then you must create 
###       an IAM OIDC provider for your cluster.

------------

### Create an IAM OIDC identity provider for your cluster with the following command.

```sh
eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve
```

### Connect kubectl to an EKS cluster by creating a kubeconfig file
```sh
aws eks update-kubeconfig --region us-west-2 --name basic-cluster
```

cred

[default]
aws_access_key_id=AKI
aws_secret_access_key=uVsPS

---------------------------
### steps

BUCKET=<YOUR_BUCKET>
REGION=<YOUR_REGION>
aws s3api create-bucket \
    --bucket $BUCKET \
    --region $REGION \
    --create-bucket-configuration LocationConstraint=$REGION





aws iam put-user-policy \
  --user-name test \
  --policy-name velero \
  --policy-document file://velero-policy.json

