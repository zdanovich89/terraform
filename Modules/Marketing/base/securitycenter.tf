resource "azurerm_security_center_subscription_pricing" "appservicessecurity" {
  tier          = "Standard"
  resource_type = "AppServices"
}
