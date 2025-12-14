output "backend_admin" {
  value = var.backend_admin
}

output "backend_key" {
  value = var.public_key_backend
}

output "database_admin" {
  value = var.database_admin
}

output "database_key" {
  value = var.public_key_database
}

output "database_public_ip" {
  value = module.vpc.database_public_ip
}

output "backend_public_ip" {
  value = module.vpc.backend_public_ip
}

