variable "prefix" {
  description = "A prefix used for all resources in this example"
}

variable "location" {}

variable "resource_group_name" {}

variable "vnet_subnet_id" {}

variable "mi_aks_cp_id" {}

variable "aks_admin_group" {}

variable "la_id" {}

variable "private_dns_zone_id" {}

variable "wnp_count" {
  type = bool
}
 