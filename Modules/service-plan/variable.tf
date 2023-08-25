variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "os_type" {
  type    = string
  default = "Windows"
}

variable "sku_name" {
  type    = string
  default = "F1"
}
