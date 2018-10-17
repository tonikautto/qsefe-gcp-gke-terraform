data "google_container_cluster" "qsefe" {
  name   = "${google_container_cluster.qsefe.name}"
  zone   = "${var.zone}"
}
output "cluster_username" {
  value = "${data.google_container_cluster.qsefe.master_auth.0.username}"
}
output "cluster_password" {
  value = "${data.google_container_cluster.qsefe.master_auth.0.password}"
}
output "endpoint" {
  value = "${data.google_container_cluster.qsefe.endpoint}"
}

