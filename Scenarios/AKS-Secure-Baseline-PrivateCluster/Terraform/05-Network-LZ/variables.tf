#############
# VARIABLES #
#############

variable "tags" {
  type = map(string)

  default = {
    project = "spoke-lz"
  }
}

variable "lz_prefix" {}


# Used to retrieve outputs from other state files.
# The "access_key" variable is sensitive and should be passed using
# a .TFVARS file or other secure method.

variable "state_sa_name" {}

# variable "container_name" {}

# Storage Account Access Key
# variable "access_key" {}
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



