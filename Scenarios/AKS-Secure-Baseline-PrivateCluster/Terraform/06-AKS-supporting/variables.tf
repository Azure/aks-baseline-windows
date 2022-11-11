#############
# VARIABLES #
#############
variable "prefix" {
  default = "aks"
}

# The Public Domain for the public dns zone, that is used to register the hostnames assigned to the workloads hosted in AKS; if empty the dns zone not provisioned.
variable "public_domain" {
  description = "The Public Domain for the public dns zone, that is used to register the hostnames assigned to the workloads hosted in AKS; if empty the dns zone not provisioned."
  default     = ""
}
## Terraform backend state variables ##

variable "resource_group_name" {
  default = "tfstate"
}

variable "storage_account_name" {
  default = "winaks"
}

variable "container_name" {
  default = "akscs"
}

variable "access_key" {
  type      = string
  sensitive = true
}


# required in some cases

# variable "subscription_id" {
#   description = "Azure subscription Id."
#   default = null
# }

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
