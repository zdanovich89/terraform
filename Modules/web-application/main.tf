resource "azurerm_windows_web_app" "windows_app" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id
  https_only          = var.https_only
  app_settings        = var.app_settings
  identity {
    type = var.identity
  }

  site_config {
    default_documents  = var.site_config.default_documents
    http2_enabled      = var.site_config.http2_enabled
    websockets_enabled = var.site_config.websockets_enabled
    always_on          = var.site_config.always_on
    use_32_bit_worker  = var.site_config.use_32_bit_worker
    ftps_state         = var.site_config.ftps_state
    application_stack {
      current_stack  = var.site_config.current_stack
      dotnet_version = var.site_config.dotnet_version
    }
  }
}
