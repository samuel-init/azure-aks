variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region for the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
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
  description = "Enable autoscaling for the default node pool"
  type        = bool
  default     = true
}

variable "network_plugin" {
  description = "Network plugin to use (azure or kubenet)"
  type        = string
  default     = "azure"

  validation {
    condition     = contains(["azure", "kubenet"], var.network_plugin)
    error_message = "Network plugin must be either 'azure' or 'kubenet'."
  }
}

variable "network_policy" {
  description = "Network policy to use (azure, calico, or null)"
  type        = string
  default     = "azure"

  validation {
    condition     = var.network_policy == null || contains(["azure", "calico"], var.network_policy)
    error_message = "Network policy must be 'azure', 'calico', or null."
  }
}

variable "load_balancer_sku" {
  description = "SKU for the load balancer (basic or standard)"
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["basic", "standard"], var.load_balancer_sku)
    error_message = "Load balancer SKU must be either 'basic' or 'standard'."
  }
}

variable "tags" {
  description = "Tags to apply to AKS resources"
  type        = map(string)
  default     = {}
}
