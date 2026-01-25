output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.resource_group.name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = module.resource_group.location
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.aks.cluster_name
}

output "aks_cluster_id" {
  description = "ID of the AKS cluster"
  value       = module.aks.cluster_id
}

output "aks_cluster_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = module.aks.cluster_fqdn
}

output "aks_kube_config" {
  description = "Kube config for the AKS cluster"
  value       = module.aks.kube_config
  sensitive   = true
}

output "aks_kube_config_raw" {
  description = "Raw kube config for the AKS cluster"
  value       = module.aks.kube_config_raw
  sensitive   = true
}

output "aks_node_resource_group" {
  description = "Auto-generated resource group for AKS nodes"
  value       = module.aks.node_resource_group
}

output "aks_kubelet_identity" {
  description = "Kubelet identity for the AKS cluster"
  value       = module.aks.kubelet_identity
}

output "aks_network_plugin" {
  description = "Network plugin used by the AKS cluster"
  value       = var.network_plugin
}

