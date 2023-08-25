resource "azurerm_service_plan" "service_plan" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

output "service_plan_id" {
  value = azurerm_service_plan.service_plan.id
}
