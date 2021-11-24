# resource "azurerm_management_lock" "OnDelete" {
#   name       = "OnDelete"
#   scope      = azurerm_resource_group.nsure-dev.id
#   lock_level = "CanNotDelete"
# }