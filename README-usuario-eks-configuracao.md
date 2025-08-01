# Configuração do Usuário no EKS

## Resumo da Infrastrutura Criada

✅ **Cluster EKS**: EKS-AQUARELA-01 (Kubernetes 1.33) - ATIVO
✅ **Node Group**: nodeGroup-eks-03 (t3.medium, AL2023) - ATIVO  
✅ **VPC**: VPC principal com 4 subnets (2 públicas, 2 privadas)
✅ **Internet Gateway**: Conectividade para subnets públicas
✅ **Route Tables**: Roteamento configurado para acesso à internet
✅ **Addons EKS**: CoreDNS, kube-proxy, VPC CNI, EBS CSI - ATIVOS
✅ **Usuário IAM**: desafio_aquarela com chaves de acesso
✅ **Criptografia**: KMS para secrets do EKS

## Configuração do Usuário desafio_aquarela

Para dar permissões de admin ao usuário `desafio_aquarela`, execute os seguintes comandos:

### 1. Configure o kubectl para acessar o cluster:
```bash
aws eks update-kubeconfig --region us-east-2 --name EKS-AQUARELA-01
```

### 2. Edite o aws-auth configmap:
```bash
kubectl edit configmap aws-auth -n kube-system
```

### 3. Adicione o usuário na seção mapUsers:
```yaml
apiVersion: v1
data:
  mapUsers: |
    - userarn: arn:aws:iam::833565098889:user/desafio_aquarela
      username: desafio_aquarela
      groups:
        - system:masters
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
```

### 4. Verificar se o usuário tem acesso:
```bash
kubectl get nodes
kubectl get pods --all-namespaces
```

## Credenciais do Usuário

Para acessar o cluster como usuário `desafio_aquarela`, configure o AWS CLI com as credenciais:

```bash
# Use as chaves de acesso geradas pelo Terraform
aws configure set aws_access_key_id <ACCESS_KEY_ID>
aws configure set aws_secret_access_key <SECRET_ACCESS_KEY>
aws configure set region us-east-2
```

## Informações do Cluster

- **Nome**: EKS-AQUARELA-01
- **Versão**: Kubernetes 1.33
- **Região**: us-east-2
- **Endpoint**: https://02447885F659AD7207BE4C98C6C4BF02.gr7.us-east-2.eks.amazonaws.com
- **Node Group**: nodeGroup-eks-03 (1 nó t3.medium)
- **Subnets**: 2 públicas (com internet access) para nodes

## Status dos Recursos

Todos os recursos foram criados com sucesso:
- Cluster EKS: ATIVO
- Node Group: ATIVO  
- Addons: ATIVOS
- Networking: Configurado corretamente
- Usuário IAM: Criado com permissões

A infrastrutura está pronta para uso!
