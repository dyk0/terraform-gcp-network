###
# General variables (these are used across multiple module's resources - DRY
###
variable "project_id" {
  type        = "string"
  description = "GCP project ID to spin this cluster in"
}

variable "timeouts" {
  type        = "map"
  description = "GCP API transaction timeouts"

  default = {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

variable "cluster_region" {
  type        = "string"
  description = "GCP region to spin resources in"
  default     = "us-central1"
}

variable "cluster_name" {
  type        = "string"
  description = "GKE cluster, network & subnetwork name"
  default     = "gke-cluster"
}

###
# GCP Network specific variables
###
variable "source_subnetwork_ip_ranges_to_nat" {
  type        = "string"
  description = "How NAT should be configured per Subnetwork"

  #Valid values are:
  # ALL_SUBNETWORKS_ALL_IP_RANGES,
  # ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES,
  # LIST_OF_SUBNETWORKS

  default = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "nat_ip_allocate_option" {
  type        = "string"
  description = "How external IPs should be allocated for this NAT"

  # Valid values are:
  # AUTO_ONLY,
  # MANUAL_ONLY

  default = "MANUAL_ONLY"
}

variable "enable_flow_logs" {
  type        = "string"
  description = "Whether to enable flow logging for this subnetwork."
  default     = "true"
}

variable "private_ip_google_access" {
  type        = "string"
  description = "Whether the VMs in this subnet can access Google services without assigned external IP addresses."
  default     = "true"
}

variable "auto_create_subnetworks_flag" {
  type        = "string"
  description = "Flag to specify wether or not to create subnetworks on a given network"
  default     = "false"
}

variable "network_cidr" {
  type        = "string"
  description = "GCP network CIDR block to use"

  # Address:   10.0.0.0
  # Netmask:   255.255.0.0 = 16
  # Wildcard:  0.0.255.255
  # Network:   10.0.0.0/16
  # Broadcast: 10.0.255.255
  # HostMin:   10.0.0.1
  # HostMax:   10.0.255.254

  default = "10.0.0.0/16"
}

variable "subnetwork_cidr" {
  type        = "string"
  description = "GCP subnetwork CIDR block to use"

  # Address:   10.0.0.0
  # Netmask:   255.255.192.0 = 18
  # Network:   10.0.0.0/18
  # Broadcast: 10.0.63.255
  # HostMin:   10.0.0.1
  # HostMax:   10.0.63.254

  default = "10.0.0.0/18"
}

variable "pods_cidr" {
  type        = "string"
  description = "GCP VPC subnetwork CIDR block for kubernetes' pods to use"

  # Netmask:   255.255.192.0 = 18
  # Network:   10.0.64.0/18
  # Broadcast: 10.0.127.255
  # HostMin:   10.0.64.1
  # HostMax:   10.0.127.254

  default = "10.0.64.0/18"
}

variable "services_cidr" {
  type        = "string"
  description = "GCP VPC subnetwork CIDR block for kubernetes' services to use"

  # Netmask:   255.255.240.0 = 20
  # Network:   10.0.128.0/20
  # Broadcast: 10.0.143.255
  # HostMin:   10.0.128.1
  # HostMax:   10.0.143.254

  default = "10.0.128.0/20"
}

variable "nat_ip_address_pool_size" {
  type        = "string"
  description = "Number of static IPv4 addresses to append to the NAT"
  default     = "1"
}
