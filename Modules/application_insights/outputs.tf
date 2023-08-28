output "application_insights_connection_string" {
  value = azurerm_application_insights.app_insights.connection_string
}

output "application_insights_instrumentation_key" {
  value = azurerm_application_insights.app_insights.instrumentation_key
}
