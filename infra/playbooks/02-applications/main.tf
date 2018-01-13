provider "google" {
  credentials = "${file("../../credentials/terraform.json")}"
  project     = "xebia-veille"
  region      = "europe-west1"
}

provider "kubernetes" {
  host                   = "${var.cluster_host}"
  username               = "${var.cluster_username}"
  password               = "${var.cluster_password}"
  client_key             = "${base64decode(var.cluster_client_key)}"
  client_certificate     = "${base64decode(var.cluster_client_certificate)}"
  cluster_ca_certificate = "${base64decode(var.cluster_ca_certificate)}"
}

resource "kubernetes_service" "redis" {
  metadata {
    name = "${var.branch}-redis"
  }
  spec {
    selector {
      k8s-app = "${var.branch}"
    }
    port {
      port = 6379
    }
    type = "NodePort"
  }
}

resource "kubernetes_pod" "redis" {
  metadata {
    name = "${var.branch}-redis"
    labels {
      k8s-app = "${var.branch}"
    }
  }
  spec {
    container {
      name  = "redis"
      image = "redis:latest"
      port {
        container_port = 6379
      }
    }
  }
}

resource "kubernetes_service" "click-count" {
  metadata {
    name = "${var.branch}-click-count"
  }
  spec {
    selector {
      k8s-app = "${var.branch}"
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_pod" "click-count" {
  metadata {
    name = "${var.branch}-click-count"
    labels {
      k8s-app = "${var.branch}"
    }
  }
  spec {
    container {
      name  = "click-count"
      image = "thomrick/click-count:${var.version}"
      port {
        container_port = 8080
      }
      env {
        name  = "REDIS_HOST"
        value = "${var.branch}-redis"
      }
    }
  }
}

resource "google_dns_record_set" "record" {
  managed_zone = "${var.dns_zone_name}"
  name         = "${var.branch}.click-count.${var.dns_zone_dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = [
    "${kubernetes_service.click-count.load_balancer_ingress.0.ip}"
  ]
}

resource "google_dns_record_set" "cname" {
  managed_zone = "${var.dns_zone_name}"
  name         = "www.${var.branch}.click-count.${var.dns_zone_dns_name}"
  type         = "CNAME"
  ttl          = 300
  rrdatas      = [
    "${google_dns_record_set.record.name}"
  ]
}
