
#################
# For importing existing groups
##################

data "azuread_group" "appdevs" {
 #display_name = var.aks_user_group
 security_enabled = true
 object_id = var.aks_admin_group_object_id
}

data "azuread_group" "aksops" {
 #display_name = var.aks_admin_group
 security_enabled = true
 object_id = var.aks_user_group_object_id
}

output "appdev_object_id" {
   value = data.azuread_group.appdevs.object_id
}

output "aksops_object_id" {
   value = data.azuread_group.aksops.object_id
}

