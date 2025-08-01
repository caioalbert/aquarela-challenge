################################################################################
# IAM User for EKS Admin Access
################################################################################
resource "aws_iam_user" "desafio_aquarela" {
  name = "desafio_aquarela"
  path = "/"

  tags = {
    Name = "Desafio Aquarela EKS Admin User"
  }
}

resource "aws_iam_access_key" "desafio_aquarela_access_key" {
  user = aws_iam_user.desafio_aquarela.name
}

resource "aws_iam_user_policy_attachment" "desafio_aquarela_eks_admin" {
  user       = aws_iam_user.desafio_aquarela.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
