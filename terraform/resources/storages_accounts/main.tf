resource "azurerm_resource_group" "this" {
  name     = "rg-${var.ENV}-${var.LOCATION}"
  location = var.LOCATION

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    region = var.REGION
    env    = var.ENV
  }
}

resource "azurerm_storage_account" "this" {
  depends_on = [
  azurerm_resource_group.this]

  name                     = "sts${var.ENV}${var.LOCATION}"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = var.STORAGE_ACCOUNT_REPLICATION_TYPE
  is_hns_enabled           = "true"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    region = var.REGION
    env    = var.ENV
  }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "gen2_data" {
  depends_on = [
  azurerm_storage_account.this]

  name               = "data"
  storage_account_id = azurerm_storage_account.this.id

  lifecycle {
    prevent_destroy = true
  }
}
