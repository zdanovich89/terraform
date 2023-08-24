resource "azurerm_mssql_database" "dev-nsure-backoffice-sql-database"{
  name = var.dev-nsure-backoffice-sql-database-name
  server_id = azurerm_mssql_server.dev-nsure-backoffice-sql-server.id
  sku_name = "S0"
}