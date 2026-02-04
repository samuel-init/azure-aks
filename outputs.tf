output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.resource_group.name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = module.resource_group.location
  # sensitive = true
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

output "nginx_ingress_status" {
  description = "Status of the NGINX Ingress Controller Helm release"
  value       = var.nginx_ingress_enabled ? module.nginx_ingress[0].release_metadata : null
}

# =============================================================================
# ACR Outputs
# =============================================================================

output "acr_id" {
  description = "ID of the Azure Container Registry"
  value       = var.acr_enabled ? module.acr[0].acr_id : null
}

output "acr_name" {
  description = "Name of the Azure Container Registry"
  value       = var.acr_enabled ? module.acr[0].acr_name : null
}

output "acr_login_server" {
  description = "Login server URL of the Azure Container Registry"
  value       = var.acr_enabled ? module.acr[0].acr_login_server : null
}

# =============================================================================
# ArgoCD Outputs
# =============================================================================

output "argocd_status" {
  description = "Status of the ArgoCD Helm release"
  value       = var.argocd_enabled ? module.argocd[0].release_metadata : null
}

output "argocd_namespace" {
  description = "Namespace where ArgoCD is installed"
  value       = var.argocd_enabled ? var.argocd_namespace : null
}

output "argocd_server_url" {
  description = "ArgoCD server URL (Ingress host)"
  value       = var.argocd_enabled && var.argocd_ingress_enabled ? "https://${var.argocd_ingress_host}" : null
}
