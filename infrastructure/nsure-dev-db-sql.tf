## nsure-dev-db-sql
resource "azurerm_mssql_database" "nsure-dev-db-sql"{
  name = "nsure-dev-db-sql-test-test"
  server_id = azurerm_mssql_server.nsure-dev-db-sql-server.id 
  sku_name = "S0"
}