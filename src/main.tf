resource "azurerm_public_ip" "this" {
  name                = format("%s-%s", local.common_name, "pip")
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "this" {
  name                = format("%s-%s", local.common_name, "bas")
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  sku                 = "Basic"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.existing_subnet.id
    public_ip_address_id = azurerm_public_ip.this.id
  }
}

module "windows-vms" {
  source = "modules/windows-vms"
  
}