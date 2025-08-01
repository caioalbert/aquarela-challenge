# 🔍 Comandos de Verificação de Status

## Configurar kubectl (PRIMEIRO COMANDO):
```bash
aws eks update-kubeconfig --region us-east-2 --name EKS-AQUARELA-01
```

## Verificar Cluster:
```bash
kubectl get nodes -o wide
kubectl cluster-info
```

## Verificar Aplicação Sock Shop:
```bash
kubectl get pods -n sock-shop
kubectl get svc -n sock-shop
kubectl get svc front-end-lb -n sock-shop
```

## Verificar Load Balancer:
```bash
kubectl describe svc front-end-lb -n sock-shop
curl -I http://a33baecb8749d497f9fc2d48ab54af4d-de539ed0121f0801.elb.us-east-2.amazonaws.com
```

## Verificar Terraform:
```bash
cd /mnt/c/Users/caio.ferreira/Downloads/main_tf2
terraform state list
terraform output
```

## Verificar AWS Resources:
```bash
aws eks describe-cluster --name EKS-AQUARELA-01 --region us-east-2
aws eks describe-nodegroup --cluster-name EKS-AQUARELA-01 --nodegroup-name nodeGroup-eks-03 --region us-east-2
```

## Logs de Debug (se necessário):
```bash
kubectl logs deployment/front-end -n sock-shop
kubectl describe pod <pod-name> -n sock-shop
```
