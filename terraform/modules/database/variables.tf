variable "database_name" {
  type    = string
  default = "database"
}

variable "vm_size" {
  type = string
}

variable "database_admin" {
  type = string
}

variable "password_authentication" {
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

variable "public_key_database" {
    type = string
}
