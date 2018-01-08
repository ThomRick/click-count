output "cluster_host" {
  value = "${google_container_cluster.cluster.endpoint}"
}

output "cluster_username" {
  value = "${google_container_cluster.cluster.master_auth.0.username}"
}

output "cluster_password" {
  value = "${google_container_cluster.cluster.master_auth.0.password}"
}

output "cluster_client_key" {
  value = "${google_container_cluster.cluster.master_auth.0.client_key}"
}

output "cluster_client_certificate" {
  value = "${google_container_cluster.cluster.master_auth.0.client_certificate}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.cluster.master_auth.0.cluster_ca_certificate}"
}

output "dns_zone_name" {
  value = "${google_dns_managed_zone.dns-managed-zone.name}"
}

output "dns_zone_dns_name" {
  value = "${google_dns_managed_zone.dns-managed-zone.dns_name}"
}