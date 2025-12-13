terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  client_id       = var.APP_ID
  client_secret   = var.AZ_PASSWORD
  tenant_id       = var.TENANT_ID
  subscription_id = var.SUBSCRIPTION_ID
  features {

  }
}
