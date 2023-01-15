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

}

variable "container_name" {
  default = "akscs"
}

variable "access_key" {
  sensitive = true
  type      = string
}

## Sensitive Variables for the Jumpbox
## Sample terraform.tfvars File

variable "admin_password" {
  default   = "Superm@n1234"
  sensitive = true
}

variable "admin_username" {
  default = "sysadmin"
}
