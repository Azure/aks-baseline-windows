#############
# VARIABLES #
#############

variable "prefix" {}

#variable "access_key" {}   # Provide using a .tfvars file.

variable "state_sa_name" {}

#variable "container_name" {}

# The Public Domain for the public dns zone, that is used to register the hostnames assigned to the workloads hosted in AKS; if empty the dns zone not provisioned.
variable "public_domain" {
    description = "The Public Domain for the public dns zone, that is used to register the hostnames assigned to the workloads hosted in AKS; if empty the dns zone not provisioned."
    default = ""
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

