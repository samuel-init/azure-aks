include "root" {
  path = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../"
}

inputs = {
  resource_group_name = "rg-aks-dev"
#   location            = "eastus"

  cluster_name       = "aks-dev-cluster"
  dns_prefix         = "aksdev"
  kubernetes_version = null

  default_node_pool_name       = "default"
  default_node_pool_vm_size    = "Standard_DS2_v2"
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

  tags = {
    Environment = "Development"
    # Project     = "AKS-Default-Network"
    # ManagedBy   = "Terragrunt"
  }
}
