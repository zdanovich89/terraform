## Security center settings
resource "azurerm_security_center_subscription_pricing" "appservicessecurity" {
  tier          = "Standard"
  resource_type = "AppServices"
}

resource "azurerm_security_center_subscription_pricing" "keyvaultssecurity" {
  tier          = "Standard"
  resource_type = "KeyVaults"
}
