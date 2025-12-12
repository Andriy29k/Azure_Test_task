provider "azurerm" {
  client_id     = var.APP_ID
  client_secret = var.AZ_PASSWORD
  tenant_id     = var.TENANT_ID
}

module "vpc" {
  source              = "./modules/vpc"
  network_name        = var.network_name
  network_subnet_name = var.network_subnet_name
}

module "resource_group_name" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "backend" {
  source                  = "./modules/backend"
  backend_name            = var.backend_name
  vm_size                 = var.vm_size
  backend_admin           = var.backend_admin
  public_key_backend      = var.public_key_backend
  password_authentication = var.password_authentication
  publisher               = var.publisher
  offer                   = var.offer
  sku                     = var.offer
  version                 = var.version
  storage_account_type    = var.storage_account_type


}

module "database" {
  source                  = "./modules/database"
  database_name           = var.database_name
  vm_size                 = var.vm_size
  database_admin          = var.database_admin
  password_authentication = var.password_authentication
  public_key_database     = var.public_key_database
  publisher               = var.publisher
  offer                   = var.offer
  sku                     = var.sku
  version                 = var.version
  storage_account_type    = var.storage_account_type

}
