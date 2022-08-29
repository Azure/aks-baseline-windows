#############
# VARIABLES #
#############

variable "prefix" {}

variable "state_sa_name" {}

variable "container_name" {}

variable "access_key" {}

variable "private_dns_zone_name" {
default =  "privatelink.centralus.azmk8s.io"
}

variable "wnp_count" {
  type = bool
  default = false
}   