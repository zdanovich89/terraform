resource "azurerm_app_service" "nsure-dev" {
  name                = var.prod-nsure-blazor-appservice-name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.prod-nsure-service-plan.id
  client_affinity_enabled = true 
  https_only = true 
  site_config {
    cors {
      allowed_origins = []
      support_credentials = false
    }
    always_on = true
    websockets_enabled = true
  }
  app_settings = {
  "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.blazor-application-insights.instrumentation_key
  "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.blazor-application-insights.connection_string
  }
 
}