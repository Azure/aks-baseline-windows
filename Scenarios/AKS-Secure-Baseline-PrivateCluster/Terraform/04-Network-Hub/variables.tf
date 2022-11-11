#############
# VARIABLES #
#############

variable "location" {

  default = "eastus"
}
#variable "firewallName" {}

variable "tags" {
  type = map(string)

  default = {
    project = "cs-aks"
  }
}

variable "hub_prefix" {
  default = "aks"
}

variable "sku_name" {
  default = "AZFW_VNet"
}

variable "sku_tier" {
  default = "Standard"
}

## Sensitive Variables for the Jumpbox
## Sample terraform.tfvars File

variable "admin_password" {
  default   = ""
  sensitive = true
}

variable "admin_username" {
  default = "sysadmin"
}

## Terraform backend state variables update with your storage account information ##

variable "resource_group_name" {
  default = "tfstate"
}

variable "storage_account_name" {
}

variable "container_name" {
  default = "akscs"
}


# required in some cases

# variable "subscription_id" {
#   description = "Azure subscription Id."
#   default     = null
# }

# variable "tenant_id" {
#   description = "Azure tenant Id."
#   default     = null
# }

# variable "client_id" {
#   description = "Azure service principal application Id"
#   default     = null
# }

# variable "client_secret" {
#   description = "Azure service principal application Secret"
#   default     = null
# }
