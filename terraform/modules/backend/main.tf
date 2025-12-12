resource "azurerm_linux_virtual_machine" "backend" {
  name                  = var.backend_name
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.backend_network_interface.id]
  admin_username = var.backend_admin
  size                  = var.vm_size
disable_password_authentication = var.password_authentication

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }
  admin_ssh_key {
    username   = var.backend_admin
    public_key = var.public_key_backend
  }
}
