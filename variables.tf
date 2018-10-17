variable "region" { }    
variable "zone" { }
variable "project_id" { }
variable "network_cidr" {}

variable "nfs_disk_size" { }
variable "nfs_disk_type" {}

variable "qsefe_master_username" {}
variable "qsefe_master_password" {}
variable "qsefe_node_count" {}
variable "qsefe_node_machine_type" {}
variable "qsefe_node_disk_size" {}

variable "qsefe_yaml_discoveryUrl" {}
variable "qsefe_yaml_clientId" {}
variable "qsefe_yaml_clientSecret" {}
variable "qsefe_yaml_realm" {}
variable "qsefe_yaml_hostname" {}

variable "gcp_account"  {}