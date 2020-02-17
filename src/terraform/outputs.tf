
output "resource_group_name" {
  value = azurerm_resource_group.CharlaResourceGroup.name
}

output "database_server_name" {
  value = azurerm_sql_server.DatabaseServerPasionPorLosBits.name
}

output "sql_database_name" {
  value = azurerm_sql_database.DatabaseInstancePasionPorLosBits.name
}

output "web_name" {
  value = azurerm_app_service.pasionporlosbits_webapp.name
}
