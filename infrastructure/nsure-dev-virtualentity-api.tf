## nsure-dev-virtualentity-api
resource "azurerm_app_service" "nsure-dev-virtualentity-api" {
  name                = var.nsure-dev-virtualentity-api
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.nsure-dev-service-plan.id
  client_affinity_enabled = true ## Enables session affinity cookies, which route client requests in the same session to the same instance
  https_only = true ## enables all HTTP traffic to be redirected to HTTPS
  
  site_config {
    cors {
      allowed_origins = []
      support_credentials = false
    }
    always_on = true ## Prevents app from being idled out due to inactivity.
    dotnet_framework_version = "v4.0"
    use_32_bit_worker_process = true ## Configures app service to run in 32 bit mode
    default_documents = [ "Default.htm", "Deafult.html", "Default.asp", "index.htm", "index.html", "iisstart.htm", "default.aspx", "index.php", "hostingstart.html"] ## Sets the ordering of default documents to load, if an address isn't specified.
  }
  
  identity {
    type = "SystemAssigned" ## Specifies the identity type of the App Service, System Assigned generates a service principal for you
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.dev-application-insights.instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "disabled"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.dev-application-insights.connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    "ASPNETCORE_DETAILEDERRORS" = "True"
    "ASPNETCORE_ENVIRONMENT" = "Development"
    "DiagnosticServices_EXTENSION_VERSION" = "~3"
    "InstrumentationEngine_EXTENSION_VERSION" = "disabled"
    "KeyVault:Url" = azurerm_key_vault.nsure-dev-keyvault.vault_uri
    "MSDEPLOY_RENAME_LOCKED_FILES" = "1"
    "SnapshotDebugger_EXTENSION_VERSION" = "disabled"
    "WEBJOBS_RESTART_TIME" = "60"
    "WEBSITE_HEALTHCHECK_MAXPINGFAILURES" = "2"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode" = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk" = "1"

  }
}