#############
# VARIABLES #
#############

variable "location" {

default = "eastus"
}
#variable "firewallName" {}

variable "tags" {
  type = map(string)

  default = {
    project = "cs-aks"
  }
}

variable "hub_prefix" {
  default = "aks-hub"
}

variable "sku_name" {
  default = "AZFW_VNet"
}

variable "sku_tier" {
  default = "Standard"
}

## Sensitive Variables for the Jumpbox
## Sample terraform.tfvars File

variable "admin_password" {
  default = "changeme"
}

variable "admin_username" {
  default = "sysadmin"
}

## Terraform backend state variables ##

variable "resource_group_name" {
  default = "tfstate"
}

variable "storage_account_name" {
  default = "winaksdc"
}

variable "container_name" {
  default = "akscs"
}

variable "key" {
  default = "network-hub"
}