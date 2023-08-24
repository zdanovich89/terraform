data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "prod-nsure-keyvault" {
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  name = var.prod-nsure-keyvault-name
  soft_delete_retention_days = "10"
  sku_name = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id
  access_policy {
    object_id = azurerm_app_service.prod-nsure-frontend-api.id
    tenant_id = data.azurerm_client_config.current.tenant_id
    
    key_permissions = [
      "Get",
      "List"
    ]
    
    secret_permissions = [
      "UnwrapKey",
      "WrapKey"
    ]
  }
}

resource "azurerm_key_vault_secret" "prod-nsure-keyvault-cosmosdb-connection-string" {
  name         = "CosmosDb--ConnectionString"
  value        = ""
  key_vault_id = azurerm_key_vault.prod-nsure-keyvault.id
}

resource "azurerm_key_vault_secret" "prod-nsure-keyvault-frontendcosmosdb-connection-string" {
  name         = "FrontendCosmosDb--ConnectionString"
  value        = ""
  key_vault_id = azurerm_key_vault.prod-nsure-keyvault.id
}

resource "azurerm_key_vault_secret" "prod-nsure-keyvault-jwt-secret-key" {
  name         = "JWT--SecretKey"
  value        = ""
  key_vault_id = azurerm_key_vault.prod-nsure-keyvault.id
}