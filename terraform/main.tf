resource "azurerm_public_ip" "this" {
  count               = local.vm_count > 0 ? 1 : 0
  name                = format("%s-%s", local.common_name, "pip")
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "this" {
  count               = local.vm_count > 0 ? 1 : 0
  name                = format("%s-%s", local.common_name, "bas")
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  sku                 = "Basic"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.existing_subnet.id
    public_ip_address_id = azurerm_public_ip.this[0].id
  }
}

module "windows-vms" {
  for_each            = var.vms.windows
  source              = "./modules/windows-vm"
  vm_name             = each.key
  vm_size             = each.value.vm_size
  # disk_size           = each.value.disk_size
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  subnet              = data.azurerm_subnet.existing_subnet
  common_name         = local.common_name
  common_tags         = local.common_tags
}

module "linux-vms" {
  for_each            = var.vms.windows
  source              = "./modules/linux-vm"
  vm_name             = each.key
  vm_size             = each.value.vm_size
  # disk_size           = each.value.disk_size
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  subnet              = data.azurerm_subnet.existing_subnet
  common_name         = local.common_name
  common_tags         = local.common_tags
}