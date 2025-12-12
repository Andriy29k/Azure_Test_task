resource "azurerm_linux_virtual_machine" "database" {
  name                            = var.database_name
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  network_interface_ids           = [azurerm_network_interface.database_network_interface.id]
  
  size                            = var.vm_size
  admin_username                  = var.database_admin
  disable_password_authentication = var.password_authentication

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = vae.version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  admin_ssh_key {
    username   = var.database_admin
    public_key = var.public_key_database
  }
}
