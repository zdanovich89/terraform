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

variable "service_plan_id" {
  type = string
}

variable "https_only" {
  type    = string
  default = "true"
}

variable "app_settings" {
  type = map(string)
  default = {
    ApplicationInsightsAgent_EXTENSION_VERSION = "~3"
    ASPNETCORE_ENVIRONMENT                     = "Development"
    WEBSITE_RUN_FROM_PACKAGE                   = "1"
    XDT_MicrosoftApplicationInsights_Mode      = "Recommended"
    https_only                                 = "true"
  }
}

variable "site_config" {
  type = list(object({
    default_documents  = list(string)
    http2_enabled      = bool
    websockets_enabled = bool
    always_on          = bool
    use_32_bit_worker  = bool
    ftps_state         = string
    current_stack      = string
    dotnet_version     = string
  }))
  default = [
    {
      default_documents  = ["index.html", "Default.htm", "Default.html", "Default.asp", "index.htm", "iisstart.htm", "default.aspx", "index.php", "hostingstart.html"]
      http2_enabled      = false
      websockets_enabled = true
      always_on          = true
      use_32_bit_worker  = true
      ftps_state         = "FtpsOnly"
      current_stack      = "dotnet"
      dotnet_version     = "v6.0"
    }
  ]
}

variable "identity" {
  type    = string
  default = "SystemAssigned"
}
