resource "azurerm_network_interface" "this" {
  name                = format("%s-nic", var.vm_name)
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = format("%s-ip", var.vm_name)
    subnet_id                     = var.subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.common_tags
}

resource "azurerm_windows_virtual_machine" "this" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  tags = var.common_tags
}