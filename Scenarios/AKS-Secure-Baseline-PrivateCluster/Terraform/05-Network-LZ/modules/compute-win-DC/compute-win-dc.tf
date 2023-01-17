resource "azurerm_windows_virtual_machine" "computedc" {

  name                            = var.server_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  #disable_password_authentication = var.disable_password_authentication //Set to true if using SSH key
  tags                            = var.tags

  network_interface_ids = [
    azurerm_network_interface.computedc.id
  ]

  os_disk {
    caching              = "None"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version

  }

  boot_diagnostics {
    storage_account_uri = null
  }
}

resource "azurerm_network_interface" "computedc" {

  name                          = "${var.server_name}-nic"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  enable_accelerated_networking = var.enable_accelerated_networking

  tags = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.vnet_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.240.6.4"
  }
}


##########################################################
## Promote VM to be a Domain Controller
##########################################################

locals { 
  import_command       = "Import-Module ADDSDeployment"
  password_command     = "$password = ConvertTo-SecureString ${var.admin_password} -AsPlainText -Force"
  install_ad_command   = "Add-WindowsFeature -name ad-domain-services -IncludeManagementTools"
  configure_ad_command = "Install-ADDSForest -CreateDnsDelegation:$false -DomainMode Win2012R2 -DomainName ${var.active_directory_domain} -DomainNetbiosName ${var.active_directory_netbios_name} -ForestMode Win2012R2 -InstallDns:$true -SafeModeAdministratorPassword $password -Force:$true"
  shutdown_command     = "shutdown -r -t 10"
  exit_code_hack       = "exit 0"
  powershell_command   = "${local.import_command}; ${local.password_command}; ${local.install_ad_command}; ${local.configure_ad_command}; ${local.shutdown_command}; ${local.exit_code_hack}"
}

resource "azurerm_virtual_machine_extension" "create-active-directory-forest" {
  name                 = "create-active-directory-forest"
  #location             = var.location
  #resource_group_name  = var.resource_group_name
  virtual_machine_id = azurerm_windows_virtual_machine.computedc.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell.exe -Command \"${local.powershell_command}\""
    }
SETTINGS
}



##########################################################
## Variables for DC configrations
##########################################################

variable "admin_username" {
  default = "sysadmin"
}

variable "admin_password" {}

variable "server_name" {}

variable "resource_group_name" {}

variable "location" {}

variable "vnet_subnet_id" {}
variable "os_publisher" {
  default = "MicrosoftWindowsServer"
}
variable "os_offer" {
  default = "WindowsServer"
}
variable "os_sku" {
  default = "2019-Datacenter"
}
variable "os_version" {
  default = "latest"
}
variable "disable_password_authentication" {
  default = false #leave as true if using ssh key, if using a password make the value false
}
variable "enable_accelerated_networking" {
  default = "false"
}
variable "storage_account_type" {
  default = "Standard_LRS"
}
variable "vm_size" {
  default = "Standard_D2s_v3"
}
variable "tags" {
  type = map(string)

  default = {
    application = "compute",
    tier = "DC"
  }
}

variable "allocation_method" {
  default = "Static"
}

variable "active_directory_domain" {
  default = "lzacc.com"
}

variable "active_directory_netbios_name" {
  default = "lzacc"
}