#############
# VARIABLES #
#############

variable "prefix" {
  default = "aks-cluster"
}


variable "private_dns_zone_name" {
default =  "privatelink.centralus.azmk8s.io"
}

variable "wnp_count" {
  type = bool
  default = false
} 

variable "resource_group_name" {
  default = "tfstate"
}

variable "storage_account_name" {
  default = "winaksdc"
}

variable "container_name" {
  default = "akscs"
}

variable "key" {
  default = "aks"
}
