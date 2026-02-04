
subscription_id     = "c742872c-f727-4ef5-9ea1-8740f55b24ff"
resource_group_name = "rg-aks-default"
location            = "eastus"

tags = {
  Environment = "Development"
  Project     = "AKS-Default-Network"
  ManagedBy   = "Terraform"
}


# cluster_name       = "aks-default-cluster"
dns_prefix         = "aksdefault"
kubernetes_version = null


default_node_pool_name       = "default"
default_node_pool_vm_size    = "Standard_DC2ads_v5"
default_node_pool_node_count = 2
default_node_pool_min_count  = 1
default_node_pool_max_count  = 5
enable_auto_scaling          = true


network_plugin    = "azure"
network_policy    = "azure"
load_balancer_sku = "standard"


nginx_ingress_enabled          = true
nginx_ingress_release_name     = "ingress-nginx"
nginx_ingress_repository       = "https://kubernetes.github.io/ingress-nginx"
nginx_ingress_chart            = "ingress-nginx"
nginx_ingress_chart_version    = "4.9.0"
nginx_ingress_namespace        = "ingress-nginx"
nginx_ingress_create_namespace = true
nginx_ingress_replica_count    = 2

# Azure Container Registry
acr_enabled            = true
acr_name               = "acraksdev2026sam"
acr_sku                = "Standard"
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
argocd_ingress_host            = "argocd.dev.example.com"
argocd_controller_replicas     = 1
argocd_repo_server_replicas    = 1
argocd_applicationset_replicas = 1
argocd_notifications_enabled   = true
argocd_dex_enabled             = false

# KEDA Configuration
keda_enabled                 = true
keda_release_name            = "keda"
keda_chart_version           = "2.13.1"
keda_namespace               = "keda"
keda_operator_replicas       = 1
keda_metrics_server_replicas = 1
keda_log_level               = "info"
