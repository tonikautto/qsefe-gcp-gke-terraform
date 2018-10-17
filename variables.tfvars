# Define GCP region and zone for deployment
# See https://cloud.google.com/compute/docs/regions-zones/#available for available options. 

# region  = "REGION"
# zone    = "ZONE"

# GCP project ID for QSEfE deployment. 
# Set to qsefe-gke-tf if you followed the GCP setup in https://github.com/tonikautto/qsefe-gcp-gke-terraform/blob/master/README.md#google-cloud-platform-gcp

# project_id = "PROJECT"

# GCP user account to deploy from

# gcp_account = "GCP_USERNAME"

# IPv4 CIDR for VPC setup
network_cidr = "192.168.0.0/24"

# QSEfE storage disk, used in NFS server
# Type can be set pd-standard or pd-ssd  
nfs_disk_size = "30"
nfs_disk_type = "pd-standard"                 


# Google Kubernetes Engine (GKE) configuration
# No of nodes in kubernetes clusters
# Machine type reference: https://cloud.google.com/compute/docs/machine-types
# Local disk size for each node
qsefe_node_count        = "3"
qsefe_node_machine_type = "n1-standard-1"
qsefe_node_disk_size    = "20"

# GKE master user credentials
# Password defined in plain text

# qsefe_master_username = "USERNAME"
# qsefe_master_password = "PASSWORD"

# Identity provdider (IdP) configuration
# See Idp for more details on values

# qsefe_yaml_discoveryUrl = "https://DISCOVERY_URL"
# qsefe_yaml_clientId     = "CLIENTID"
# qsefe_yaml_clientSecret = "CLIENTSECRET"
# qsefe_yaml_realm        = "REALM"
# qsefe_yaml_hostname     = "HOSTNAME"
