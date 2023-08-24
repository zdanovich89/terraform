

resource "azurerm_cosmosdb_account" "nsure-dev-cosmos-db" {
name                = var.nsure-dev-cosmos-db_name
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

resource "azurerm_advanced_threat_protection" "cosmos-db-advanced-threat-protection" { #Sets advanced threat protection on a resource
  target_resource_id = azurerm_cosmosdb_account.nsure-dev-cosmos-db.id
  enabled            = true
}


resource "azurerm_cosmosdb_sql_database" "Nsure" {
  name                = "Nsure"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-cosmos-db.name
}


resource "azurerm_cosmosdb_sql_container" "Analytics" {
  name                  = "Analytics"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-cosmos-db.name
  database_name         = azurerm_cosmosdb_sql_database.Nsure.name
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
  resource "azurerm_cosmosdb_sql_container" "AutoQuote" {
  name                  = "AutoQuote"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-cosmos-db.name
  database_name         = azurerm_cosmosdb_sql_database.Nsure.name
  partition_key_path = "/userId"

  indexing_policy {
    indexing_mode = "Consistent"


    included_path {
      path = "/*"
      
    }


    excluded_path {
      path = "/\"_etag\"/?"
    } 
  
  }


  conflict_resolution_policy {
    mode = "LastWriterWins"
    conflict_resolution_path = "/_ts"
  }

}

resource "azurerm_cosmosdb_sql_container" "Common" {
  name                  = "Common"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-cosmos-db.name
  database_name         = azurerm_cosmosdb_sql_database.Nsure.name
  partition_key_path = "/id"

  indexing_policy {
    indexing_mode = "Consistent"


    included_path {
      path = "/*"
      
    }

    excluded_path {
      path = "/\"_etag\"/?"
    } 
  
  }

  conflict_resolution_policy {
    mode = "LastWriterWins"
    conflict_resolution_path = "/_ts"
  }

}


resource "azurerm_cosmosdb_sql_container" "Configurations" {
  name                  = "Configurations"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-cosmos-db.name
  database_name         = azurerm_cosmosdb_sql_database.Nsure.name
  partition_key_path = "/partitionKey"

  indexing_policy {
    indexing_mode = "Consistent"


    included_path {
      path = "/*"
      
    }

    excluded_path {
      path = "/\"_etag\"/?"
    } 
  
  }

  conflict_resolution_policy {
    mode = "LastWriterWins"
    conflict_resolution_path = "/_ts"
  }

}



resource "azurerm_cosmosdb_sql_container" "Users" {
  name                  = "Users"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-cosmos-db.name
  database_name         = azurerm_cosmosdb_sql_database.Nsure.name
  partition_key_path = "/partition"

  indexing_policy {
    indexing_mode = "Consistent"


    included_path {
      path = "/*"
      
    }

    excluded_path {
      path = "/\"_etag\"/?"
    } 
  
  }

  conflict_resolution_policy {
    mode = "LastWriterWins"
    conflict_resolution_path = "/_ts"
  }

}


resource "azurerm_cosmosdb_sql_container" "StateConfigurations" {
  name                  = "StateConfigurations"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-cosmos-db.name
  database_name         = azurerm_cosmosdb_sql_database.Nsure.name
  partition_key_path = "/statePK"

  indexing_policy {
    indexing_mode = "Consistent"


    included_path {
      path = "/*"
      
    }

    excluded_path {
      path = "/\"_etag\"/?"
    } 
  
  }

  conflict_resolution_policy {
    mode = "LastWriterWins"
    conflict_resolution_path = "/_ts"
  }

}

resource "azurerm_cosmosdb_sql_container" "HomeownersQuote" {
  name                  = "HomeownersQuote"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-cosmos-db.name
  database_name         = azurerm_cosmosdb_sql_database.Nsure.name
  partition_key_path = "/userId"

  indexing_policy {
    indexing_mode = "Consistent"


    included_path {
      path = "/*"
      
    }

    excluded_path {
      path = "/\"_etag\"/?"
    } 
  
  }

  conflict_resolution_policy {
    mode = "LastWriterWins"
    conflict_resolution_path = "/_ts"
  }

}

resource "azurerm_cosmosdb_sql_container" "Insurances" {
  name                  = "Insurances"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-cosmos-db.name
  database_name         = azurerm_cosmosdb_sql_database.Nsure.name
  partition_key_path = "/userId"

  indexing_policy {
    indexing_mode = "Consistent"


    included_path {
      path = "/*"
      
    }

    excluded_path {
      path = "/\"_etag\"/?"
    } 
  
  }

  conflict_resolution_policy {
    mode = "LastWriterWins"
    conflict_resolution_path = "/_ts"
  }

}

resource "azurerm_cosmosdb_sql_container" "Leads" {
  name                  = "Leads"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-cosmos-db.name
  database_name         = azurerm_cosmosdb_sql_database.Nsure.name
  partition_key_path = "/source"

  indexing_policy {
    indexing_mode = "Consistent"


    included_path {
      path = "/*"
      
    }

    excluded_path {
      path = "/\"_etag\"/?"
    } 
  
  }

  conflict_resolution_policy {
    mode = "LastWriterWins"
    conflict_resolution_path = "/_ts"
  }

}


resource "azurerm_cosmosdb_sql_container" "Notifications" {
  name                  = "Notifications"
  resource_group_name = azurerm_cosmosdb_account.nsure-dev-cosmos-db.resource_group_name
  account_name        = azurerm_cosmosdb_account.nsure-dev-cosmos-db.name
  database_name         = azurerm_cosmosdb_sql_database.Nsure.name
  partition_key_path = "/PartitionId"

  indexing_policy {
    indexing_mode = "Consistent"


    included_path {
      path = "/*"
      
    }

    excluded_path {
      path = "/\"_etag\"/?"
    } 
  
  }

  conflict_resolution_policy {
    mode = "LastWriterWins"
    conflict_resolution_path = "/_ts"
  }

}





