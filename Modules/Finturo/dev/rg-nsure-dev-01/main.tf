resource "azurerm_resource_group" "rg-nsure-dev-01" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "st-finturo-dev-nsure-01" {
  name                      = "stfinturonsuredevnsure01"
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
    azurerm_resource_group.rg-nsure-dev-01
  ]
}

resource "azurerm_log_analytics_workspace" "workspace-finturo-dev-nsure-01" {
  name                = "workspace-finturo-dev-nsure-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = "30"
  tags = {
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01
  ]
}

resource "azurerm_application_insights" "appi-finturo-dev-nsure-01" {
  name                = "appi-finturo-dev-nsure-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.workspace-finturo-dev-nsure-01.id
  application_type    = "web"

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01,
    azurerm_log_analytics_workspace.workspace-finturo-dev-nsure-01
  ]
}

resource "azurerm_mssql_server" "sql-finturo-dev-nsure-01" {
  name                         = "sql-finturo-dev-nsure-01"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "nsure"
  administrator_login_password = "ZAQ!2wsxCDE#"
  tags = {
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01
  ]
}

resource "azurerm_mssql_database" "sqldb-finturo-main-dev-nsure-01" {
  name      = "sqldb-finturo-main-dev-nsure-01"
  server_id = azurerm_mssql_server.sql-finturo-dev-nsure-01.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  sku_name  = "S0"

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01,
    azurerm_mssql_server.sql-finturo-dev-nsure-01
  ]

}

resource "azurerm_mssql_database" "sqldb-finturo-master-dev-nsure-01" {
  name      = "sqldb-finturo-master-dev-nsure-01"
  server_id = azurerm_mssql_server.sql-finturo-dev-nsure-01.id

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01,
    azurerm_mssql_server.sql-finturo-dev-nsure-01
  ]

}

resource "azurerm_cosmosdb_account" "cosmos-finturo-dev-nsure-01" {
  name                = "cosmos-finturo-dev-nsure-01"
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
    location          = var.location
    failover_priority = "0"
  }
  tags = {
    "defaultExperience" = "DocumentDB"
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01
  ]
}

resource "azurerm_cosmosdb_account" "cosmos-finturo-analytic-dev-nsure-01" {
  name                = "cosmos-finturo-analytic-dev-nsure-01"
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
    location          = var.location
    failover_priority = "0"
  }
  tags = {
    "defaultExperience"       = "Core (SQL)"
    "hidden-cosmos-mmspecial" = ""
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01
  ]
}

resource "azurerm_service_plan" "plan-finturo-dev-nsure-01" {
  name                = "plan-finturo-dev-nsure-01"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Windows"
  sku_name            = "B2"

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01
  ]
}

resource "azurerm_windows_web_app" "app_services_with_appi" {

  for_each = var.app_services_with_appi

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.plan-finturo-dev-nsure-01.id
  https_only          = each.value.https_only
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY        = azurerm_application_insights.appi-finturo-dev-nsure-01.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.appi-finturo-dev-nsure-01.connection_string
  }

  site_config {}
  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01,
    azurerm_application_insights.appi-finturo-dev-nsure-01
  ]
}

resource "azurerm_windows_web_app" "app_services_without_appi" {

  for_each = var.app_services_without_appi

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.plan-finturo-dev-nsure-01.id
  https_only          = each.value.https_only
  app_settings = {
  }

  site_config {}
  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01
  ]
}

resource "azurerm_windows_function_app" "function_apps" {
  for_each                   = var.function_apps
  name                       = each.value.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  storage_account_name       = azurerm_storage_account.st-finturo-dev-nsure-01.name
  storage_account_access_key = azurerm_storage_account.st-finturo-dev-nsure-01.primary_access_key
  service_plan_id            = azurerm_service_plan.plan-finturo-dev-nsure-01.id
  https_only                 = each.value.https_only
  builtin_logging_enabled    = each.value.enable_builtin_logging
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY        = azurerm_application_insights.appi-finturo-dev-nsure-01.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.appi-finturo-dev-nsure-01.connection_string
  }

  identity {
    type = "SystemAssigned"
  }

  site_config {}

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01,
    azurerm_application_insights.appi-finturo-dev-nsure-01
  ]
}

resource "azurerm_servicebus_namespace" "nsure-dev-service-bus" {
  name                = "sb-finturonsure-dev-nsure-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  tags = {
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01,
    azurerm_servicebus_namespace.nsure-dev-service-bus
  ]
}

resource "azurerm_container_group" "cg-finturo-main-dev-nsure-01" {
  name                = "cg-finturo-main-dev-nsure-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  dns_name_label      = "nsure-sftp-dev"
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
      storage_account_name = azurerm_storage_account.st-finturo-dev-nsure-01.name
      storage_account_key  = azurerm_storage_account.st-finturo-dev-nsure-01.primary_access_key
    }
    volume {
      name                 = "sftvolume2"
      mount_path           = "/home/everquote/upload"
      share_name           = "everquotefileshare"
      read_only            = false
      storage_account_name = azurerm_storage_account.st-finturo-dev-nsure-01.name
      storage_account_key  = azurerm_storage_account.st-finturo-dev-nsure-01.primary_access_key
    }
    volume {
      name                 = "sftvolume3"
      mount_path           = "/home/smartfinancial/upload"
      share_name           = "smartfinancialfileshare"
      read_only            = false
      storage_account_name = azurerm_storage_account.st-finturo-dev-nsure-01.name
      storage_account_key  = azurerm_storage_account.st-finturo-dev-nsure-01.primary_access_key
    }

    ports {
      port     = 22
      protocol = "TCP"
    }
  }
  tags = {

  }

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01
  ]
}


