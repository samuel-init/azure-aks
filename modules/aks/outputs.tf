output "cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.name
}

output "cluster_id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.id
}

output "cluster_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.fqdn
}

output "kube_config" {
  description = "Kube config for the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config
  sensitive   = true
}

output "kube_config_raw" {
  description = "Raw kube config for the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "node_resource_group" {
  description = "Auto-generated resource group for AKS nodes"
  value       = azurerm_kubernetes_cluster.this.node_resource_group
}

output "kubelet_identity" {
  description = "Kubelet identity for the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity
}

output "identity_principal_id" {
  description = "Principal ID of the cluster's managed identity"
  value       = azurerm_kubernetes_cluster.this.identity[0].principal_id
}

output "identity_tenant_id" {
  description = "Tenant ID of the cluster's managed identity"
  value       = azurerm_kubernetes_cluster.this.identity[0].tenant_id
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.this.id
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL for the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}
