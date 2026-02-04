# ACR Module Outputs

output "acr_id" {
  description = "The ID of the Azure Container Registry."
  value       = azurerm_container_registry.acr.id
}

output "acr_name" {
  description = "The name of the Azure Container Registry."
  value       = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  description = "The login server URL of the Azure Container Registry."
  value       = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "The admin username of the Azure Container Registry (if admin is enabled)."
  value       = var.admin_enabled ? azurerm_container_registry.acr.admin_username : null
  sensitive   = true
}

output "acr_admin_password" {
  description = "The admin password of the Azure Container Registry (if admin is enabled)."
  value       = var.admin_enabled ? azurerm_container_registry.acr.admin_password : null
  sensitive   = true
}

output "acr_resource_group_name" {
  description = "The resource group name of the Azure Container Registry."
  value       = azurerm_container_registry.acr.resource_group_name
}

output "acr_location" {
  description = "The location of the Azure Container Registry."
  value       = azurerm_container_registry.acr.location
}

output "acr_sku" {
  description = "The SKU of the Azure Container Registry."
  value       = azurerm_container_registry.acr.sku
}
