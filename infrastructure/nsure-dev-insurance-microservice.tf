## nsure-dev-insurance-microservice

resource "azurerm_app_service" "nsure-dev-insurance-microservice" {
  name                = var.nsure-dev-insurance-microservice_name
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
    use_32_bit_worker_process = true ## Configures app service to run in 32 bit mode
    default_documents = [ "Default.htm", "Deafult.html", "Default.asp", "index.htm", "index.html", "iisstart.htm", "default.aspx", "index.php", "hostingstart.html"] ## Sets the ordering of default documents to load, if an address isn't specified.
  }
  
  identity {
    type = "SystemAssigned" ## Specifies the identity type of the App Service, System Assigned generates a service principal for you
  }

  app_settings = {
    "ANCM_ADDITIONAL_ERROR_PAGE_LINK" = "https://${var.nsure-dev-insurance-microservice_name}scm.azurewebsites.net/detectors?type=tools&name=eventviewer"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.dev-application-insights.instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "disabled"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "disabled"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.dev-application-insights.connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    "ASPNETCORE_ENVIRONMENT" = "Development"
    "AzureActiveDirectory:AuthUri" = "https://login.microsoftonline.com/nsure.com/oauth2/authorize"
    "AzureActiveDirectory:Domain" = "nsure.com"
    "AzureActiveDirectory:Instance" = "https://login.microsoftonline.com"
    "AzureActiveDirectory:WebApiUri" = "https://nsure-dev.crm.dynamics.com/api/data/v9.1"
    "DiagnosticServices_EXTENSION_VERSION" = "disabled"
    "InstrumentationEngine_EXTENSION_VERSION" = "disabled"
    "MSDEPLOY_RENAME_LOCKED_FILES" = "1"
    "Quotation:Mocks:All" = "false"
    "Quotation:Mocks:AutoQuotation" = "false"
    "Quotation:Mocks:HomeownersQuotation" = "false"
    "ServiceBusQueue:AutomaticAutoInsuranceCreationQueue:DelaySendingMinute" = "5"
    "ServiceBusQueue:AutomaticHomeInsuranceCreationQueue:DelaySendingMinute" = "5"
    "SnapshotDebugger_EXTENSION_VERSION" = "disabled"
    "Turborater:Mocks:AutoByYearMakeModelDetails" = "False"
    "Turborater:Mocks:FindCounties" = "False"
    "Turborater:Mocks:FindVehiclesAndDrivers" = "False"
    "Turborater:Mocks:PropertyValuationForLookup" = "False"
    "Turborater:Mocks:VINDetails" = "False"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode" = "recommended"


  }
}

resource "azurerm_template_deployment" "nsure-dev-insurance-microservice-corestack" {
  name                = "nsure-dev-insurance-microservice-corestack"
  resource_group_name = var.resource_group_name
  template_body       = <<DEPLOY
  {
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "siteName": {
            "type": "string",
            "metadata": {
                "description": "The Azure App Service Name"
            }
        }
    },
    "resources": [
        {
            "apiVersion": "2018-02-01",
            "name": "[parameters('siteName')]",
            "type": "Microsoft.Web/sites",
            "location": "[resourceGroup().location]",
            "properties": {
                "name": "[parameters('siteName')]",
                "siteConfig": {
                    "metadata": [
                        {
                            "name": "CURRENT_STACK",
                            "value": "dotnetcore"
                        }
                    ]
                }
            }
        }
    ]
}
  DEPLOY
  parameters = {
    "siteName"         = azurerm_app_service.nsure-dev-insurance-microservice.name
  }
  deployment_mode = "Incremental"
  depends_on      = [azurerm_app_service.nsure-dev-insurance-microservice]
}
