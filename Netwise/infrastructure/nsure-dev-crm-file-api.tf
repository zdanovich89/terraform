## Nsure Dev Crm File Api 


resource "azurerm_app_service" "nsure-dev-crm-file-api" {
  name                = var.nsure-dev-crm-file-api
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
    php_version = "5.6"
    remote_debugging_version = "VS2017"
    scm_type = "VSTSRM"
    use_32_bit_worker_process = true ## Configures app service to run in 32 bit mode
    default_documents = [ "Default.htm", "Deafult.html", "Default.asp", "index.htm", "index.html", "iisstart.htm", "default.aspx", "index.php", "hostingstart.html"] ## Sets the ordering of default documents to load, if an address isn't specified.
  }
  
  identity {
    type = "SystemAssigned" ## Specifies the identity type of the App Service, System Assigned generates a service principal for you
  }

  app_settings = {
   "APPINSIGHTS_INSTRUMENTATIONKEY" =  azurerm_application_insights.dev-application-insights.instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "disabled"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    "ASPNETCORE_ENVIRONMENT" = "Development"
    "CosmosDb:Key" = "" ## KEYVAULT COMOS DB KEY 
    "DiagnosticServices_EXTENSION_VERSION" = "~3"
    "InstrumentationEngine_EXTENSION_VERSION" = "disabled"
    "MSDEPLOY_RENAME_LOCKED_FILES" = "1"
    "PdfFirstPageLocation" = "./APP_DATA/firstpage.pdf"
    "SnapshotDebugger_EXTENSION_VERSION" = "disabled"
    "StorageAccounts:ConnectionString" = azurerm_storage_account.nsurestorage.primary_connection_string
    "WEBSITE_NODE_DEFAULT_VERSION" = "6.9.1"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode" = "recommended"


  }
}


resource "azurerm_template_deployment" "nsure-dev-crm-file-api-logging-extension"{
  name = "nsure-dev-crm-file-api-logging-extension"
  resource_group_name = var.resource_group_name
  deployment_mode = "Incremental"
  template_body = <<DEPLOY
    {
   "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
   "contentVersion": "1.0.0.0",
   "parameters": {
       "siteName": {
           "type": "string",
           "metadata": {
               "description": "The Azure App Service Name"
           }
       },
       "extensionName": {
           "type": "string",
           "metadata": {
               "description": "The Site Extension Name."
           }
       },
       "extensionVersion": {
           "type": "string",
           "metadata": {
               "description": "The Extension Version"
           }
       }
   },
   "resources": [
       {
           "type": "Microsoft.Web/sites/siteextensions",
           "name": "[concat(parameters('siteName'), '/', parameters('extensionName'))]",
           "apiVersion": "2015-04-01",
           "location": "[resourceGroup().location]",
           "properties": {
               "version": "[parameters('extensionVersion')]"
           }
       }
   ]
}
    DEPLOY


  parameters =  {
    "siteName"          = "${azurerm_app_service.nsure-dev-crm-file-api.name}"
    "extensionName"     = "Microsoft.AspNetCore.AzureAppServices.SiteExtension"
    "extensionVersion"  = "6.0.0"
  }
}
