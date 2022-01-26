variable "resource_group_name" {
  type = string
  default = "prod-nsure-frontend"
}

variable "resource_group_location" {
  type = string
  default = "eastus"
}

variable "prod-nsure-blazor-appservice-name"{
  type = string
  default = "prod-nsure-blazor"
}


variable "prod-nsure-keyvault-name"{
  type = string
  default = "prodnsurekeyvault"
}

variable "prod-nsure-frontendapi-name" {
  type = string
  default = "prod-nsure-frontend-api"
}

variable "subscription_id" {
  type = string
  default = "98134baf-b89e-45c5-9c70-1c40e593e6db"
}

variable "prod-nsure-frontend-cosmos-db-name"{
  type = string
  default = "prod-nsure-frontend-cosmos-db"
}