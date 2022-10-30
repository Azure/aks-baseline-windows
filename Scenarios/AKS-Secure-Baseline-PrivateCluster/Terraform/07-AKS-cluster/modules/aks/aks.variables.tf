variable "prefix" {
  description = "A prefix used for all resources in this example"
}

variable "private_dns_zone_name" {}

variable "location" {

default = "Central US"

}

variable "resource_group_name" {}

variable "vnet_subnet_id" {}

variable "mi_aks_cp_id" {}

# variable "mi_aks_kubelet_id" {
  
# }

variable "la_id" {}

variable "gateway_name" {}

variable "gateway_id" {}

variable "private_dns_zone_id" {}

variable "wnp_count" {
  type = bool
}


