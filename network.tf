resource "random_id" "network" {
  prefix = "qlik-sense-vpc-"
  byte_length = 4
}
resource "random_id" "subnetwork" {
  prefix = "qlik-sense-subnet-"
  byte_length = 4
}

resource "google_compute_network" "default" {
  name                    = "${random_id.network.hex}"
  auto_create_subnetworks = "false"
}
resource "google_compute_subnetwork" "default" {
  name                     = "${random_id.subnetwork.hex}"
  region                   = "${var.region}"
  ip_cidr_range            = "${var.network_cidr}"
  network                  = "${google_compute_network.default.self_link}"
  private_ip_google_access = true
}


resource "google_compute_firewall" "qs-https-allow-ingress" {
  name        = "qs-qps-allow-ingress"
  description = "Allow HTTPS access from any source to QPS"
  network     = "${google_compute_network.default.name}"

  allow {
    protocol = "tcp"
#    ports    = ["443"]
  }

#  target_tags = ["${var.central_node["tag"]}"]
}

resource "google_compute_firewall" "qs-icmp-allow-ingress" {
  name        = "qs-icmp-allow-ingress"
  description = "Allow ICMP (ping) access from any source"
  network     = "${google_compute_network.default.name}"

  allow {
    protocol = "icmp"
  }

#  target_tags = ["${var.central_node["tag"]}"]
}

resource "google_compute_firewall" "qs-rdp-allow-ingress" {
  name        = "qs-rdp-allow-ingress"
  description = "Allow RDP access from any source"
  network     = "${google_compute_network.default.name}"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  #target_tags = ["${var.central_node["tag"]}"]
}
