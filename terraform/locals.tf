locals {
  common_name = "laff-bas" #"use2-laff-dev-vnet"
  common_tags = {
    owner     = "Pat Lafferty"
    managedBy = "Terraform"
  }

  existing_vms = data.azurerm_resources.existing_vms.resources
  vm_count     = length(local.existing_vms)
}