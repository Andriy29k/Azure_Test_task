output "backend_admin" {
  value = module.backend.backend_admin
}

output "backend_key" {
  value = module.backend.public_key_backend
}

output "database_admin" {
  value = module.database.database_admin
}

output "database_key" {
  value = module.database.public_key_database
}

output "backend_public_ip" {
  value = module.backend.backend_public_ip
}

output "database_public_ip" {
  value = module.database.database_public_ip
}

