variable "APP_ID" {
  default = APP_ID
}

variable "AZ_PASSWORD" {
  default = AZ_PASSWORD
}

variable "TENANT_ID" {
  default = TENANT_ID
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

variable "version" {
    type = string
}

variable "disk_size_gb" {
  type = number
}