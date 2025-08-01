resource "aws_eks_cluster" "eks-aquarela-01" {
  name     = "EKS-AQUARELA-01"
  role_arn = aws_iam_role.eks_cluster_iam_role.arn
  vpc_config {
    subnet_ids = [
      aws_subnet.subrede-publica1.id,
      aws_subnet.subrede-publica2.id,
      aws_subnet.subrede-privada1.id,
      aws_subnet.subrede-privada2.id
    ]
  }

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = aws_kms_key.eks_secrets_encryption.arn
    }
  }
  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy
  ]
}

resource "aws_eks_addon" "addons" {
  for_each             = var.eks_addons
  cluster_name         = aws_eks_cluster.eks-aquarela-01.name
  addon_name           = each.key
  addon_version        = each.value.addon_version
  configuration_values = jsonencode(each.value.configuration_values)
  depends_on           = [aws_iam_openid_connect_provider.openid-eks-aquarela]
}

resource "aws_eks_node_group" "aws_eks_node_group" {
  cluster_name    = aws_eks_cluster.eks-aquarela-01.name
  node_group_name = "nodeGroup-eks-03"
  node_role_arn   = aws_iam_role.eks_aquarela_node_group_role.arn
  subnet_ids      = [aws_subnet.subrede-publica1.id, aws_subnet.subrede-publica2.id]
  instance_types  = ["t3.medium"]
  ami_type        = "AL2023_x86_64_STANDARD"
  capacity_type   = "ON_DEMAND"

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-group-aquarela-roles
  ]
}

resource "aws_iam_openid_connect_provider" "openid-eks-aquarela" {
  url             = data.aws_eks_cluster.eks-aquarela-01.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da0afd10df6"]
}

# Configuração do aws-auth configmap será feita manualmente após a criação do cluster
