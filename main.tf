provider "google" {
  credentials = "${file("account.json")}"
  region      = "${var.region}"
  zone        = "${var.zone}"
  project     = "${var.project_id}"
}
