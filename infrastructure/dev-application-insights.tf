## Dev application insights
resource "azurerm_application_insights" "dev-application-insights" {
  name                = "tf-test-appinsights-teststs"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}
