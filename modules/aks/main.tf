resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = var.default_node_pool_name
    vm_size             = var.default_node_pool_vm_size
    node_count          = var.enable_auto_scaling ? null : var.default_node_pool_node_count
    min_count           = var.enable_auto_scaling ? var.default_node_pool_min_count : null
    max_count           = var.enable_auto_scaling ? var.default_node_pool_max_count : null
    enable_auto_scaling = var.enable_auto_scaling

    type                         = "VirtualMachineScaleSets"
    only_critical_addons_enabled = false

    tags = var.tags
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = var.network_plugin
    network_policy    = var.network_policy
    load_balancer_sku = var.load_balancer_sku
    outbound_type     = "loadBalancer"

    service_cidr       = var.network_plugin == "azure" ? "10.0.0.0/16" : null
    dns_service_ip     = var.network_plugin == "azure" ? "10.0.0.10" : null
  }

  sku_tier = "Free"

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count,
      kubernetes_version,
    ]
  }
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "${var.cluster_name}-logs"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}

resource "azurerm_log_analytics_solution" "this" {
  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.this.id
  workspace_name        = azurerm_log_analytics_workspace.this.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }

  tags = var.tags
}
