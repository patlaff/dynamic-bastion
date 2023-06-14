data "azurerm_client_config" "current" {}

data "azurerm_resources" "existing_vms" {
  depends_on = [

  ]
  type = "Microsoft.Compute"
}

data "azurerm_resource_group" "existing_rg" {
  name = var.rg
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = var.vnet
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

data "azurerm_subnet" "existing_subnet" {
  name = var.subnet
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name = data.azurerm_virtual_network.existing_vnet.resource_group_name
}