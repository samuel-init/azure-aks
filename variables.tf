variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-aks-default"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
  # sensitive  = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Development"
    Project     = "AKS-Default-Network"
    ManagedBy   = "Terraform"
  }
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "aks-default-cluster"
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = "aksdefault"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster"
  type        = string
  default     = null
}

variable "default_node_pool_name" {
  description = "Name of the default node pool"
  type        = string
  default     = "default"
}

variable "default_node_pool_vm_size" {
  description = "VM size for the default node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "default_node_pool_node_count" {
  description = "Initial number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "default_node_pool_min_count" {
  description = "Minimum number of nodes for autoscaling"
  type        = number
  default     = 1
}

variable "default_node_pool_max_count" {
  description = "Maximum number of nodes for autoscaling"
  type        = number
  default     = 5
}

variable "enable_auto_scaling" {
  description = "Enable cluster autoscaler for the default node pool"
  type        = bool
  default     = true
}

variable "network_plugin" {
  description = "Network plugin to use (azure or kubenet)"
  type        = string
  default     = "azure"
}

variable "network_policy" {
  description = "Network policy to use (azure, calico, or null)"
  type        = string
  default     = "azure"
}

variable "load_balancer_sku" {
  description = "SKU for the load balancer (basic or standard)"
  type        = string
  default     = "standard"
}

variable "nginx_ingress_enabled" {
  description = "Enable NGINX Ingress Controller installation"
  type        = bool
  default     = true
}

variable "nginx_ingress_release_name" {
  description = "Helm release name for NGINX Ingress"
  type        = string
  default     = "ingress-nginx"
}

variable "nginx_ingress_repository" {
  description = "Helm repository URL for NGINX Ingress"
  type        = string
  default     = "https://kubernetes.github.io/ingress-nginx"
}

variable "nginx_ingress_chart" {
  description = "Helm chart name for NGINX Ingress"
  type        = string
  default     = "ingress-nginx"
}

variable "nginx_ingress_chart_version" {
  description = "Helm chart version for NGINX Ingress"
  type        = string
  default     = "4.9.0"
}

variable "nginx_ingress_namespace" {
  description = "Kubernetes namespace for NGINX Ingress"
  type        = string
  default     = "ingress-nginx"
}

variable "nginx_ingress_create_namespace" {
  description = "Create namespace for NGINX Ingress if it doesn't exist"
  type        = bool
  default     = true
}

variable "nginx_ingress_replica_count" {
  description = "Number of NGINX Ingress controller replicas"
  type        = number
  default     = 2
}

# =============================================================================
# ACR (Azure Container Registry) Variables
# =============================================================================

variable "acr_enabled" {
  description = "Enable Azure Container Registry"
  type        = bool
  default     = true
}

variable "acr_name" {
  description = "Name of the Azure Container Registry (must be globally unique, alphanumeric only)"
  type        = string
  default     = "acraksdefault"
}

variable "acr_sku" {
  description = "SKU of the Azure Container Registry (Basic, Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "acr_admin_enabled" {
  description = "Enable admin user for ACR"
  type        = bool
  default     = false
}

variable "acr_enable_diagnostics" {
  description = "Enable diagnostic settings for ACR"
  type        = bool
  default     = true
}

# =============================================================================
# ArgoCD Variables
# =============================================================================

variable "argocd_enabled" {
  description = "Enable ArgoCD installation"
  type        = bool
  default     = true
}

variable "argocd_release_name" {
  description = "Helm release name for ArgoCD"
  type        = string
  default     = "argocd"
}

variable "argocd_repository" {
  description = "Helm repository URL for ArgoCD"
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
}

variable "argocd_chart" {
  description = "Helm chart name for ArgoCD"
  type        = string
  default     = "argo-cd"
}

variable "argocd_chart_version" {
  description = "Helm chart version for ArgoCD"
  type        = string
  default     = "5.51.6"
}

variable "argocd_namespace" {
  description = "Kubernetes namespace for ArgoCD"
  type        = string
  default     = "argocd"
}

variable "argocd_create_namespace" {
  description = "Create namespace for ArgoCD if it doesn't exist"
  type        = bool
  default     = true
}

variable "argocd_server_service_type" {
  description = "Service type for ArgoCD server (ClusterIP, LoadBalancer, NodePort)"
  type        = string
  default     = "ClusterIP"
}

variable "argocd_server_insecure" {
  description = "Run ArgoCD server in insecure mode (disable TLS)"
  type        = bool
  default     = true
}

variable "argocd_ingress_enabled" {
  description = "Enable Ingress for ArgoCD server"
  type        = bool
  default     = true
}

variable "argocd_ingress_class" {
  description = "Ingress class name for ArgoCD"
  type        = string
  default     = "nginx"
}

variable "argocd_ingress_host" {
  description = "Hostname for ArgoCD Ingress"
  type        = string
  default     = "argocd.example.com"
}

variable "argocd_controller_replicas" {
  description = "Number of ArgoCD Application Controller replicas"
  type        = number
  default     = 1
}

variable "argocd_repo_server_replicas" {
  description = "Number of ArgoCD Repo Server replicas"
  type        = number
  default     = 1
}

variable "argocd_applicationset_replicas" {
  description = "Number of ArgoCD ApplicationSet Controller replicas"
  type        = number
  default     = 1
}

variable "argocd_notifications_enabled" {
  description = "Enable ArgoCD Notifications Controller"
  type        = bool
  default     = true
}

variable "argocd_dex_enabled" {
  description = "Enable Dex for ArgoCD authentication"
  type        = bool
  default     = false
}

# =============================================================================
# KEDA (Kubernetes Event-Driven Autoscaling) Variables
# =============================================================================

variable "keda_enabled" {
  description = "Enable KEDA installation for event-driven pod autoscaling"
  type        = bool
  default     = true
}

variable "keda_release_name" {
  description = "Helm release name for KEDA"
  type        = string
  default     = "keda"
}

variable "keda_repository" {
  description = "Helm repository URL for KEDA"
  type        = string
  default     = "https://kedacore.github.io/charts"
}

variable "keda_chart" {
  description = "Helm chart name for KEDA"
  type        = string
  default     = "keda"
}

variable "keda_chart_version" {
  description = "Helm chart version for KEDA"
  type        = string
  default     = "2.13.1"
}

variable "keda_namespace" {
  description = "Kubernetes namespace for KEDA"
  type        = string
  default     = "keda"
}

variable "keda_create_namespace" {
  description = "Create namespace for KEDA if it doesn't exist"
  type        = bool
  default     = true
}

variable "keda_operator_replicas" {
  description = "Number of KEDA operator replicas"
  type        = number
  default     = 1
}

variable "keda_metrics_server_replicas" {
  description = "Number of KEDA metrics server replicas"
  type        = number
  default     = 1
}

variable "keda_log_level" {
  description = "Log level for KEDA operator (debug, info, error)"
  type        = string
  default     = "info"
}
