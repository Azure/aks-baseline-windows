#############
# VARIABLES #
#############
variable "prefix" {
  default = "aks"
}

# The Public Domain for the public dns zone, that is used to register the hostnames assigned to the workloads hosted in AKS; if empty the dns zone not provisioned.
variable "public_domain" {
    description = "The Public Domain for the public dns zone, that is used to register the hostnames assigned to the workloads hosted in AKS; if empty the dns zone not provisioned."
    default = ""
}
## Terraform backend state variables ##

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
}