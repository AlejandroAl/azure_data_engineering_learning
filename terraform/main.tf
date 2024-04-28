locals {
  employee_table_entities = {
    "001" = {
      "row_key"       = "001"
      "partition_key" = "Department1"
      "name"          = "Jonh Doe"
      "salary"        = 50000
      "date_joined"   = "2023-01-15"
    }

    "002" = {
      "row_key"       = "002"
      "partition_key" = "Department2"
      "name"          = "Jane Smith"
      "salary"        = 60000
      "date_joined"   = "2022-08-20"
    }

    "003" = {
      "row_key"       = "003"
      "partition_key" = "Department3"
      "name"          = "Alex Lee"
      "salary"        = 55000
      "date_joined"   = "2023-03-05"
    }
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


module "storageaccont" {
  source = "./components/storages_accounts"
}

module "storageaccounttable" {
  source               = "./components/storageaccount_table"
  table_name           = "Employee"
  storage_account_name = module.storageaccont.storage_account_name
}

module "employeeEntities" {
  source = "./components/azure_table_entities/employees"

  storage_table_id = module.storageaccounttable.azstoragetableid
  initial_entities = local.employee_table_entities

}
