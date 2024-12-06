# Environment of App Service Plan (i.e. PROD/DEV/QA...)
variable "environment" {
    type        = string
    description = "Environment of the app service plan"
}

# Application Name of the ASP
variable "application_name" {
    type        = string
    description = "The application name of the ASP"
}

# Resource Group Name of the ASP
variable "resource_group_name" {
    type        = string
    description = "Resource Group where the ASP will be deployed"
}


variable "poc_asp_name_01" {
    type        = string
    description = "Variable for App Service Plan Name"
}
variable "poc_asp_os_type_01" {
    type        = string
    description = "Variable for App Service Plan OS Type"
}
variable "poc_asp_ritm_number_01" {
    type        = string
    description = "Variable for App Service Plan RITM"
}
variable "poc_asp_per_site_scaling_enabled_01" {
    type        = bool
    description = "Variable for App Service Plan Scaling"
}
variable "poc_asp_worker_count_01" {
    type        = string
    description = "Variable for App Service Plan Worker Count"
}
variable "poc_asp_service_environment_required_01" {
    type        = bool
    description = "Variable for App Service Plan Name"
}
variable "poc_asp_zone_balancing_enabled_01" {
    type        = string
    description = "Variable for App Service Plan Name"
}
variable "poc_asp_sku_name_01" {
    type        = string
    description = "Variable for App Service Plan SKU"
}


# This variable used to declare for the Web App Environment.
variable "environment" {
    type        = string
    description = "value for the environment, i.e. Development, Staging, Production"
}

# This variable used to declare for the Application Name.
variable "application_name" {
    type        = string
    description = "value for the application name"
}

# This variable used to declare for the Virtual Network Name.
variable "vnet_name" {
    type        = string
    description = "value for the virtual network name"
}

# This variable used to declare for the Virtual Network Resource Group Name.
variable "vnet_rg_name" {
    type        = string
    description = "value for the virtual network resource group name"
}


# This variable used to declare for the Resource Group Name.
variable "resource_group_name" {
    type        = string
    default = "value for the resource group name"
}

# This variable used to declare for the Storage Account Name for Web App Custom Backup.
variable "app_bak_storage_ac_name" {
    type        = string
    description = "value for the storage account name for web app custom backup."
}

# This variable used to declare for the Storage Account Resource Group Name for Web App Custom Backup.
variable "app_bak_storage_ac_rg_name" {
    type        = string
    description = "value for the storage account resource group name for web app custom backup"
}

# This variable used to declare for the Storage Account Blob Container Name for Web App Custom Backup.
variable "app_bak_storage_container_name" {
    type        = string
    description = "value for the storage account blob container name for web app custom backup"    
}

##########################################################################################
#################  App Service Web App Variables from input.auto.tfvars  #################
##########################################################################################

variable "app_service_sc-asp-poc-app-ls-dev-01" {
    type = any
    description = "App Service Inputs which belongs to App Service Plan - sc-asp-poc-app-ls-dev-01"
}


# Environment of App Service Environment (i.e. PROD/DEV/QA...)
variable "environment" {
    type        = string
    description = "Environment of the app service environment"
}

# Application Name of the ASE
variable "application_name" {
    type        = string
    description = "The application name of the ASP"
}

# Resource Group Name of the ASE
variable "resource_group_name" {
    type        = string
    description = "Resource Group where the ASP will be deployed"
}

# This variable used to declare for the Virtual Network Name.
variable "vnet_name" {
    type        = string
    description = "value for the virtual network name"
}

# This variable used to declare for the Virtual Network Resource Group Name.
variable "vnet_rg_name" {
    type        = string
    description = "value for the virtual network resource group name"
}

#### App Service Environment Input Variables

variable "poc_ase_name_01" {
    type        = string
    description = "Variable for App Service Environment Name"
}

variable "poc_ase_zone_redundant_01" {
    type        = bool
    description = "Variable for App Service Environment zone redundant"
}

variable "poc_ase_ritm_number_01" {
    type        = string
    description = "Variable App Service Environment RITM"
}


########### Environment Common Variables ###########

# This Variable is used to declare the Environment 
variable "environment" {
  type        = string
  description = "Environment name"
}

# This Variable is used to declare the Application Name 
variable "application_name" {
  type        = string
  description = "Application Name"
}

# This Variable is used to declare the RITM Number 
variable "ritm_number" {
  type        = string
  description = "RITM Number"
}

