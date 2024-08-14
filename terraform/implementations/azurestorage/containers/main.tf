resource "azurerm_storage_container" "container1" {
  name                  = "container1"
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}


resource "azurerm_storage_container" "container2" {
  name                  = "container2"
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}
