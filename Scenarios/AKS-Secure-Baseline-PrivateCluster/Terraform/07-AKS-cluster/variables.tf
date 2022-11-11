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
  default = false
}

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
