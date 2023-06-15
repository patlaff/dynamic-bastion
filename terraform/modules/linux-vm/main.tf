resource "azurerm_network_interface" "this" {
  name                = format("%s-nic", var.vm_name)
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = format("%s-ip", var.vm_name)
    subnet_id                     = data.azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.common_tags
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "azurerm_key_vault_secret" "this" {
  name         = format("%s-key", var.vm_name)
  value        = tls_private_key.ssh.public_key_openssh
  key_vault_id = var.key_vault.id
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_ssh_key {
    username = var.admin_username
    public_key = azurerm_key_vault_secret.this.value
  } 

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.disk_size_gb
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  tags = var.common_tags
}