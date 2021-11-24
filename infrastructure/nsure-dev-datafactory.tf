resource "azurerm_data_factory" "nsure-dev-datafactory" {
  name                = var.nsure-dev-datafactory_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}