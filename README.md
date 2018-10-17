Qlik Sense for Elastic in GCP with GKE through Terraform
===

Automation of Qlik Sense for Elastic (QSEfE) deployment in Google Cloud Platform (GCP). Currently I have not found a way to run the required installation shell scripts directly in GKE's GCE instances, so the QSEfE installation is deployed for client side. 

See [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) as an option to run this from a Windows client. 
<!-- TOC -->

- [Prerequisites](#prerequisites)
    - [Qlik Sense for Elastic (QSEfE)](#qlik-sense-for-elastic-qsefe)
    - [Client side tools](#client-side-tools)
    - [Google Cloud Platform (GCP)](#google-cloud-platform-gcp)
- [Terraform Configuration](#terraform-configuration)
- [Deploy](#deploy)
- [Destroy](#destroy)
- [License](#license)

<!-- /TOC -->
## Prerequisites

### Qlik Sense for Elastic (QSEfE)

* Qlik license
* Qlik Sense for Windows (QSEfW) on a central node
* SSO IdP that supports OIDC and SAML

### Client side tools

* [Terraform](https://www.terraform.io/downloads.html) - Infrastructure as code
* [Gcloud SDK](https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu) - Google Cloud Platform (GCP) interaction
* [kubectl](https://docs.docker.com/ee/ucp/user-access/kubectl/) - Kubernetes CLI 
* [helm](https://docs.helm.sh/using_helm/#installing-helm) - Kubernetes applications manager

### Google Cloud Platform (GCP)

The deployment requires an account with remaining credits or with enabled billing. 

1. Login to GCP<br/> `gcloud auth login your@mail.com`
1. Create project for QSEfE deployment<br/> `gcloud projects create qsefe-gke-tf --name='QSEfE in GKE through Terraform'`
1. Set new project as active<br/> `gcloud config set project qsefe-gke-tf`
1. Add service account to project<br/> `gcloud iam service-accounts create qsefe-sa --display-name='QSEfE Service Account'`
1. Create GCP account file<br/> `gcloud iam service-accounts keys create account.json --iam-account qsefe-sa@qsefe-gke-tf.iam.gserviceaccount.com` 
1. Bind servcie account to required roles 
    * Kubernetes Engine Admin <br/>`gcloud projects add-iam-policy-binding qsefe-gke-tf --member serviceAccount:qsefe-sa@qsefe-gke-tf.iam.gserviceaccount.com --role roles/container.admin`
    * Compute Engine Admin<br/> `gcloud projects add-iam-policy-binding qsefe-gke-tf --member serviceAccount:qsefe-sa@qsefe-gke-tf.iam.gserviceaccount.com --role roles/compute.admin`

## Terraform Configuration

*variables.tfvars.template* contains a template for defining the variables used by  terraform manifests

1. Copy variable template<br/> `cp variables.tfvars.template variables.auto.tfvars` 
1. Edit variable to match your setup and requirements<br/> `vim variables.auto.tfvars`
1. Terraform automatically picks up variables from *.auto.tfvars* files<br/> `terraform plan`

## Deploy

1. Login to GCP `gcloud auth login your@mail.com`
1. Initiate Terrafrom `terraform init`
1. Validate config `terraform plan`
1. Deploy GCP infrastructure and install Qlik Sense for Elastic `terraform apply` 

## Destroy

1. Deploy Qlik Sense `terraform destroy` 

## License

This project is provided "AS IS", without any warranty, under the MIT License - see the [LICENSE](LICENSE) file for details
