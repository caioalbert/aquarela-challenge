################################################################################
# Outputs
################################################################################

output "cluster_name" {
  description = "Nome do cluster EKS"
  value       = aws_eks_cluster.eks-aquarela-01.name
}

output "cluster_endpoint" {
  description = "Endpoint do cluster EKS"
  value       = aws_eks_cluster.eks-aquarela-01.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Dados da autoridade certificadora do cluster"
  value       = aws_eks_cluster.eks-aquarela-01.certificate_authority[0].data
}

output "desafio_aquarela_user_name" {
  description = "Nome do usuário IAM criado"
  value       = aws_iam_user.desafio_aquarela.name
}

output "desafio_aquarela_user_arn" {
  description = "ARN do usuário IAM criado"
  value       = aws_iam_user.desafio_aquarela.arn
}

output "kubectl_config_command" {
  description = "Comando para configurar kubectl"
  value       = "aws eks update-kubeconfig --region us-east-2 --name ${aws_eks_cluster.eks-aquarela-01.name}"
}

output "sock_shop_url" {
  description = "URL da aplicação Sock Shop"
  value       = "http://${kubernetes_service.sock_shop_loadbalancer.status.0.load_balancer.0.ingress.0.hostname}"
}
