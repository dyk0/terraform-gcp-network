output "vpc_subnetwork" {
  value = "${google_compute_subnetwork.primary.self_link}"
}

output "vpc_network" {
  value = "${google_compute_network.primary.self_link}"
}

output "cluster_ip_cidr_range" {
  value = "${google_compute_subnetwork.primary.ip_cidr_range}"
}

output "cluster_services_secondary_range" {
  value = "${var.services_cidr}"
}

output "cluster_cluster_secondary_range" {
  value = "${var.pods_cidr}"
}
