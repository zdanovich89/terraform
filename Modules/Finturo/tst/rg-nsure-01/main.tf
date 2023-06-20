resource "azurerm_resource_group" "rg-nsure-tst-01" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "st-finturo-tst-nsure-01" {
  name                      = "stfinturonsuretstnsure01"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  account_tier              = "Standard"
  account_kind              = "Storage"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  tags = {
    "ms-resource-usage" = "azure-cloud-shell"
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01
  ]
}
resource "azurerm_storage_share" "quinstreetfileshare" {
  name                 = "quinstreetfileshare"
  storage_account_name = azurerm_storage_account.st-finturo-tst-nsure-01.name
  quota                = 50

  acl {
    id = "quinstreetfileshare"
    access_policy {
      permissions = "rwdl"
    }
  }
  depends_on = [
    azurerm_storage_account.st-finturo-tst-nsure-01
  ]
}

resource "azurerm_storage_share" "everquotefileshare" {
  name                 = "everquotefileshare"
  storage_account_name = azurerm_storage_account.st-finturo-tst-nsure-01.name
  quota                = 50

  acl {
    id = "everquotefileshare"
    access_policy {
      permissions = "rwdl"
    }
  }
  depends_on = [
    azurerm_storage_account.st-finturo-tst-nsure-01
  ]
}

resource "azurerm_storage_share" "smartfinancialfileshare" {
  name                 = "smartfinancialfileshare"
  storage_account_name = azurerm_storage_account.st-finturo-tst-nsure-01.name
  quota                = 50

  acl {
    id = "smartfinancialfileshare"
    access_policy {
      permissions = "rwdl"
    }
  }
  depends_on = [
    azurerm_storage_account.st-finturo-tst-nsure-01
  ]
}



resource "azurerm_application_insights" "appi-finturo-tst-nsure-01" {
  name                = "appi-finturo-tst-nsure-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01
  ]
}

resource "azurerm_mssql_server" "sql-finturo-tst-nsure-01" {
  name                         = "sql-finturo-tst-nsure-01"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "admin-test"
  administrator_login_password = "ZAQ!2wsxCDE#"
  tags = {
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01
  ]
}

resource "azurerm_mssql_database" "sqldb-finturo-master-tst-nsure-01" {
  name      = "sqldb-finturo-master-tst-nsure-01"
  server_id = azurerm_mssql_server.sql-finturo-tst-nsure-01.id

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01,
    azurerm_mssql_server.sql-finturo-tst-nsure-01
  ]

}

resource "azurerm_mssql_database" "sqldb-finturo-main-tst-nsure-01" {
  name      = "sqldb-finturo-main-tst-nsure-01"
  server_id = azurerm_mssql_server.sql-finturo-tst-nsure-01.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  sku_name  = "S0"

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01,
    azurerm_mssql_server.sql-finturo-tst-nsure-01
  ]

}

resource "azurerm_cosmosdb_account" "cosmos-finturo-tst-nsure-01" {
  name                = "cosmos-finturo-tst-nsure-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "GlobalDocumentDB"
  offer_type          = "Standard"
  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = "5"
    max_staleness_prefix    = "100"
  }
  enable_automatic_failover = false
  geo_location {
    location          = "East US"
    failover_priority = "0"
  }
  tags = {
    "defaultExperience" = "DocumentDB"
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01
  ]
}

resource "azurerm_cosmosdb_account" "cosmos-finturo-analytic-tst-nsure-01" {
  name                = "cosmos-finturo-analytic-tst-nsure-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "GlobalDocumentDB"
  offer_type          = "Standard"
  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = "5"
    max_staleness_prefix    = "100"
  }
  enable_automatic_failover = false
  geo_location {
    location          = "East US"
    failover_priority = "0"
  }
  tags = {
    "defaultExperience"       = "Core (SQL)"
    "hidden-cosmos-mmspecial" = ""
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01
  ]
}

resource "azurerm_windows_web_app" "app_services_with_appi" {

  for_each = var.app_services_with_appi

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.app_service_plan_id_spfinturo_tst
  https_only          = each.value.https_only
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY        = azurerm_application_insights.appi-finturo-tst-nsure-01.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.appi-finturo-tst-nsure-01.connection_string
  }

  site_config {}
  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01,
    azurerm_application_insights.appi-finturo-tst-nsure-01
  ]
}

resource "azurerm_windows_web_app" "app_services_without_appi" {

  for_each = var.app_services_without_appi

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.app_service_plan_id_spfinturo_tst
  https_only          = each.value.https_only
  app_settings = {
  }

  site_config {}
  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01
  ]
}

resource "azurerm_windows_function_app" "function_apps" {
  for_each                   = var.function_apps
  name                       = each.value.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  storage_account_name       = azurerm_storage_account.st-finturo-tst-nsure-01.name
  storage_account_access_key = azurerm_storage_account.st-finturo-tst-nsure-01.primary_access_key
  service_plan_id            = var.app_service_plan_id_spfinturo_tst
  https_only                 = each.value.https_only
  builtin_logging_enabled    = each.value.enable_builtin_logging
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY        = azurerm_application_insights.appi-finturo-tst-nsure-01.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.appi-finturo-tst-nsure-01.connection_string
  }

  identity {
    type = "SystemAssigned"
  }

  site_config {}

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01,
    azurerm_application_insights.appi-finturo-tst-nsure-01
  ]
}
resource "azurerm_servicebus_namespace" "sb-finturo-tst-nsure-01" {
  name                = "sb-finturonsure-tst-nsure-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  tags = {
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01
  ]
}

