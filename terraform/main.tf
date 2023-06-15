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
    subnet_id            = data.azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.this[0].id
  }
}

# resource "azurerm_key_vault" "this" {
#   count                       = local.vm_count > 0 ? 1 : 0
#   name                        = format("%s-%s", local.common_name, "kv")
#   location                    = data.azurerm_resource_group.existing_rg.location
#   resource_group_name         = data.azurerm_resource_group.existing_rg.name
#   enabled_for_disk_encryption = true
#   tenant_id                   = data.azurerm_client_config.current.tenant_id
#   soft_delete_retention_days  = 7
#   purge_protection_enabled    = false
#   sku_name                    = "standard"
#   enable_rbac_authorization   = true
# }

# resource "azurerm_role_assignment" "TF_KV" {
#   count                = local.vm_count > 0 ? 1 : 0
#   scope                = azurerm_key_vault.this.id
#   role_definition_name = "Key Vault Secrets Officer"
#   principal_id         = data.azurerm_client_config.current.principal_id
# }

module "windows-vms" {
  for_each            = var.windows_vms
  source              = "./modules/windows-vm"
  vm_name             = each.key
  vm_size             = each.value.vm_size
  disk_size_gb        = each.value.disk_size_gb
  subnet_name         = each.value.subnet_name
  vnet_name           = data.azurerm_virtual_network.existing_vnet.name
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  common_name         = local.common_name
  common_tags         = local.common_tags
}

module "linux-vms" {
  for_each            = var.linux_vms
  source              = "./modules/linux-vm"
  vm_name             = each.key
  vm_size             = each.value.vm_size
  disk_size_gb        = each.value.disk_size_gb
  subnet_name         = each.value.subnet_name
  vnet_name           = data.azurerm_virtual_network.existing_vnet.name
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  common_name         = local.common_name
  common_tags         = local.common_tags
}