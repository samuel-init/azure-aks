variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-aks-default"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
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
  description = "Enable autoscaling for the default node pool"
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
