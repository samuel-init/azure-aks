locals {
  env = basename(dirname(get_terragrunt_dir()))
  managed_by  = "Terragrunt"
  region      = "eastus"
  project = "AKS-Default-Network"
}

# Configure remote state in Azure Storage
# remote_state {
#   backend = "azurerm"
#   config = {
#     resource_group_name  = "tfstate-rg"
#     storage_account_name = "tfstatesamuel"
#     container_name       = "tfstate"
#     key                  = "${path_relative_to_include()}/terraform.tfstate"
#   }
#   generate = {
#     path      = "backend.tf"
#     if_exists = "overwrite_terragrunt"
#   }
# }

inputs = {
  location = local.region
  tags = {
    ManagedBy = local.managed_by
    Project   = local.project
  }
}
