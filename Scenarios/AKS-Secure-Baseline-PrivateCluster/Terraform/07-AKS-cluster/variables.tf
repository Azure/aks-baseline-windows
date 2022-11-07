#############
# VARIABLES #
#############

variable "prefix" {
  default = "aks-cluster"
}

variable "private_dns_zone_name" {
  default =  "privatelink.eastus.azmk8s.io"
}

variable "wnp_count" {
  type = bool
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
  type = string
  sensitive = true
}
