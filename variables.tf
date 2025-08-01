variable "policy_arn" {
  type = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]
}

variable "eks_addons" {
  type = any
  default = {
    coredns = {
      addon_version        = "v1.11.4-eksbuild.2"
      configuration_values = {}
    }

    kube-proxy = {
      addon_version        = "v1.33.0-eksbuild.2"
      configuration_values = {}
    }

    vpc-cni = {
      addon_version        = "v1.19.3-eksbuild.1"
      configuration_values = {}
    }

    aws-ebs-csi-driver = {
      addon_version        = "v1.41.0-eksbuild.1"
      configuration_values = {}
    }
  }
}
variable "role_Node" {
  type = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

variable "labels_node" {
  type = map(string)
  default = {
    environment = "production"
    managed-by  = "terraform"
  }
}

variable "taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default = []
}
