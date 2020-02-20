#Database

resource "azurerm_sql_server" "DatabaseServerPasionPorLosBits" {
  name                         = "pasionporlosbitsdbserver"
  resource_group_name          = azurerm_resource_group.CharlaResourceGroup.name
  location                     = local.location
  version                      = "12.0"
  administrator_login          = "mradministrator"
  administrator_login_password = "thisIsDog11"

  tags = local.database_server_tags
}

resource "azurerm_sql_database" "DatabaseInstancePasionPorLosBits" {
  name                = "pasionporlosbitsdatabase"
  resource_group_name = azurerm_resource_group.CharlaResourceGroup.name
  location            = local.location
  server_name         = azurerm_sql_server.DatabaseServerPasionPorLosBits.name
  edition             = var.sqlserver_edition

  tags = local.database_server_tags

  threat_detection_policy {
    state = "Enabled"
    retention_days = 7
    storage_endpoint = "https://devopsdaysmad2.blob.core.windows.net"
    storage_account_access_key  = "SacwxeQibrYxsCUems/6tBSJHMDM6nnu/0Rchzlmd6xU9ju89vIXx3G8j67Ko4QUwMH/ezaYCkB4omQkya4ZKA=="
  }
}