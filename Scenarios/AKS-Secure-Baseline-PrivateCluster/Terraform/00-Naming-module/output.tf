output "names" {
  value = {
    for resourcetype, resource in local.resources : resourcetype => resource.name if resource.toolong != true
  }
  description = "delivers a list of all resource names available mapped to the azurerm resource"
}

output "names_toolong" {
  value = {
    for resourcetype, resource in local.resources : resourcetype => resource.name if resource.toolong != false
  }
  description = "delivers a list of all resource names which are too long to be made available in `names`"
}

output "resources" {
  value       = local.resources
  description = "full resource object containing name, toolong, max_length, slug and others"
}
