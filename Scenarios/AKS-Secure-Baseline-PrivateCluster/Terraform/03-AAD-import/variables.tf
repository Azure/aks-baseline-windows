#############
# VARIABLES #
#############

## AKS security groups ##

variable "aks_admin_group" {
  default = "AKS App Admin Team 2"
}

variable "aks_user_group" {
  default = "AKS App Dev Team 2"
}

variable "subscription_id" {
  description = "Azure subscription Id."
  default     = null
}

## Following Variables are for TF State storage account information used for Terraform state file"

variable "resource_group_name" {
  default = "tfstate"
}

variable "storage_account_name" {
  default = "winaksdc"

}
variable "container_name" {
  default = "akscs"
}

# # required in some cases
# variable "tenant_id" {
#   description = "Azure tenant Id."
#    default = null
# }

# variable "client_id" {
# description = "Azure service principal application Id"
# default = null
# }

# variable "client_secret" {
#   description = "Azure service principal application Secret"
#   default = null
# }

# variable "access_key" {}

# variable "resource_group_name" {}
# variable "storage_account_name" {}
# variable "container_name" {}
