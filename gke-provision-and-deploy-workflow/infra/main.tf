terraform {
  required_version = ">= 0.11.11"
  backend "gcs" {}
}

provider "google" {
  credentials = "${var.google-credentials}"
  project     = "${local.workspace["gcp_project"]}"
  region      = "${local.workspace["gcp_region"]}"

  scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

resource "google_container_cluster" "k8scluster" {
  name               = "nebula-example-cluster"
  description        = "A cluster created from an example workflow in Project Nebula"
  location           = "${local.workspace["gcp_location"]}"
  initial_node_count = "${var.initial_node_count}"

  master_auth {
    username = ""

    client_certificate_config {
      issue_client_certificate = true
    }
  }

  node_config {
    machine_type = "${var.node_machine_type}"
    disk_size_gb = "${var.node_disk_size}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/userinfo.email"
    ]
  }
}

data "google_client_config" "current" {}