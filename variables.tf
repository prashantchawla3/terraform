authCertificateNameTidy

variable "auth_certificate_password" {
  description = "Password for the authentication certificate."
  type        = string
}

variable "auth_certificate_blob" {
  description = "PFX blob for the authentication certificate."
  type        = string
}

variable "hosting_environment_profile" {
  description = "Hosting environment profile based on ASE usage."
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
