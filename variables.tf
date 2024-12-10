sc-app-prcHostingPlanNameTidy

variable "use_ase" {
  description = "Indicates if an App Service Environment (ASE) is used."
  type        = bool
}

variable "prc_properties" {
  description = "Prc hosting plan properties, dynamically set based on ASE usage."
  type        = string
}

variable "prc_hosting_plan_connection_string" {
  description = "Connection string for Prc hosting plan configurations."
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
