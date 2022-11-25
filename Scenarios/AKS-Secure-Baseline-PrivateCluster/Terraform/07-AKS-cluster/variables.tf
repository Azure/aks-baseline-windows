#############
# VARIABLES #
#############

variable "prefix" {
  default = "aks-cluster"
}

variable "private_dns_zone_name" {
  # update this in the .tfvars file
}

variable "wnp_count" {
  type    = bool
  default = true
}

variable "resource_group_name" {
  default = "tfstate"
}

variable "storage_account_name" {}

variable "container_name" {
  default = "akscs"
}

variable "access_key" {
  type      = string
  sensitive = true
}

variable "aks_admin_group" {
  default = "AKS App Admin Team 2"
}

variable "aks_user_group" {
  default = "AKS App Dev Team 2"
}