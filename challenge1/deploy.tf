terraform {
  required_version = "~>1.0"
}

provider "kubernetes" {
}

resource "kubernetes_deployment" "app" {
  depends_on = [
    google_container_cluster.primary
  ]
  metadata {
    name = var.web-app
    labels = {
      app = var.web-app
    }
  }
  spec {
    replicas = 3

    selector {
      match_labels = {
        app = var.web-app
      }
    }
    template {
      metadata {
        labels = {
          app = var.web-app
        }
      }
      spec {
        container {
          image = var.docker-image
          name  = var.web-app
          port {
            name           = "port-80"
            container_port = 80
          }    
          env {
              name = "ATC_USERNAME"
              value = var.ATC_USERNAME
            }
          env {
              name  = "ATC_PASSWORD"
              value = var.ATC_PASSWORD
            }
        }
      }
    }
  }
}
