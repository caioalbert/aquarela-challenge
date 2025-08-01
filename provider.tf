terraform {
  backend "s3" {
    bucket       = "terraform-desafio-aquarela"
    key          = "tfstate_prod/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.0"
    }
  }

}
provider "aws" {
  region = "us-east-2"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks-aquarela-01.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-aquarela-01.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks-aquarela-01.token
}

# resource "kubernetes_namespace" "teste" {
#   metadata {
#     annotations = {
#       name = "example-annotation"
#     }

#     labels = {
#       mylabel = "label-value"
#     }

#     name = "terraform-example-namespace"
#   }
# }
