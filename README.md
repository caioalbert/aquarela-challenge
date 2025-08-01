# EKS Cluster Terraform - Desafio Aquarela

Este projeto cria um cluster EKS na AWS com um usuário IAM que tem permissões de administrador no cluster.

## Recursos Criados

- **Cluster EKS**: EKS-AQUARELA-01 com Kubernetes 1.31 (última versão estável)
- **Node Group**: Managed node group com instâncias t3.medium
- **Usuário IAM**: desafio_aquarela com permissões de admin no cluster
- **Addons**: CoreDNS, kube-proxy, VPC CNI e EBS CSI Driver
- **Segurança**: Criptografia de secrets com KMS

## Pré-requisitos

1. AWS CLI configurado
2. Terraform instalado
3. kubectl instalado
4. Permissões adequadas na AWS

## Deploy

```bash
# Inicializar Terraform
terraform init

# Planejar as mudanças
terraform plan

# Aplicar a configuração
terraform apply
```

## Configurar kubectl

Após o deploy, configure o kubectl para acessar o cluster:

```bash
# Configure o kubectl (comando será mostrado nos outputs)
aws eks update-kubeconfig --region us-east-2 --name EKS-AQUARELA-01

# Teste o acesso
kubectl get nodes
kubectl get pods -A
```

## Teste com usuário desafio_aquarela

1. Crie as credenciais para o usuário (se necessário):
```bash
# Criar access key pelo console AWS ou CLI
aws iam create-access-key --user-name desafio_aquarela
```

2. Configure um perfil AWS com essas credenciais:
```bash
aws configure --profile desafio_aquarela
```

3. Teste o acesso:
```bash
# Configure kubectl com o perfil do usuário
AWS_PROFILE=desafio_aquarela aws eks update-kubeconfig --region us-east-2 --name EKS-AQUARELA-01

# Teste as permissões de admin
kubectl get nodes
kubectl get pods -A
kubectl auth can-i "*" "*"
```

## Solução de Problemas

### Se o terraform apply ficar lento:
- O cluster EKS demora entre 10-15 minutos para ser criado
- Os addons podem demorar mais 5-10 minutos
- Total esperado: 15-25 minutos

### Se houver erro de permissões:
- Verifique se as políticas IAM estão corretas
- Confirme que o usuário foi adicionado corretamente ao EKS Access Entry

### Para verificar o status:
```bash
# Status do cluster
aws eks describe-cluster --name EKS-AQUARELA-01

# Status dos node groups
aws eks describe-nodegroup --cluster-name EKS-AQUARELA-01 --nodegroup-name nodeGroup-eks-02

# Status dos addons
aws eks list-addons --cluster-name EKS-AQUARELA-01
```

## Limpeza

Para destruir todos os recursos:

```bash
terraform destroy
```

**Nota**: A destruição pode demorar 10-15 minutos.
