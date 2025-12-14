locals {
  ssh_config_content = <<-EOT
    # Backend
    Host backend
        HostName ${var.backend_hostname}
        User ${var.backend_admin}
        IdentityFile ${var.public_key_backend}
        ForwardAgent yes
        StrictHostKeyChecking no
    
    # Database
    Host database
        HostName ${var.database_hostname}
        User ${var.database_admin}
        IdentityFile ${var.public_key_database}
        ForwardAgent yes
        StrictHostKeyChecking no
    EOT



}

resource "local_file" "ssh_config" {
    content  = local.ssh_config_content
    filename = pathexpand(var.ssh_config_path)
}