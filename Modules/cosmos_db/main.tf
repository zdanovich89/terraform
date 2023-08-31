resource "azurerm_cosmosdb_account" "cosmos_db" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  offer_type          = var.offer_type

}
