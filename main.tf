module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "aks" {
  source = "./modules/aks"

  cluster_name        = var.cluster_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool_name       = var.default_node_pool_name
  default_node_pool_vm_size    = var.default_node_pool_vm_size
  default_node_pool_node_count = var.default_node_pool_node_count
  default_node_pool_min_count  = var.default_node_pool_min_count
  default_node_pool_max_count  = var.default_node_pool_max_count
  enable_auto_scaling          = var.enable_auto_scaling

  network_plugin    = var.network_plugin
  network_policy    = var.network_policy
  load_balancer_sku = var.load_balancer_sku

  tags = var.tags

  depends_on = [module.resource_group]
}

module "nginx_ingress" {
  source = "./modules/helm_release"
  count  = var.nginx_ingress_enabled ? 1 : 0

  release_name     = var.nginx_ingress_release_name
  repository       = var.nginx_ingress_repository
  chart            = var.nginx_ingress_chart
  chart_version    = var.nginx_ingress_chart_version
  namespace        = var.nginx_ingress_namespace
  create_namespace = var.nginx_ingress_create_namespace

  set_values = {
    "controller.replicaCount"                                                                                       = tostring(var.nginx_ingress_replica_count)
    "controller.service.type"                                                                                       = "LoadBalancer"
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path" = "/healthz"
    "controller.admissionWebhooks.enabled"                                                                          = "true"
    "controller.metrics.enabled"                                                                                    = "true"
  }

  depends_on = [module.aks]
}