# This Variable is used to declare the Project ID 
variable "projectid" {
  type        = string
  description = "Project ID"
  default     = ""
}

# This Variable is used to declare the Project Name 
variable "projectname" {
  type        = string
  description = "Project Name"
  default     = ""
}

# This variable used to declare the Additional Tags.
variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to be applied to Redis Cache"
}

# This variable is used to declare the DNS Username 
variable "dns_username" {
  type        = string
  description = "DNS Username"
}

# This variable is used to declare the DNS Password 
variable "dns_password" {
  type        = string
  description = "DNS Password"
}

########### Redis Cache Variables ###########

# This variable is used to declare the Resource Group Name
variable "resource_group_name" {
    description = "Name of the Resource Group"
    type        = string
}

# This variable is used to declare the name of the user assigned managed identity
variable "mgid_name" {
    description = "Name of the User Assigned Managed Identity"
    type        = string
}

# This variable is used to declare the name of the Redis Cache
variable "redis_cache_name" {
    description = "Name of the Redis Cache"
    type        = string
}

# This variable is used to declare the capacity of the Redis Cache
variable "redis_cache_capacity" {
    description = "The size of the Redis Cache to deploy"
    type        = number
}

# This variable is used to declare the SKU family of the Redis Cache
variable "sku_family" {
    description = "The SKU family of the Redis Cache to deploy"
    type        = string
}

# This variable is used to declare the SKU name of the Redis Cache
variable "sku_name" {
    description = "The SKU name of the Redis Cache to deploy"
    type        = string
}

# This variable is used to declare the version of the Redis Cache
variable "redis_version" {
    description = "The version of Redis to deploy"
    type        = number
}

# This variable is used to declare the availability zones of the Redis Cache
variable "availability_zones" {
    description = "The availability zones of the Redis Cache to deploy"
    type        = list(number)
}

# This variable is used to declare the replicas per master of the Redis Cache
variable "replicas_per_master" {
    description = "The number of replicas per master to deploy"
    type        = number
    default     = 0
}

# This variable is used to declare the replicas per primary of the Redis Cache
variable "replicas_per_primary" {
    description = "The number of replicas per primary to deploy"
    type        = number
    default     = 0
}

# This variable is used to declare the shard count of the Redis Cache
variable "shard_count" {
    description = "The number of shards to deploy"
    type        = number
    default     = 0
}

# This variable is used to declare whether public network access enabled or not
variable "public_network_access_enabled" {
    description = "Enable Public Network Access"
    type        = bool
}

# This variable is used to declare the Redis Configuration.
variable "redis_configuration" {
  description = "value for the redis configuration"
}

# This variable is used to declare the Storage Account name for Backup.
variable "bootstrap_storage_account_name" {
  type        = string
  description = "bootstrap sa"
}

# This variable is used to declare the Storage Account Resource Group name for Backup.
variable "bootstrap_storage_account_rg_name" {
  type        = string
  description = "bootstrap sa rg"
}

# This file contains the variable declarations for creating an Azure Virtual Machine.

# Name of the resource group for VM
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group for VM"
}

# Name of the resource group of VNET
variable "vnet_rg_name" {
  type        = string
  description = "Name of the resource group of VNET"
}

# Name of the Vnet
variable "vnet_name" {
  type        = string
  description = "Name of the Vnet"
}

# Name of apps Subnet
variable "subnet_name_db" {
  type        = string
  description = "Name of apps Subnet"
}

# Name of the storage account for boot diagnostics
variable "bootdiag_storage_account_name" {
  type        = string
  description = "Name of the storage account for boot diagnostics"
}

# Name of the resource group for boot diagnostics storage account
variable "bootdiag_storage_account_rg_name" {
  type        = string
  description = "Name of the resource group for boot diagnostics storage account"
}


# The password will be retrieved from the key vault.
variable "secret_key_vault_name" {
  type        = string
  description = "The password will be retrieved from the key vault."
}

# The password will be retrieved from the key vault resource group.
variable "secret_key_vault_rg_name" {
  type        = string
  description = "The password will be retrieved from the key vault resource group."
}

# Name of the application
variable "application_name" {
  type        = string
  description = "Name of the application"
}

# Name of the environment
variable "environment" {
  type        = string
  description = "Name of the environment"
}

# Name of the subscription
variable "subscription_name" {
  type        = string
  description = "Name of the subscription"
}

# SQL VM configurations
variable "sql-vm-DC10ANPOC6WDW-01" {
  description = "Map of configurations for the SQL VM"
}

