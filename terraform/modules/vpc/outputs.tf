output "database_public_ip" {
  description = "Public Database ip:"
  value       = azurerm_public_ip.database_public_ip.ip_address
}

output "backend_public_ip" {
  description = "Public Database ip:"
  value       = azurerm_public_ip.backend_public_ip.ip_address
}

output "backend_interface_ids" {
  value = azurerm_network_interface.backend_network_interface.id
}

output "database_interface_ids" {
  value = azurerm_network_interface.database_network_interface.id
}