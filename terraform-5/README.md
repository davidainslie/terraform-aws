# EKS

```shell
terraform init
```

```shell
terraform apply -var-file="secrets.tfvars"

Outputs:

cluster_endpoint = "https://2221C2913A666CB67C5EA4A7CCD04112.gr7.us-east-1.eks.amazonaws.com"
cluster_id = "education-eks-O4zTbJmj"
cluster_name = "education-eks-O4zTbJmj"
cluster_security_group_id = "sg-0980715ebc579abf4"
config_map_aws_auth = [
  {
    ...
  },
]
kubectl_config = <<EOT
apiVersion: v1
preferences: {}
kind: Config

clusters:
- cluster:
    server: https://2221C2913A666CB67C5EA4A7CCD04112.gr7.us-east-1.eks.amazonaws.com
    certificate-authority-data: ...
  name: eks_education-eks-O4zTbJmj

contexts:
- context:
    cluster: eks_education-eks-O4zTbJmj
    user: eks_education-eks-O4zTbJmj
  name: eks_education-eks-O4zTbJmj

current-context: eks_education-eks-O4zTbJmj

users:
- name: eks_education-eks-O4zTbJmj
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "education-eks-O4zTbJmj"

EOT
region = "us-east-1"
```

```shell
# Configure kubectl
export AWS_ACCESS_KEY_ID=...                                                                                                                                    
export AWS_SECRET_ACCESS_KEY=...

aws sts get-caller-identity 
{
    "UserId": "...",
    "Account": "...",
    "Arn": "..."
}

aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name) --role-arn ...

# OR
aws eks --profile acloudguru --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```

```shell
wget -O v0.3.6.tar.gz https://codeload.github.com/kubernetes-sigs/metrics-server/tar.gz/v0.3.6 && tar -xzf v0.3.6.tar.gz
# Which will result in the necessary files under directory metrics-server-0.3.6 (not checked into github)

kubectl apply -f metrics-server-0.3.6/deploy/1.8+

kubectl get deployment metrics-server -n kube-system
```

```shell
kubectl apply -f kubernetes-dashboard-admin-rbac.yaml
```

```shell

terraform destroy -var-file="secrets.tfvars"
```