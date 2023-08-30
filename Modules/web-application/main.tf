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

  dynamic "site_config" {
    for_each = var.site_config
    content {
      default_documents  = site_config.value["default_documents"]
      http2_enabled      = site_config.value["http2_enabled"]
      websockets_enabled = site_config.value["websockets_enabled"]
      always_on          = site_config.value["always_on"]
      use_32_bit_worker  = site_config.value["use_32_bit_worker"]
      ftps_state         = site_config.value["ftps_state"]
      application_stack {
        current_stack  = site_config.value["current_stack"]
        dotnet_version = site_config.value["dotnet_version"]
      }
    }
  }
}
