# Configuração do usuário desafio_aquarela no EKS

## Recursos criados:

1. **Usuário IAM**: `desafio_aquarela`
   - Policy personalizada com permissões administrativas para EKS
   - Access Key e Secret Key para autenticação

2. **EKS Access Entry**: Configurado para dar acesso de admin ao cluster
   - Associado ao grupo `system:masters` 
   - Policy `AmazonEKSClusterAdminPolicy` anexada

## Como usar após o terraform apply:

### 1. Obter as credenciais do usuário:

```bash
# Obter Access Key ID
terraform output desafio_aquarela_access_key_id

# Obter Secret Access Key
terraform output desafio_aquarela_secret_access_key

# Obter nome do cluster
terraform output cluster_name
```

### 2. Configurar AWS CLI com as credenciais:

```bash
# Configurar perfil AWS para o usuário
aws configure --profile desafio_aquarela
# Inserir os valores obtidos no passo anterior

# Ou configurar variáveis de ambiente
export AWS_ACCESS_KEY_ID="<access_key_id>"
export AWS_SECRET_ACCESS_KEY="<secret_access_key>"
export AWS_DEFAULT_REGION="us-east-1"  # ou sua região
```

### 3. Configurar kubectl:

```bash
# Atualizar kubeconfig para o cluster
aws eks update-kubeconfig --region us-east-1 --name <cluster_name> --profile desafio_aquarela

# Ou sem profile (se usando variáveis de ambiente)
aws eks update-kubeconfig --region us-east-1 --name <cluster_name>
```

### 4. Verificar acesso:

```bash
# Testar conexão com o cluster
kubectl get nodes

# Verificar permissões
kubectl auth can-i "*" "*"
```

## Permissões concedidas:

O usuário `desafio_aquarela` tem:
- Acesso completo ao cluster EKS via `system:masters`
- Permissões administrativas para recursos EKS
- Acesso para listar e descrever recursos EC2 relacionados
- Permissões para operações IAM necessárias para EKS

## Segurança:

- As credenciais são marcadas como sensíveis no Terraform
- Recomenda-se usar AWS IAM roles quando possível em ambientes de produção
- As credenciais devem ser rotacionadas periodicamente