resource "azurerm_servicebus_queue" "sb_queues" {

  for_each = var.sb_queues


  name                                 = each.value.name
  namespace_id                         = azurerm_servicebus_namespace.nsure-dev-service-bus.id
  enable_partitioning                  = each.value.enable_partitioning
  enable_express                       = each.value.enable_express
  requires_duplicate_detection         = each.value.requires_duplicate_detection
  requires_session                     = each.value.requires_session
  dead_lettering_on_message_expiration = each.value.dead_lettering_on_message_expiration

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01
  ]
}

resource "azurerm_key_vault" "kv-finturo-dev-nsure-01" {
  name                            = "kv-finturo-dev-nsure-01"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  sku_name                        = "standard"
  tenant_id                       = var.tenant_id
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_windows_function_app.function_apps["func-finturo-background-dev-nsure-01"].identity[0].principal_id
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
    object_id = azurerm_windows_function_app.function_apps["func-finturo-sendgrid-dev-nsure-01"].identity[0].principal_id
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
    object_id = "e2da873d-083d-4f52-b1fd-24305b66ba76"
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
    object_id = "255a8c72-069f-4214-8f45-3b79a164f278"
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
    object_id = azurerm_windows_web_app.app_services_with_appi["app-finturo-virtualentityapi-dev-nsure-01"].identity[0].principal_id
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
    object_id = azurerm_windows_web_app.app_services_with_appi["app-finturo-crmfileapi-dev-nsure-01"].identity[0].principal_id
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
    object_id = "57ada566-c017-43b4-8466-4481e5134cf8"
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
    object_id = "c5a149fe-1878-4abe-9a6e-10610b0f4d88"
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
    object_id = azurerm_windows_function_app.function_apps["func-finturo-crm-dev-nsure-01"].identity[0].principal_id
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
    object_id = azurerm_windows_web_app.app_services_with_appi["app-finturo-insurancemicroservice-dev-nsure-01"].identity[0].principal_id
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
    object_id = azurerm_windows_web_app.app_services_with_appi["app-finturo-devapi-dev-nsure-01"].identity[0].principal_id
    key_permissions = [
      "UnwrapKey",
      "WrapKey",
      "Get",
      "List",
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
    object_id = "0d40cd95-3a9f-4915-8f48-86fa5c6302dd"
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
    object_id = "76172d74-08dd-4261-aa0e-885a74c0cea9"
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
    object_id = "f8528d70-799d-4289-8d3d-c57e8ee82917"
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
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = azurerm_windows_function_app.function_apps["func-finturo-quotation-dev-nsure-01"].identity[0].principal_id
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
    object_id = "a468e1b1-cf54-499a-8af7-a538fbdef959"
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
    object_id = "3e236511-a318-43e9-9949-b89ce363ca74"
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey",
    ]
    secret_permissions = [
      "Get",
      "List"
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = "9bb39dbc-4571-462c-bbc5-5d8b782df6e1"
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey"
    ]
    secret_permissions = [
      "Get",
      "List"
    ]
    certificate_permissions = [
      "Get",
      "List"
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = "edee2f5d-7463-4aca-a119-b00a13c8526b"
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey"
    ]
    secret_permissions = [
      "Get",
      "List"
    ]
    certificate_permissions = [
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = "321b5691-ebbb-47fe-8bb3-94c524558f19"
    key_permissions = [
      "Get",
      "List",
      "UnwrapKey",
      "WrapKey"
    ]
    secret_permissions = [
      "Get",
      "List"
    ]
    certificate_permissions = [
    ]
  }
  tags = {
  }
  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01,
    azurerm_windows_web_app.app_services_with_appi,
    azurerm_windows_web_app.app_services_without_appi,
    azurerm_windows_function_app.function_apps
  ]
}


resource "azurerm_monitor_autoscale_setting" "nsure-dev__nsure-dev-service-plan-Autoscale-539" {
  name                = "nsure-dev-service-plan-Autoscale-539"
  location            = var.location
  resource_group_name = var.resource_group_name
  enabled             = false
  target_resource_id  = azurerm_service_plan.plan-finturo-dev-nsure-01.id
  profile {
    name = "Auto created scale condition"
    capacity {
      default = "1"
      minimum = "1"
      maximum = "1"
    }
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.plan-finturo-dev-nsure-01.id
        operator           = "GreaterThan"
        statistic          = "Average"
        threshold          = "90.0"
        time_aggregation   = "Average"
        time_grain         = "PT1M"
        time_window        = "PT10M"
      }
      scale_action {
        cooldown  = "PT10M"
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
      }
    }
  }
  notification {
    email {
      send_to_subscription_administrator    = false
      send_to_subscription_co_administrator = false
      custom_emails                         = ["krprus@netwise.pl"]
    }
  }
  tags = {
  }

  depends_on = [
    azurerm_resource_group.rg-nsure-dev-01
  ]
}

