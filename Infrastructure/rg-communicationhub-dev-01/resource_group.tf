module "resource_group" {
  source = "../../Modules/resource-group"

  resource_group_name = "rg-communicationhub-dev-01"
  location            = "eastus"
}
