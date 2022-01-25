resource "azurerm_mssql_server" "dev-nsure-backoffice-sql-server" {
  name = var.dev-nsure-backoffice-sql-server-name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  version                      = "12.0"
  administrator_login = var.dev-nsure-backoffice-sql-server-login
  administrator_login_password = var.dev-nsure-backoffice-sql-server-password
}

