## Storage

resource "azurerm_storage_account" "nsurestorage" {
  name                     = var.nsuredevstorage-name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_kind = "Storage"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}


resource "azurerm_storage_container" "azure-webjobs-hosts" {
  name                  = "azure-webjobs-hosts"
  storage_account_name  = azurerm_storage_account.nsurestorage.name
  container_access_type = "private"

}

resource "azurerm_storage_container" "azure-webjobs-secrets" {
  name                  = "azure-webjobs-secrets"
  storage_account_name  = azurerm_storage_account.nsurestorage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "email-attachments" {
  name                  = "email-attachments"
  storage_account_name  = azurerm_storage_account.nsurestorage.name
  container_access_type = "private"

}

resource "azurerm_storage_container" "persist-key-blob-container" {
  name                  = "persist-key-blob-container"
  storage_account_name  = azurerm_storage_account.nsurestorage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "public" {
  name                  = "public"
  storage_account_name  = azurerm_storage_account.nsurestorage.name
  container_access_type = "blob"

}


resource "azurerm_storage_container" "quotation-logs" {
  name                  = "quotation-logs"
  storage_account_name  = azurerm_storage_account.nsurestorage.name
  container_access_type = "private"

}

resource "azurerm_storage_container" "user-files" {
  name                  = "user-files"
  storage_account_name  = azurerm_storage_account.nsurestorage.name
  container_access_type = "private"

}


resource "azurerm_storage_share" "configuration" {
  name                 = "configuration"
  storage_account_name = azurerm_storage_account.nsurestorage.name

}

resource "azurerm_storage_share" "everquotefileshare" {
  name                 = "everquotefileshare"
  storage_account_name = azurerm_storage_account.nsurestorage.name

}

resource "azurerm_storage_share" "nsure" {
  name                 = "nsure"
  storage_account_name = azurerm_storage_account.nsurestorage.name

}

resource "azurerm_storage_share" "nsure-dev-functionapps890a" {
  name                 = "nsure-dev-functionapps890a"
  storage_account_name = azurerm_storage_account.nsurestorage.name

}

resource "azurerm_storage_share" "nsuredevnotificationfunctionaaee" {
  name                 = "nsuredevnotificationfunctionaaee"
  storage_account_name = azurerm_storage_account.nsurestorage.name
}

resource "azurerm_storage_share" "turborater" {
  name                 = "turborater"
  storage_account_name = azurerm_storage_account.nsurestorage.name

}


resource "azurerm_storage_queue" "azurewebjobshostlogs201809" {
  name                 = "azurewebjobshostlogs201809"
  storage_account_name = azurerm_storage_account.nsurestorage.name
}



resource "azurerm_storage_queue" "azurewebjobshostlogs201810" {
  name                 = "azurewebjobshostlogs201810"
  storage_account_name = azurerm_storage_account.nsurestorage.name
}

resource "azurerm_storage_queue" "azurewebjobshostlogs201811" {
  name                 = "azurewebjobshostlogs201811"
  storage_account_name = azurerm_storage_account.nsurestorage.name
}

resource "azurerm_storage_queue" "azurewebjobshostlogs201812" {
  name                 = "azurewebjobshostlogs201812"
  storage_account_name = azurerm_storage_account.nsurestorage.name
}

resource "azurerm_storage_queue" "azurewebjobshostlogs201901" {
  name                 = "azurewebjobshostlogs201901"
  storage_account_name = azurerm_storage_account.nsurestorage.name
}

resource "azurerm_storage_queue" "azurewebjobshostlogs201902" {
  name                 = "azurewebjobshostlogs201902"
  storage_account_name = azurerm_storage_account.nsurestorage.name
}

resource "azurerm_storage_queue" "azurewebjobshostlogs202102" {
  name                 = "azurewebjobshostlogs202102"
  storage_account_name = azurerm_storage_account.nsurestorage.name
}

resource "azurerm_storage_queue" "azurewebjobshostlogs202104" {
  name                 = "azurewebjobshostlogs202104"
  storage_account_name = azurerm_storage_account.nsurestorage.name
}

resource "azurerm_storage_queue" "azurewebjobshostlogs202105" {
  name                 = "azurewebjobshostlogs202105"
  storage_account_name = azurerm_storage_account.nsurestorage.name
}

resource "azurerm_storage_queue" "azurewebjobshostlogs202111" {
  name                 = "azurewebjobshostlogs202111"
  storage_account_name = azurerm_storage_account.nsurestorage.name
}

resource "azurerm_storage_queue" "azurewebjobshostlogscommon" {
  name                 = "azurewebjobshostlogscommon"
  storage_account_name = azurerm_storage_account.nsurestorage.name
}