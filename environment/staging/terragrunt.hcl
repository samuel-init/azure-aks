# Terragrunt configuration for Staging environment

include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../"
}

inputs = {
  resource_group_name = "rg-aks-staging"

  cluster_name       = "aks-staging-cluster"
  dns_prefix         = "aksstaging"
  kubernetes_version = null

  default_node_pool_name       = "default"
  default_node_pool_vm_size    = "Standard_D2s_v3"
  default_node_pool_node_count = 2
  default_node_pool_min_count  = 2
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
  acr_name               = "acrakssstaging"
  acr_sku                = "Standard"
  acr_admin_enabled      = false
  acr_enable_diagnostics = true

  # ArgoCD
  argocd_enabled                 = true
  argocd_release_name            = "argocd"
  argocd_chart_version           = "5.51.6"
  argocd_namespace               = "argocd"
  argocd_server_service_type     = "ClusterIP"
  argocd_server_insecure         = true
  argocd_ingress_enabled         = true
  argocd_ingress_class           = "nginx"
  argocd_ingress_host            = "argocd.staging.example.com"
  argocd_controller_replicas     = 1
  argocd_repo_server_replicas    = 1
  argocd_applicationset_replicas = 1
  argocd_notifications_enabled   = true
  argocd_dex_enabled             = false

  tags = {
    Environment = "Staging"
  }
}
