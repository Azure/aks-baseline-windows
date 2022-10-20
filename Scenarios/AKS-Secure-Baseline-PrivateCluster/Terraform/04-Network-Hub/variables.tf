#############
# VARIABLES #
#############

variable "location" {}
#variable "firewallName" {}

variable "tags" {
  type = map(string)

  default = {
    project = "cs-aks"
  }
}

variable "hub_prefix" {}

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

variable "subscription_id" {
  description = "Azure subscription Id."
  default = null
}

variable "tenant_id" {
  description = "Azure tenant Id."
   default = null
}

variable "client_id" {
description = "Azure service principal application Id"
default = null
}

variable "client_secret" {
  description = "Azure service principal application Secret"
  default = null
}

variable "access_key" {}
variable "resource_group_name" {}
variable "storage_account_name" {}
variable "container_name" {}