#############
# VARIABLES #
#############

variable "prefix" {}

variable "state_sa_name" {}

#variable "container_name" {}

variable "private_dns_zone_name" {
default =  "privatelink.centralus.azmk8s.io"
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


variable "wnp_count" {
  type = bool
  default = false
} 


