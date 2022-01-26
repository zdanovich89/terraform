data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "prod-nsure-keyvault" {
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  name = var.prod-nsure-keyvault-name
  soft_delete_retention_days = "10"
  sku_name = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id
  
} 