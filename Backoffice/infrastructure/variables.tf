variable "resource_group_name" {
  type = string
  default = "nsure-dev-zmienne"
}

variable "resource_group_location" {
  type = string
  default = "eastus"
}

variable "subscription_id" {
  type = string
  default = "98134baf-b89e-45c5-9c70-1c40e593e6db"
}


variable "dev-nsure-backoffice-sql-server-name" {
  type = string
  default = "dev-nsure-backoffice-sql-server"
}

variable "dev-nsure-backoffice-sql-database-name" {
  type = string
  default = "dev-nsure-backoffice-sql-database"
}


variable "dev-nsure-backoffice-sql-server-login" {
  type = string
  default = ""
}

variable "dev-nsure-backoffice-sql-server-password" {
  type = string
  default = ""
}

variable "dev-nsure-backoffice-keyvault-name" {
  type = string
  default = "devnsurebackofficekeyvault"
}

variable "backoffice_appservice_name" {
  type = string
  default = "dev-nsure-backoffice-appservice"
}