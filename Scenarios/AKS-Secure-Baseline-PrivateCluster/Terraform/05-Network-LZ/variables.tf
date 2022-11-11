#############
# VARIABLES #
#############

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

# # required in some cases

variable "subscription_id" {
  description = "Azure subscription Id."
  default     = null
}

variable "tenant_id" {
  description = "Azure tenant Id."
  default     = null
}

variable "client_id" {
  description = "Azure service principal application Id"
  default     = null
}

variable "client_secret" {
  description = "Azure service principal application Secret"
  default     = null
}
