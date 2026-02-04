# ACR Module Variables

variable "acr_name" {
  description = "The name of the Azure Container Registry. Must be globally unique."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{5,50}$", var.acr_name))
    error_message = "ACR name must be alphanumeric, between 5 and 50 characters."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the ACR."
  type        = string
}

variable "location" {
  description = "The Azure region where the ACR will be created."
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Registry. Possible values are Basic, Standard, and Premium."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "SKU must be one of: Basic, Standard, Premium."
  }
}

variable "admin_enabled" {
  description = "Whether the admin user is enabled for the ACR."
  type        = bool
  default     = false
}

variable "georeplications" {
  description = "List of geo-replication configurations (Premium SKU only)."
  type = list(object({
    location                = string
    zone_redundancy_enabled = optional(bool, false)
    tags                    = optional(map(string), {})
  }))
  default = []
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostic settings."
  type        = string
  default     = null
}

variable "enable_diagnostics" {
  description = "Whether to enable diagnostic settings for ACR."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
