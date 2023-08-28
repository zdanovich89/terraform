module "application_insights" {
  source = "../../Modules/application_insights"

  name                = "appi-commhub-dev-nsure-01"
  resource_group_name = "rg-communicationhub-dev-01"
  application_type    = "ASP.NET web application"
}
