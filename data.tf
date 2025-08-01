data "aws_eks_cluster" "eks-aquarela-01" {
  name = aws_eks_cluster.eks-aquarela-01.name
}

data "aws_eks_cluster_auth" "eks-aquarela-01" {
  name = aws_eks_cluster.eks-aquarela-01.name
}
