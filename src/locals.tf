locals {
  location    = "East US 2"
  common_name = "laff-bas" #"use2-laff-dev-vnet"
  common_tags = {
    owner     = "Pat Lafferty"
    managedBy = "Terraform"
  }

  existing_vms = data.azurerm_resources.existing_vms.resources
  vm_count     = len(local.existing_vms)
}