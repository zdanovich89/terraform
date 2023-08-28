module "app_service" {
  source = "../../Modules/web-application"

  resource_group_name = "rg-communicationhub-dev-01"
  name                = "app-commhub-mainapi-dev-nsure-01"
  location            = "eastus"
  service_plan_id     = module.service_plan.service_plan_id
}
