data "aws_iam_policy_document" "role_eks_cluster" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }

}
############Role-cluster################
resource "aws_iam_role" "eks_cluster_iam_role" {
  name               = "eks-cluster-iam-role"
  assume_role_policy = data.aws_iam_policy_document.role_eks_cluster.json
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {
  for_each   = toset(var.policy_arn)
  policy_arn = each.value
  role       = aws_iam_role.eks_cluster_iam_role.name
}

############Role-Node#################
resource "aws_iam_role" "eks_aquarela_node_group_role" {
  name = "eks-node-group-aquarela"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "node-group-aquarela-roles" {
  for_each   = toset(var.role_Node)
  policy_arn = each.value
  role       = aws_iam_role.eks_aquarela_node_group_role.name
}
