## EastUSPlan

resource "azurerm_app_service_plan" "EastUSPlan" {
  name                       = "EastUSPlan"
  location                   = var.resource_group_location
  resource_group_name        = var.resource_group_name
  kind                       = "FunctionApp"
  maximum_elastic_worker_count = "0"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}
