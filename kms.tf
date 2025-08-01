resource "aws_kms_key" "eks_secrets_encryption" {
  description = "KMS key for EKS secrets encryption"

}

resource "aws_kms_alias" "eks_secrets_encryption_alias" {
  name          = "alias/eks-secrets-encryption"
  target_key_id = aws_kms_key.eks_secrets_encryption.id
}

resource "aws_iam_policy" "kms_secrets_encryption" {
  name        = "kms-secrets-encryption-policy"
  description = "Allow EKS to use KMS for secrets encryption"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource = aws_kms_key.eks_secrets_encryption.arn
      }
    ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_kms_attachment" {
  role       = aws_iam_role.eks_cluster_iam_role.name
  policy_arn = aws_iam_policy.kms_secrets_encryption.arn
}
