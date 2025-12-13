module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "vpc" {
  source              = "./modules/vpc"
  network_name        = var.network_name
  network_subnet_name = var.network_subnet_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  depends_on          = [module.resource_group]
}

module "backend" {
  source                  = "./modules/backend"
  backend_name            = var.backend_name
  vm_size                 = var.vm_size
  backend_zone            = var.backend_zone
  backend_admin           = var.backend_admin
  public_key_backend      = var.public_key_backend
  password_authentication = var.password_authentication
  publisher               = var.publisher
  offer                   = var.offer
  sku                     = var.sku
  storage_account_type    = var.storage_account_type
  resource_group_name     = module.resource_group.resource_group_name
  location                = module.resource_group.location
  network_interface_id    = module.vpc.backend_interface_ids
  depends_on              = [module.vpc]


}

module "database" {
  source                  = "./modules/database"
  database_name           = var.database_name
  vm_size                 = var.vm_size
  database_zone           = var.database_zone
  database_admin          = var.database_admin
  password_authentication = var.password_authentication
  public_key_database     = var.public_key_database
  publisher               = var.publisher
  offer                   = var.offer
  sku                     = var.sku
  storage_account_type    = var.storage_account_type
  resource_group_name     = module.resource_group.resource_group_name
  location                = module.resource_group.location
  network_interface_id    = module.vpc.database_interface_ids
  depends_on              = [module.vpc]
}
