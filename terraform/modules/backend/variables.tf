variable "backend_name" {
  type    = string
  default = "backend"
}

variable "vm_size" {
  type = string
}

variable "backend_admin" {
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

variable "public_key_backend" {
  type = string
}

variable "password_authentication" {
    type = string
}