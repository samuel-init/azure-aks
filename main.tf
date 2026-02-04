module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# Azure Container Registry for storing application images
module "acr" {
  source = "./modules/acr"
  count  = var.acr_enabled ? 1 : 0

  acr_name                   = var.acr_name
  resource_group_name        = module.resource_group.name
  location                   = module.resource_group.location
  sku                        = var.acr_sku
  admin_enabled              = var.acr_admin_enabled
  enable_diagnostics         = var.acr_enable_diagnostics
  log_analytics_workspace_id = var.acr_enable_diagnostics ? module.aks.log_analytics_workspace_id : null

  tags = var.tags
}

# Grant AKS cluster pull access to ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  count = var.acr_enabled ? 1 : 0

  principal_id                     = module.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = module.acr[0].acr_id
  skip_service_principal_aad_check = true
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

  # depends_on = [module.resource_group]
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

  depends_on = [
    module.aks,
    # module.resource_group
  ]
}

# ArgoCD for GitOps continuous delivery
module "argocd" {
  source = "./modules/helm_release"
  count  = var.argocd_enabled ? 1 : 0

  release_name     = var.argocd_release_name
  repository       = var.argocd_repository
  chart            = var.argocd_chart
  chart_version    = var.argocd_chart_version
  namespace        = var.argocd_namespace
  create_namespace = var.argocd_create_namespace
  timeout          = 600

  set_values = merge(
    {
      "server.service.type"                       = var.argocd_server_service_type
      "configs.params.server\\.insecure"          = tostring(var.argocd_server_insecure)
      "server.ingress.enabled"                    = tostring(var.argocd_ingress_enabled)
      "server.ingress.ingressClassName"           = var.argocd_ingress_class
      "controller.replicas"                       = tostring(var.argocd_controller_replicas)
      "repoServer.replicas"                       = tostring(var.argocd_repo_server_replicas)
      "applicationSet.enabled"                    = "true"
      "applicationSet.replicas"                   = tostring(var.argocd_applicationset_replicas)
      "notifications.enabled"                     = tostring(var.argocd_notifications_enabled)
      "dex.enabled"                               = tostring(var.argocd_dex_enabled)
      "configs.cm.timeout\\.reconciliation"       = "180s"
      "configs.cm.application\\.instanceLabelKey" = "argocd.argoproj.io/instance"
      "server.extraArgs[0]"                       = "--insecure"

      "configs.cm.resource\\.exclusions"                                          = <<-EOT
        - apiGroups:
            - "*"
          kinds:
            - "Endpoints"
          clusters:
            - "*"
      EOT
      "configs.cm.resource\\.customizations\\.health\\.argoproj\\.io_Application" = <<-EOT
        hs = {}
        hs.status = "Progressing"
        hs.message = ""
        if obj.status ~= nil then
          if obj.status.health ~= nil then
            hs.status = obj.status.health.status
            if obj.status.health.message ~= nil then
              hs.message = obj.status.health.message
            end
          end
        end
        return hs
      EOT
    },
    var.argocd_ingress_enabled ? {
      "server.ingress.hosts[0]" = var.argocd_ingress_host
    } : {}
  )

  depends_on = [
    module.aks,
    module.nginx_ingress
  ]
}

# KEDA for event-driven pod autoscaling
module "keda" {
  source = "./modules/helm_release"
  count  = var.keda_enabled ? 1 : 0

  release_name     = var.keda_release_name
  repository       = var.keda_repository
  chart            = var.keda_chart
  chart_version    = var.keda_chart_version
  namespace        = var.keda_namespace
  create_namespace = var.keda_create_namespace
  timeout          = 300

  set_values = {
    "operator.replicaCount"              = tostring(var.keda_operator_replicas)
    "metricsServer.replicaCount"         = tostring(var.keda_metrics_server_replicas)
    "logging.operator.level"             = var.keda_log_level
    "prometheus.operator.enabled"        = "true"
    "prometheus.metricServer.enabled"    = "true"
    "resources.operator.requests.cpu"    = "100m"
    "resources.operator.requests.memory" = "128Mi"
    "resources.operator.limits.cpu"      = "500m"
    "resources.operator.limits.memory"   = "256Mi"
    "podIdentity.azureWorkload.enabled"  = "false"
  }

  depends_on = [
    module.aks
  ]
}
