variable "APP_ID" {
  type = string
}

variable "AZ_PASSWORD" {
  type = string
}

variable "TENANT_ID" {
  type = string
}

variable "SUBSCRIPTION_ID" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "resource_group_name" {
  type    = string
  default = "test_task_rg"
}

variable "backend_name" {
  type = string
}

variable "database_name" {
  type = string
}

variable "backend_admin" {
  type = string
}

variable "database_admin" {
  type = string
}

variable "password_authentication" {
  type = string
}

variable "network_name" {
  type = string
}

variable "network_subnet_name" {
  type = string
}

variable "public_key_database" {
  type = string
}

variable "public_key_backend" {
  type = string
}

variable "publisher" {
  type = string
}

variable "offer" {
  type = string
}

variable "sku" {
  type = string
}

variable "storage_account_type" {
  type = string
}

variable "backend_zone" {
  type = string
}

variable "database_zone" {
  type = string
}

variable "ssh_config_path" {
    type = string
    default = "~/.ssh/config"
}
