variable "resource_group_name" {
  type = string
  default = "dev-nsure-frontend"
}

variable "resource_group_location" {
  type = string
  default = "eastus"
}

variable "blazor_appservice_name"{
  type = string
  default = "dev-nsure-blazor"
}


variable "dev-nsure-keyvault-name"{
  type = string
  default = "dev-nsure-keyvault"
}

variable "dev-nsure-frontendapi-name" {
  type = string
  default = "dev-nsure-frontendapi"
}

variable "subscription_id" {
  type = string
  default = "98134baf-b89e-45c5-9c70-1c40e593e6db"
}

variable "dev-nsure-frontend-cosmos-db-name"{
  type = string
  default = "dev-nsure-frontend-cosmos-db"
}