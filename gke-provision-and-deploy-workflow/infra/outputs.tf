output "k8s_endpoint" {
  value = "https://${google_container_cluster.k8scluster.endpoint}"
  sensitive = true
}

output "k8s_master_auth_cluster_ca_certificate" {
  value = "${google_container_cluster.k8scluster.master_auth.0.cluster_ca_certificate}"
  sensitive = true
}

output "k8s_current_access_token" {
  value = "${data.google_client_config.current.access_token}"
  sensitive = true
}