resource "azurerm_servicebus_queue" "sb_queues" {

  for_each = var.sb_queues


  name                                 = each.value.name
  namespace_id                         = azurerm_servicebus_namespace.sb-finturo-tst-nsure-01.id
  enable_partitioning                  = each.value.enable_partitioning
  enable_express                       = each.value.enable_express
  requires_duplicate_detection         = each.value.requires_duplicate_detection
  requires_session                     = each.value.requires_session
  dead_lettering_on_message_expiration = each.value.dead_lettering_on_message_expiration
  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01,
    azurerm_servicebus_namespace.sb-finturo-tst-nsure-01
  ]
}

resource "azurerm_container_group" "cg-finturo-main-tst-nsure-01" {
  name                = "cg-finturo-main-tst-nsure-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  dns_name_label      = "nsure-sftp-test-01"
  os_type             = "Linux"

  container {
    name                  = "sftp-container"
    image                 = "atmoz/sftp:latest"
    cpu                   = "1"
    memory                = "1.5"
    environment_variables = { "SFTP_USERS" = "" }
    volume {
      name                 = "sftvolume1"
      mount_path           = "/home/quinstreet/upload"
      share_name           = "quinstreetfileshare"
      read_only            = false
      storage_account_name = azurerm_storage_account.st-finturo-tst-nsure-01.name
      storage_account_key  = azurerm_storage_account.st-finturo-tst-nsure-01.primary_access_key
    }
    volume {
      name                 = "sftvolume2"
      mount_path           = "/home/everquote/upload"
      share_name           = "everquotefileshare"
      read_only            = false
      storage_account_name = azurerm_storage_account.st-finturo-tst-nsure-01.name
      storage_account_key  = azurerm_storage_account.st-finturo-tst-nsure-01.primary_access_key
    }
    volume {
      name                 = "sftvolume3"
      mount_path           = "/home/smartfinancial/upload"
      share_name           = "smartfinancialfileshare"
      read_only            = false
      storage_account_name = azurerm_storage_account.st-finturo-tst-nsure-01.name
      storage_account_key  = azurerm_storage_account.st-finturo-tst-nsure-01.primary_access_key
    }

    ports {
      port     = 22
      protocol = "TCP"
    }
  }
  tags = {

  }

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01,
    azurerm_storage_account.st-finturo-tst-nsure-01
  ]
}


resource "azurerm_key_vault" "nsure__nsure-keyvault" {
  name                            = "kv-finturo-tst-nsure-01"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  sku_name                        = "standard"
  tenant_id                       = var.tenant_id
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  timeouts {
    read = "12m"
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_windows_function_app.function_apps["func-finturo-background-tst-nsure-01"].identity[0].principal_id
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = "e273ee49-3ea5-47e0-9d66-0597bb04eba8"
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_windows_function_app.function_apps["func-finturo-sendgrid-tst-nsure-01"].identity[0].principal_id
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = "34838a61-6834-4cd4-9700-93e03e63ad29"
    key_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
    ]
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
    ]
    certificate_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "ManageContacts",
      "ManageIssuers",
      "GetIssuers",
      "ListIssuers",
      "SetIssuers",
      "DeleteIssuers",
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = "8bbc8d72-787e-4a44-b97f-93c52d4ab019"
    key_permissions = [
      "List",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
      "Get",
      "List",
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_windows_web_app.app_services_without_appi["app-finturo-virtualentityapi-tst-nsure-01"].identity[0].principal_id
    key_permissions = [
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_windows_function_app.function_apps["func-finturo-notification-tst-nsure-01"].identity[0].principal_id
    key_permissions = [
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_windows_web_app.app_services_with_appi["app-finturo-crmfileapi-tst-nsure-01"].identity[0].principal_id
    key_permissions = [
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_windows_function_app.function_apps["func-finturo-crm-tst-nsure-01"].identity[0].principal_id
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_windows_web_app.app_services_with_appi["app-finturo-insurancemicroservice-tst-nsure-01"].identity[0].principal_id
    key_permissions = [
      "Get",
      "List",
      "WrapKey",
      "UnwrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_windows_function_app.function_apps["func-finturo-quotation-tst-nsure-01"].identity[0].principal_id
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = "aee9bb35-cf26-4ad9-9c70-3ec9fe3f531f"
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = "4eb85c27-dd37-4a2b-a918-6af6bc7093e0"
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_windows_web_app.app_services_with_appi["app-finturo-nsureapi-tst-nsure-01"].identity[0].principal_id
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = "6d2c02a1-eecd-45b3-90a6-effeecf72f44"
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_windows_web_app.app_services_with_appi["app-finturo-messengermicroservice-tst-nsure-01"].identity[0].principal_id
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = "8b5e5c17-26bc-4c4c-8782-1107201bbb21"
    key_permissions = [
      "Get",
      "List",
    ]
    secret_permissions = [
      "Get",
      "List",
      "Set",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = "24005ec1-7359-4b7a-9cc6-8f4bc0f6dd9f"
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
    ]
    certificate_permissions = [
    ]
  }
  tags = {
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-tst-01,
    azurerm_windows_web_app.app_services_with_appi,
    azurerm_windows_web_app.app_services_without_appi,
    azurerm_windows_function_app.function_apps
  ]
}