# Production Environment Configuration
# This file contains production-specific values for the AKS infrastructure

resource_group_name = "rg-aks-prod"
location            = "eastus"

tags = {
  Environment = "Production"
  Project     = "AKS-Default-Network"
  ManagedBy   = "Terraform"
  CostCenter  = "Platform"
}

# AKS Cluster Configuration
cluster_name       = "aks-prod-cluster"
dns_prefix         = "aksprod"
kubernetes_version = null # Uses latest stable version

# Node Pool Configuration - Production sizing
default_node_pool_name       = "system"
default_node_pool_vm_size    = "Standard_D4s_v3" # Larger VMs for production
default_node_pool_node_count = 3                 # Higher initial count
default_node_pool_min_count  = 3                 # Minimum 3 nodes for HA
default_node_pool_max_count  = 10                # Allow scaling to 10 nodes
enable_auto_scaling          = true

# Network Configuration
network_plugin    = "azure"
network_policy    = "azure"
load_balancer_sku = "standard"

# NGINX Ingress Controller
nginx_ingress_enabled          = true
nginx_ingress_release_name     = "ingress-nginx"
nginx_ingress_repository       = "https://kubernetes.github.io/ingress-nginx"
nginx_ingress_chart            = "ingress-nginx"
nginx_ingress_chart_version    = "4.9.0"
nginx_ingress_namespace        = "ingress-nginx"
nginx_ingress_create_namespace = true
nginx_ingress_replica_count    = 3 # Higher replica count for production

# Azure Container Registry
acr_enabled            = true
acr_name               = "acraksproduction" # Must be globally unique
acr_sku                = "Premium"          # Premium for geo-replication, enhanced security
acr_admin_enabled      = false
acr_enable_diagnostics = true

# ArgoCD Configuration
argocd_enabled                 = true
argocd_release_name            = "argocd"
argocd_chart_version           = "5.51.6"
argocd_namespace               = "argocd"
argocd_server_service_type     = "ClusterIP"
argocd_server_insecure         = true
argocd_ingress_enabled         = true
argocd_ingress_class           = "nginx"
argocd_ingress_host            = "argocd.prod.example.com"
argocd_controller_replicas     = 2 # HA for production
argocd_repo_server_replicas    = 2 # HA for production
argocd_applicationset_replicas = 2 # HA for production
argocd_notifications_enabled   = true
argocd_dex_enabled             = false

# KEDA Configuration - Production HA
keda_enabled                 = true
keda_release_name            = "keda"
keda_chart_version           = "2.13.1"
keda_namespace               = "keda"
keda_operator_replicas       = 2 # HA for production
keda_metrics_server_replicas = 2 # HA for production
keda_log_level               = "info"
