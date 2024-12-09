variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
}

variable "app_service_plan_id" {
  description = "ID of the App Service Plan."
  type        = string
}

variable "environment_type" {
  description = "The environment type for the app (e.g., development, production)."
  type        = string
}

variable "min_tls_version" {
  description = "Minimum TLS version to be supported by the app service."
  type        = string
}

variable "app_insights_key" {
  description = "Instrumentation key for Application Insights."
  type        = string
}

variable "auth_certificate_thumbprint" {
  description = "Certificate thumbprint for client certificate validation."
  type        = string
}

variable "messaging_connection_string" {
  description = "Primary connection string for messaging services."
  type        = string
}

variable "solr_connection_string" {
  description = "Connection string for the SOLR core."
  type        = string
}

variable "collection_db_user_name" {
  description = "Database username for the Collection Database."
  type        = string
}

variable "collection_db_user_password" {
  description = "Database password for the Collection Database."
  type        = string
}
