output "name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.paul.name
}

output "location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.paul.location
  # sensitive = true
}

output "id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.paul.id
}
