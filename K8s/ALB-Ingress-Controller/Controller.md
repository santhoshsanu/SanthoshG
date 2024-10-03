Install AWS Load Balancer Controller with Helm

Prerequisites
---------------
* Amazon EKS cluster
* An existing AWS Identity and Access Management (IAM) OpenID Connect (OIDC) provider for cluster.
* Helm installed locally.
* Eksctl, Kubectl, AWS CLI.


STEP-1:Create IAM Role using eksctl
------------------------------------
`1.Create an IAM policy.`
```
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.2/docs/install/iam_policy.json
```

`2.Create an IAM policy using the policy downloaded in the previous step`
```
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json
```

`3.Create IAM Role using eksctl`
```
eksctl create iamserviceaccount \
  --cluster=my-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::111122223333:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
```

STEP-2: Install AWS Load Balancer Controller
-----------------------------------------------

`1.Add the eks-charts Helm chart repository.`

```
helm repo add eks https://aws.github.io/eks-charts
```

`2.Update your local repo`

```
helm repo update eks
```

`3.Install the AWS Load Balancer Controller.`
```
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=my-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller 
```

`To list all the Helm chart repositories`
```
helm repo list
```

STEP-3: Verify that the controller is installed
-------------------------------------------------

`1.Verify that the controller is installed`

```
kubectl get deployment -n kube-system aws-load-balancer-controller
```


STEP-4: Apply the Deployment, Service, and Ingress for a ALB Controller setup:
--------------------------------------------------------------------------------

