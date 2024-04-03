terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.97.1"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-dev-westeurope"
    storage_account_name = "stsdevwesteurope"
    container_name       = "data"
    key                  = "dev.terraform.tfstate"
  }
}