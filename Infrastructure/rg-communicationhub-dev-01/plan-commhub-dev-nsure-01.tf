module "service_plan" {
  source = "../../Modules/service-plan"

  depends_on          = [module.resource_group]
  name                = "plan-commhub-dev-nsure-01"
  resource_group_name = "rg-communicationhub-dev-01"
}
