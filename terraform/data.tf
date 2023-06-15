data "azurerm_client_config" "current" {}

data "azurerm_resources" "existing_vms" {
  # for_each = toset(local.check_for)
  depends_on = [
    module.linux-vms,
    module.windows-vms
  ]
  type = "Microsoft.Compute/virtualMachines" #each.value
}

data "azurerm_resources" "existing_vmss" {
  depends_on = [
    module.linux-vms,
    module.windows-vms
  ]
  type = "Microsoft.Compute/virtualMachineScaleSets"
}

data "azurerm_resource_group" "existing_rg" {
  name = var.rg
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = var.vnet
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

data "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = data.azurerm_virtual_network.existing_vnet.resource_group_name
}