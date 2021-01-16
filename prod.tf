variable "access_key" {
}

variable "subscription_id" {
}

variable "client_id" {
}

variable "tenant_id" {
}

variable "client_secret" {
}

variable "env_prefix" {
}

variable "env_subscription" {
}

variable "location" {
}


provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.14.0"

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "mbvcspnlterrafrombackend"
    container_name       = "qa-terrafrom"
    key                  = "terraform.tfstate"
    access_key           = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
}

# Create a resource group
resource "azurerm_resource_group" "modpoc" {
  name     = "${var.env_prefix}-${var.env_subscription}-rg"
  location = "${var.location}"
}


#kubernetes
module "kube" {
  source = "./modules/kubernetes/spot-node-pool"

  rg       = azurerm_resource_group.modpoc.name
  location = azurerm_resource_group.modpoc.location
  prefix   = var.env_prefix
}

output "kube_cluster_ca_certificate" {
  value = "${module.kube.cluster_ca_certificate}"
}










