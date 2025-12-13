resource "azurerm_linux_virtual_machine" "database" {
  name                            = var.database_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  network_interface_ids           = [var.network_interface_id]
  zone                            = var.database_zone
  size                            = var.vm_size
  admin_username                  = var.database_admin
  disable_password_authentication = var.password_authentication

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  admin_ssh_key {
    username   = var.database_admin
    public_key = file(var.public_key_database)
  }
}
