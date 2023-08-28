output "application_insights_connection_string" {
  value = module.app_insights.connection_string
}

output "application_insights_instrumentation_key" {
  value = module.app_insights.instrumentation_key
}
