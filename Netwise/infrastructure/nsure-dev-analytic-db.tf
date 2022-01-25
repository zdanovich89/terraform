resource "azurerm_cosmosdb_account" "nsure-dev-analytic-db" {
name                = var.nsure-dev-analytic-db_name
location            = var.resource_group_location
resource_group_name = var.resource_group_name
offer_type          = "Standard" #Specifies the Offer Type to use for this CosmosDB Account
kind                = "GlobalDocumentDB" #Specifies the Kind of CosmosDB to create - possible values are GlobalDocumentDB and MongoDB
  consistency_policy {
    consistency_level       = "Session" #Configures the database consistency
  }
  
  geo_location {
    location          = var.resource_group_location #Configures the geographic locations the data is replicated to
    failover_priority = 0 #A failover priority of 0 indicates a write region
  }
  tags = {
    "defaultExperience" = "DocumentDB"
  }
}



resource "azurerm_cosmosdb_sql_database" "NsureAnalytics" {
  name                = "Nsure Analytics"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-analytic-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-analytic-db.name
}




resource "azurerm_cosmosdb_sql_container" "ClickData" {
  name                  = "ClickData"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-analytic-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-analytic-db.name
  database_name         = azurerm_cosmosdb_sql_database.NsureAnalytics.name
  partition_key_path = "/type"

  indexing_policy {
    indexing_mode = "Consistent"


    included_path {
      path = "/*"
    }

    excluded_path {
      path = "/\"_etag\"/?"
    } 
  
  }

}


resource "azurerm_cosmosdb_sql_container" "MarketingReportData" {
  name                  = "MarketingReportData"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-analytic-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-analytic-db.name
  database_name         = azurerm_cosmosdb_sql_database.NsureAnalytics.name
  partition_key_path = "/type"

  indexing_policy {
    indexing_mode = "Consistent"


    included_path {
      path = "/*"
    }

    excluded_path {
      path = "/\"_etag\"/?"
    } 
  
  }

}