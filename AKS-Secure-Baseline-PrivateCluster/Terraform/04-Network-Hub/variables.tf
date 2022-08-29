#############
# VARIABLES #
#############

variable "location" {}

variable "tags" {
  type = map(string)

  default = {
    project = "ashis"
  }
}

variable "hub_prefix" {}

variable "sku_name" {
  default = "AZFW_VNet"
}

variable "sku_tier" {
  default = "Standard"
}

#variable "active_directory_domain" {}

#variable "active_directory_netbios_name" {}


## Sensitive Variables for the Jumpbox
## Sample terraform.tfvars File


