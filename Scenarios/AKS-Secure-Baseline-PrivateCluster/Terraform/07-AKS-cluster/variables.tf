#############
# VARIABLES #
#############
variable "private_dns_zone_name" {
  # update this in the .tfvars file
}

variable "dns_prefix" {
  # update this in the .tfvars file
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

variable "access_key" {
  type      = string
  sensitive = true
}
