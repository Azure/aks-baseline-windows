#############
# VARIABLES #
#############
variable "location" {

  default = "eastus"
}

variable "tags" {
  type = map(string)

  default = {
    project = "spoke-lz"
  }
}

variable "lz_prefix" {
  default = "lz"
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
  sensitive = true
  type      = string
}
