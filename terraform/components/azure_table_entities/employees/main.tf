resource "azurerm_storage_table_entity" "this" {

  storage_table_id = var.storage_table_id

  for_each = var.initial_entities

  partition_key = each.value.partition_key
  row_key       = each.value.row_key

  entity = {
    name        = each.value.name
    salary      = each.value.salary
    date_joined = each.value.date_joined
  }

}

