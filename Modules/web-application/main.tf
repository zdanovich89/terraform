resource "azurerm_windows_web_app" "windows_app" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id
  app_settings        = merge(var.app_settings)
  site_config {
    always_on = true
  }
}
