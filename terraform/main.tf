terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-dev-westeurope"
    storage_account_name = "stsdevwesteurope"
    container_name       = "data"
    key                  = "dev.terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
}

variable "region" {
  type    = string
  default = "westeurope"
}

data "azurerm_client_config" "current" {
}

data "external" "me" {
  program = ["az", "account", "show", "--query", "user"]
}

locals {
  prefix = "db-dev-westeurope"
  tags = {
    Environment = "dev"
    Owner       = lookup(data.external.me.result, "name")
  }
}


data "azurerm_resource_group" "this" {
  name = "rg-dev-westeurope"
}

resource "azurerm_databricks_workspace" "this" {
  name                        = "${local.prefix}-workspace"
  resource_group_name         = data.azurerm_resource_group.this.name
  location                    = data.azurerm_resource_group.this.location
  sku                         = "standard"
  managed_resource_group_name = "${local.prefix}-workspace-rg"
  tags                        = local.tags
}

output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.this.workspace_url}/"
}
