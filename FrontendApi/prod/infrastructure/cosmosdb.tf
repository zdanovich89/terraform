resource "azurerm_cosmosdb_account" "prod-nsure-frontend-cosmos-db" {
  name                = var.prod-nsure-frontend-cosmos-db-name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard" 
  kind                = "GlobalDocumentDB" 
  consistency_policy {
    consistency_level  = "Session" 
  }

  geo_location {
    location          = var.resource_group_location 
    failover_priority = 0 
  }
  tags = {
    "defaultExperience" = "DocumentDB"
  }
}



resource "azurerm_cosmosdb_sql_database" "Nsure" {
  name                = "Nsure"
  resource_group_name = azurerm_cosmosdb_account.prod-nsure-frontend-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.prod-nsure-frontend-cosmos-db.name
}




resource "azurerm_cosmosdb_sql_container" "Quotation" {
  name                  = "Quotation"
  resource_group_name = azurerm_cosmosdb_account.prod-nsure-frontend-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.prod-nsure-frontend-cosmos-db.name
  database_name         = azurerm_cosmosdb_sql_database.Nsure.name
  partition_key_path = "/userId"

}
