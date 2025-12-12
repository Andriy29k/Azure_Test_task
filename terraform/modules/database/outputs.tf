output "database_public_ip" {
  description = "Public Database ip:"
  value       = azurerm_public_ip.database_public_ip.ip_address
}

output "ssh_to_db" {
  description = "Connection to databaseb via ssh:"
  value       = "ssh ${var.database_admin}@${azurerm_public_ip.database_public_ip.ip_address}"
}