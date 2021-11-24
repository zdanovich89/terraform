## Nsure Dev
resource "azurerm_app_service" "nsure-dev" {
  name                = var.nsure-dev_name
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
    ftps_state = "FtpsOnly" ## Configures Ftp based deployment to use FTPS 
    default_documents = [ "Default.htm", "Default.asp", "index.htm","iisstart.htm", "default.aspx", "index.php", "hostingstart.html", "index.html"] ## Sets the ordering of default documents to load, if an address isn't specified.
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "10.16.3"
  }
}
