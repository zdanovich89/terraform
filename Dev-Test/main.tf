terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.2"
    }
  }
    backend "azurerm" {
        resource_group_name  = "rg-terraform-main-dev-nsure-01"
        storage_account_name = "stterraformdevnsure01"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }

}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}



#module "rg-finturo-tst-01" {
#    source = "../Modules/Finturo/tst/rg-finturo-tst-01"
#}
#module "rg-nsure-tst-01" {
#    source = "../Modules/Finturo/tst/rg-nsure-01"
#
#    app_service_plan_id_spfinturo_tst=module.rg-finturo-tst-01.plan-finturotst-nsure-01_id
#}
#module "rg-nsure-dev-01" {
#    source = "../Modules/Finturo/dev/rg-nsure-dev-01"
#}
#module "rg-nsuremigration-prd-01" {
#    source = "../Modules/Finturo/dev/rg-nsuremigration-prd-01"
#}
module "rg-crm-rad-01" {
    source = "../Modules/Finturo/rad/rg-crm-rad-01"
}
