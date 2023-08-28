resource "azurerm_windows_web_app" "windows_app" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {
    always_on                             = true
    APPINSIGHTS_INSTRUMENTATIONKEY        = module.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = module.application_insights.connection_string
  }
}
