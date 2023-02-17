resource "azurerm_resource_group" "rg-finturo-tst-01" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "spfinturo-tst" {
  name                = "plan-finturotst-nsure-01"
  location            = var.location
  resource_group_name = "var.resource_group_name"
  kind                = "app"
  sku {
    tier = "Basic"
    size = "B2"
  }
}

output "plan-finturotst-nsure-01_id" {
  value = azurerm_app_service_plan.spfinturo-tst.id
}

resource "azurerm_servicebus_namespace" "spfinturo-tst" {
  name                = "sb-finturo-tst-nsure-01"
  location            = var.location
  resource_group_name = "var.resource_group_name"
  sku                 = "Basic"
  tags = {
  }
}

resource "azurerm_servicebus_queue" "sb-finturo-tst-nsure-01_homeownerquotationqueue" {
  name                                 = "homeownerquotationqueue"
  namespace_id = azurerm_servicebus_namespace.spfinturo-tst.id
  enable_partitioning                  = true
  enable_express                       = false
  requires_duplicate_detection         = false
  requires_session                     = false
  dead_lettering_on_message_expiration = false
}

resource "azurerm_servicebus_queue" "sb-finturo-tst-nsure-01_autoquotationqueue" {
  name                                 = "autoquotationqueue"
  namespace_id = azurerm_servicebus_namespace.spfinturo-tst.id
  enable_partitioning                  = true
  enable_express                       = false
  requires_duplicate_detection         = false
  requires_session                     = false
  dead_lettering_on_message_expiration = false
}

resource "azurerm_storage_account" "stfinturotstnsure01" {
  name                      = "stfinturotstnsure01"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  account_tier              = "Standard"
  account_kind              = "Storage"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  tags = {
  }
}