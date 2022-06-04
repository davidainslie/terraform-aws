# Kubernetes

We will use [kind](https://kind.sigs.k8s.io) to assist with Kubernetes infrastructure - useful for local developement and testing.

Use [kind-config.yaml](kind-config.yaml) to bootstrap with:
```shell
kind create cluster --name terraform-kubernetes-demo --config kind-config.yaml
```

Sanity check our cluster is running:
```shell
kind get clusters                                                             
  terraform-kubernetes-demo
```

```shell
kubectl cluster-info --context kind-terraform-kubernetes-demo
  Kubernetes control plane is running at https://127.0.0.1:52916
  CoreDNS is running at https://127.0.0.1:52916/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```

We need to ask Kubernetes for the following to add to our Terraform configuration (we'll add to a `secrets.tfvars`):
- host
- client_certificate
- client_key
- cluster_ca_certificate

```shell
kubectl config view --minify --flatten --context=kind-terraform-kubernetes-demo
  apiVersion: v1
  clusters:
    - cluster:
        certificate-authority-data: ...
        server: https://127.0.0.1:52916
      name: kind-terraform-kubernetes-demo
  contexts:
    - context:
        cluster: kind-terraform-kubernetes-demo
        user: kind-terraform-kubernetes-demo
      name: kind-terraform-kubernetes-demo
  current-context: kind-terraform-kubernetes-demo
  kind: Config
  preferences: {}
  users:
    - name: kind-terraform-kubernetes-demo
      user:
        client-certificate-data: ...
        client-key-data: ...
```

```shell
terraform init

terraform apply -var-file="secrets.tfvars"

kubectl get deployments                                                        
  NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
  scalable-nginx-example   2/2     2            2           53s

kubectl get services   
  NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
  kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        109m
  nginx-example   NodePort    10.96.194.75   <none>        80:30201/TCP   21s

terraform destroy -var-file="secrets.tfvars"
```

Finally:
```shell
kind delete cluster --name terraform-kubernetes-demo
```