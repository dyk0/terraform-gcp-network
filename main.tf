resource "google_compute_network" "primary" {
  provider                = "google"
  project                 = "${var.project_id}"
  name                    = "${var.cluster_name}"
  auto_create_subnetworks = "${var.auto_create_subnetworks_flag}"
}

resource "google_compute_subnetwork" "primary" {
  provider                 = "google"
  project                  = "${var.project_id}"
  name                     = "${var.cluster_name}"
  ip_cidr_range            = "${var.subnetwork_cidr}"
  network                  = "${google_compute_network.primary.self_link}"
  private_ip_google_access = "${var.private_ip_google_access}"
  enable_flow_logs         = "${var.enable_flow_logs}"

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "${var.services_cidr}"
  }

  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "${var.pods_cidr}"
  }
}

resource "google_compute_router" "primary" {
  name    = "${var.cluster_name}"
  region  = "${var.cluster_region}"
  network = "${google_compute_network.primary.self_link}"
  project = "${var.project_id}"
}

resource "google_compute_address" "primary" {
  count   = "${var.nat_ip_address_pool_size}"
  name    = "${var.cluster_name}-nat-external-address-${count.index}"
  region  = "${var.cluster_region}"
  project = "${var.project_id}"
}

resource "google_compute_router_nat" "primary" {
  name                               = "${var.cluster_name}"
  router                             = "${google_compute_router.primary.name}"
  region                             = "${var.cluster_region}"
  nat_ip_allocate_option             = "${var.nat_ip_allocate_option}"
  nat_ips                            = ["${google_compute_address.primary.*.self_link}"]
  source_subnetwork_ip_ranges_to_nat = "${var.source_subnetwork_ip_ranges_to_nat}"
  project                            = "${var.project_id}"
}
