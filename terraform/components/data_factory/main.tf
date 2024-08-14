resource "azurerm_data_factory" "this" {
  name                = local.adf_name
  location            = var.LOCATION
  resource_group_name = var.RESOURCE_GROUP_NAME
}

output "adfid" {
  value = azurerm_data_factory.this.id
}