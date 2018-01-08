provider "google" {
  credentials = "${file("../../credentials/terraform.json")}"
  project     = "xebia-veille"
  region      = "europe-west1"
}

resource "google_container_cluster" "cluster" {
  name               = "${var.environment}"
  project            = "xebia-veille"
  zone               = "europe-west1-d"
  initial_node_count = 1
}

resource "google_dns_managed_zone" "dns-managed-zone" {
  name        = "${var.environment}"
  dns_name    = "thomrick.com."
  description = "Root DNS managed zone"
}
