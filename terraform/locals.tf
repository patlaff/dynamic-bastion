locals {
  common_name = "laff-bas" #"use2-laff-dev-vnet"
  common_tags = {
    owner     = "Pat Lafferty"
    managedBy = "Terraform"
  }

  check_for = [
    "Microsoft.Compute/virtualMachines",
    "Microsoft.Compute/virtualMachineScaleSets"
  ]

  existing_vms  = data.azurerm_resources.existing_vms.resources
  existing_vmss = data.azurerm_resources.existing_vmss.resources
  vm_count      = length(local.existing_vms) + length(local.existing_vmss)
}