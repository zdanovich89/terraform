## nsure-dev-db-sql-server
resource "azurerm_mssql_server" "nsure-dev-db-sql-server" {
  name = var.nsure-dev-db-sql-server-name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  version                      = "12.0"
  administrator_login = var.nsure-dev-db-sql-server-login 
  administrator_login_password = var.nsure-dev-db-sql-server-password 
}

resource "azurerm_mssql_firewall_rule" "clientipaddress" {
  name             = "ClientIPAddress_2021-5-21_15-14-23"
  server_id        = azurerm_mssql_server.nsure-dev-db-sql-server.id 
  start_ip_address = "89.77.64.248"
  end_ip_address   = "89.77.64.248"
}

resource "azurerm_mssql_firewall_rule" "grbrel" {
  name             = "grbrel"
  server_id        = azurerm_mssql_server.nsure-dev-db-sql-server.id 
  start_ip_address = "89.77.204.231"
  end_ip_address   = "89.77.204.231"
}
