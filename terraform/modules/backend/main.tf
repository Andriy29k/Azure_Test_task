resource "azurerm_linux_virtual_machine" "backend" {
  name                            = var.backend_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  network_interface_ids           = [var.network_interface_id]
  admin_username                  = var.backend_admin
  size                            = var.vm_size
  disable_password_authentication = var.password_authentication
  zone                            = var.backend_zone

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
    username   = var.backend_admin
    public_key = file(var.public_key_backend)
  }
}
