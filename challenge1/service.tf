resource "kubernetes_service" "app" {
  depends_on = [
    google_container_cluster.primary
  ]
  metadata {
    name = var.web-app
  }
  spec {
    selector = {
      app = kubernetes_deployment.app.metadata.0.labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
} 