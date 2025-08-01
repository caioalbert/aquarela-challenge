# Load Balancer for Sock Shop Application
resource "kubernetes_service" "sock_shop_loadbalancer" {
  metadata {
    name      = "front-end-lb"
    namespace = "sock-shop"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type"   = "nlb"
      "service.beta.kubernetes.io/aws-load-balancer-scheme" = "internet-facing"
    }
  }

  spec {
    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 8079
      protocol    = "TCP"
    }

    selector = {
      name = "front-end"
    }
  }

  depends_on = [
    aws_eks_node_group.aws_eks_node_group,
    kubernetes_namespace.sock_shop
  ]
}

# Namespace for Sock Shop
resource "kubernetes_namespace" "sock_shop" {
  metadata {
    name = "sock-shop"
  }

  depends_on = [aws_eks_node_group.aws_eks_node_group]
}
