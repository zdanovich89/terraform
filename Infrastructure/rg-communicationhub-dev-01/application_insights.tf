module "application_insights" {
  source = "../../Modules/application_insights"

  name                = "appi-commhub-dev-nsure-01"
  resource_group_name = "rg-communicationhub-dev-01"
  location            = "eastus"
}
