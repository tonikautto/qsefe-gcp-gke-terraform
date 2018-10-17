
resource "random_id" "node_pool" {
  prefix = "qsefe-node-pool-"
  byte_length = 4
}
resource "random_id" "cluster" {
  prefix = "qsefe-container-cluster-"
  byte_length = 4
}
# resource "random_id" "nfs_disk" {
#   prefix = "qsefe-nfs-disk-"
#   byte_length = 4
# }

resource "google_container_cluster" "qsefe" {
  name          = "${random_id.cluster.hex}"
  description   = "Qlik Sense for Elastic K8s cluster"

  zone          = "${var.zone}"
  network       = "${google_compute_network.default.name}"
  subnetwork    = "${google_compute_subnetwork.default.name}"
  

  depends_on = ["data.template_file.qsefe_yaml", 
                "data.template_file.dep_nfs_yaml", 
                "data.template_file.pv_pvc_nfs_yaml", 
                "data.template_file.tiller_rbac_yaml",
                "data.template_file.srv_nfs_yaml"]

  master_auth {
    username = "${var.qsefe_master_username}"
    password = "${var.qsefe_master_password}"
  }

  node_pool {
    name       = "${random_id.node_pool.hex}"
    node_count = "${var.qsefe_node_count}"

    node_config {
      machine_type = "${var.qsefe_node_machine_type}"
      disk_size_gb = "${var.qsefe_node_disk_size}"
    }
  }

#gcloud auth login ${var.gcp_account} --brief --launch-browser

  provisioner "local-exec" { 
    command = <<EOF
gcloud config set project ${var.project_id}
gcloud config set compute/zone ${var.zone}
gcloud config set account ${var.gcp_account}
gcloud container clusters get-credentials ${google_container_cluster.qsefe.name}
    EOF
#    command = "./cluster_config.sh"
#    interpreter = ""
  }
  provisioner "local-exec" { 
    command = <<EOF
helm init --upgrade
kubectl config current-context
kubectl create -f ./yaml/tiller-rbac.yaml
helm init --service-account tiller --upgrade
kubectl create -f ./yaml/dep-nfs.yaml
kubectl create -f ./yaml/pv-pvc-nfs.yaml
kubectl create -f ./yaml/srv-nfs.yaml
pods=1; while [ $pods -gt 0 ]; do sleep 10; pods=$(kubectl get pods | awk '{if(NR>1)print}' | grep -iv 'running' | wc -l); echo "Waiting for NFS pod to start..."; done
nfs_pod_name=$(kubectl get pods | awk '{if(NR>1){print $1}}')
kubectl exec $nfs_pod_name chmod 777 /exports
helm repo add qlik https://qlik.bintray.com/stable
helm install -n qsefe qlik/qsefe --set engine.acceptEULA=\"yes\" -f ./yaml/qsefe.yaml
pods=1; while [ $pods -gt 1 ]; do sleep 20; pods=$(kubectl get pods | awk '{if(NR>1)print}' | grep -iv 'running' | wc -l); echo "$pods QSEfE pods still starting..."; done
kubectl get service -l app=nginx-ingress --namespace default  
    EOF
#    command = "./cluster_config.sh"
#    interpreter = ""
# ToDo:

  }
}
resource "google_compute_disk" "gke-nfs-disk" {
  name = "gke-nfs-disk"    #"${random_id.nfs_disk.hex}"
  type = "${var.nfs_disk_type}"
  zone = "${var.zone}"
  size = "${var.nfs_disk_size}"
}



