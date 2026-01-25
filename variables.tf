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

