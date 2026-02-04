# Terragrunt configuration for Production environment

include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../"
}

inputs = {
  resource_group_name = "rg-aks-prod"

  cluster_name       = "aks-prod-cluster"
  dns_prefix         = "aksprod"
  kubernetes_version = null

  # Production node pool - larger and more nodes
  default_node_pool_name       = "system"
  default_node_pool_vm_size    = "Standard_D4s_v3"
  default_node_pool_node_count = 3
  default_node_pool_min_count  = 3
  default_node_pool_max_count  = 10
  enable_auto_scaling          = true

  network_plugin    = "azure"
  network_policy    = "azure"
  load_balancer_sku = "standard"

  # NGINX Ingress with higher replica count for production
  nginx_ingress_enabled          = true
  nginx_ingress_release_name     = "ingress-nginx"
  nginx_ingress_repository       = "https://kubernetes.github.io/ingress-nginx"
  nginx_ingress_chart            = "ingress-nginx"
  nginx_ingress_chart_version    = "4.9.0"
  nginx_ingress_namespace        = "ingress-nginx"
  nginx_ingress_create_namespace = true
  nginx_ingress_replica_count    = 3

  # Azure Container Registry - Premium for production
  acr_enabled            = true
  acr_name               = "acraksproduction"
  acr_sku                = "Premium"
  acr_admin_enabled      = false
  acr_enable_diagnostics = true

  # ArgoCD with HA configuration
  argocd_enabled                 = true
  argocd_release_name            = "argocd"
  argocd_chart_version           = "5.51.6"
  argocd_namespace               = "argocd"
  argocd_server_service_type     = "ClusterIP"
  argocd_server_insecure         = true
  argocd_ingress_enabled         = true
  argocd_ingress_class           = "nginx"
  argocd_ingress_host            = "argocd.prod.example.com"
  argocd_controller_replicas     = 2
  argocd_repo_server_replicas    = 2
  argocd_applicationset_replicas = 2
  argocd_notifications_enabled   = true
  argocd_dex_enabled             = false

  tags = {
    Environment = "Production"
    CostCenter  = "Platform"
  }
}
