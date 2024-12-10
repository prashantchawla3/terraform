authCertificateNameTidy

variable "server_farm_id" {
  description = "ID of the App Service Plan."
  type        = string
}

variable "application_path" {
  description = "Path of the application."
  type        = string
}

variable "ritm_number" {
  description = "The RITM number for the deployment."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region for resource deployment."
  type        = string
}

variable "app_service_plan_id" {
  description = "ID of the App Service Plan."
  type        = string
}
