data "template_file" "qsefe_yaml" {
  template = "${file("qsefe.tpl.yaml")}"

  vars {
    discoveryUrl = "${var.qsefe_yaml_discoveryUrl}"
    clientId     = "${var.qsefe_yaml_clientId}"
    clientSecret = "${var.qsefe_yaml_clientSecret}"
    realm        = "${var.qsefe_yaml_realm}"
    hostname     = "${var.qsefe_yaml_hostname}"
  }
}
resource "local_file" "qsefe_yaml" {
  content  = "${data.template_file.qsefe_yaml.rendered}"
  filename = "./yaml/qsefe.yaml"
}
data "template_file" "dep_nfs_yaml" {
  template = "${file("dep-nfs.tpl.yaml")}"
}
resource "local_file" "dep_nfs_yaml" {
  content  = "${data.template_file.dep_nfs_yaml.rendered}"
  filename = "./yaml/dep-nfs.yaml"
}
data "template_file" "pv_pvc_nfs_yaml" {
  template = "${file("pv-pvc-nfs.tpl.yaml")}"
}
resource "local_file" "pv_pvc_nfs_yaml" {
  content  = "${data.template_file.pv_pvc_nfs_yaml.rendered}"
  filename = "./yaml/pv-pvc-nfs.yaml"
}
data "template_file" "tiller_rbac_yaml" {
  template = "${file("tiller-rbac.tpl.yaml")}"
}
resource "local_file" "tiller_rbac_yaml" {
  content  = "${data.template_file.tiller_rbac_yaml.rendered}"
  filename = "./yaml/tiller-rbac.yaml"
}
data "template_file" "srv_nfs_yaml" {
  template = "${file("srv-nfs.tpl.yaml")}"
}
resource "local_file" "srv_nfs_yaml" {
  content  = "${data.template_file.srv_nfs_yaml.rendered}"
  filename = "./yaml/srv-nfs.yaml"
}