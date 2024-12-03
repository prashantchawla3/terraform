data "azurerm_resource_group" "resource-group-app-service" {
  name = "app-service-resource-group-name"
}

data "azurerm_resource_group" "RG-sc-dns-dev-01" {
  name = "dns-resource-group-name"
}

data "azurerm_resource_group" "rg-redis-cache" {
  name = "redis-cache-resource-group-name"
}

data "azurerm_subnet" "vnet-int-subnet-sc-asp-poc-app-ls-dev-01" {
  name                 = "subnet-name-for-app-service"
  virtual_network_name = "vnet-name"
  resource_group_name  = data.azurerm_resource_group.resource-group-app-service.name
}

data "azurerm_subnet" "subnet-aps-data-sc-ase-poc-dev-05" {
  name                 = "ase-subnet-name"
  virtual_network_name = "vnet-name-for-ase"
  resource_group_name  = data.azurerm_resource_group.resource-group-app-service.name
}

data "azurerm_subnet" "dns-subnet-sc-dev" {
  name                 = "dns-subnet-name"
  virtual_network_name = "dns-vnet-name"
  resource_group_name  = data.azurerm_resource_group.RG-sc-dns-dev-01.name
}

data "azurerm_storage_account" "storage_account_backup" {
  name                = "storage-account-backup-name"
  resource_group_name = data.azurerm_resource_group.resource-group-app-service.name
}

data "azurerm_storage_account" "dns_storage_account" {
  name                = "dns-storage-account-name"
  resource_group_name = data.azurerm_resource_group.RG-sc-dns-dev-01.name
}

data "azurerm_private_dns_zone" "dns_zone" {
  name                = "private-dns-zone-name"
  resource_group_name = data.azurerm_resource_group.RG-sc-dns-dev-01.name
}

data "azurerm_user_assigned_identity" "redis-cache-mgid" {
  name                = "redis-cache-identity-name"
  resource_group_name = data.azurerm_resource_group.rg-redis-cache.name
}

data "azurerm_key_vault_secret" "admin_username" {
  name         = "admin-username"
  key_vault_id = "key-vault-id"
}

data "azurerm_key_vault_secret" "admin_password_secret" {
  name         = "admin-password"
  key_vault_id = "key-vault-id"
}

data "azurerm_key_vault_secret" "domain_join_password_secret" {
  name         = "domain-join-password"
  key_vault_id = "key-vault-id"
}

data "azurerm_key_vault_secret" "ansible_bearer_token" {
  name         = "ansible-bearer-token"
  key_vault_id = "key-vault-id"
}

data "azurerm_storage_container" "storage-account-container-backup" {
  name                 = "backup-container-name"
  storage_account_name = data.azurerm_storage_account.storage_account_backup.name
}

data "azurerm_storage_account_blob_container_sas" "Storage-account-backup-container-sas" {
  storage_account_name = data.azurerm_storage_account.storage_account_backup.name
  container_name       = data.azurerm_storage_container.storage-account-container-backup.name
  permissions          = "rw"
  expiry               = "2024-12-31T23:59:59Z"
}

# Modules
module "app-service-plan-sc-asp-poc-app-ws-dev-01" {
  source                            = "app.terraform.io/Molina-Cloud/appservices-plan/azurerm"
  version                           = "1.0.0"  
  service_plan_name                 = var.poc_asp_name_01
  resource_group_name               = data.azurerm_resource_group.resource-group-app-service.name
  resource_group_location           = data.azurerm_resource_group.resource-group-app-service.location
  os_type                           = var.poc_asp_os_type_01
  ritm_number                       = var.poc_asp_ritm_number_01
  application_name                  = var.application_name
  per_site_scaling_enabled          = var.poc_asp_per_site_scaling_enabled_01
  environment                       = var.environment       
  worker_count                      = var.poc_asp_worker_count_01 
  app_service_environment_required  = var.poc_asp_service_environment_required_01
  app_service_environment_id        = module.app-service-environment-sc-ase-poc-dev-05.app_service_environment_id
  zone_balancing_enabled            = var.poc_asp_zone_balancing_enabled_01
  sku_name                          = var.poc_asp_sku_name_01
  additional_tags                   = {
        key1   = "value1"
        key2   = "value2"
  }
}

module "web-app-sc-asp-poc-app-ls-dev-01" {
  for_each                      = var.app_service_sc-asp-poc-app-ls-dev-01
  source                        = "app.terraform.io/Molina-Cloud/appservices-linux/azurerm"
  version                       = "1.0.0"
  app_service_name              = each.value.app_service_name
  resource_group_name           = data.azurerm_resource_group.resource-group-app-service.name
  resource_group_location       = data.azurerm_resource_group.resource-group-app-service.location
  service_plan_id               = module.app-service-plan-sc-asp-poc-app-ls-dev-01.service_plan_id
  public_network_access_enabled = each.value.public_network_access_enabled
  client_certificate_mode       = each.value.client_certificate_mode
  client_affinity_enabled       = each.value.client_affinity_enabled
  client_certificate_enabled    = each.value.client_certificate_enabled  
  vnet_integration_required     = each.value.vnet_integration_required
  vnet_integration_subnet_id    = each.value.vnet_integration_required ? data.azurerm_subnet.vnet-int-subnet-sc-asp-poc-app-ls-dev-01.id : "NA"
  application_name              = var.application_name
  environment                   = var.environment
  ritm_number                   = each.value.ritm_number
  app_setting                   = each.value.app_setting
  site_config                   = each.value.site_config
  connection_strings            = each.value.connection_string
  storage_account_url           = "https://${data.azurerm_storage_account.storage_account_backup.name}.blob.core.windows.net/${data.azurerm_storage_container.storage-account-container-backup.name}${data.azurerm_storage_account_blob_container_sas.Storage-account-backup-container-sas.sas}"
  enable_backup                 = each.value.enable_backup
  backup_settings               = each.value.backup_settings
  additional_tags               = each.value.additional_tags
}

module "Redis_Cache_sc-redis-poc-dev-01" {
  source                          = "app.terraform.io/Molina-Cloud/rediscache/azurerm"
  version                         = "1.0.0"
  application_name                = var.application_name
  ritm_number                     = var.ritm_number
  environment                     = var.environment
  additional_tags                 = var.additional_tags
  resource_group_name             = data.azurerm_resource_group.rg-redis-cache.name
  location                        = data.azurerm_resource_group.rg-redis-cache.location
  redis_cache_name                = var.redis_cache_name
  redis_cache_capacity            = var.redis_cache_capacity
  sku_family                      = var.sku_family
  sku_name                        = var.sku_name
  redis_version                   = var.redis_version
  availability_zones              = var.availability_zones
  replicas_per_master             = var.replicas_per_master
  replicas_per_primary            = var.replicas_per_primary
  shard_count                     = var.shard_count
  public_network_access_enabled   = var.public_network_access_enabled
  minimum_tls_version             = "1.2"
  customer_managed_key_identity_id = data.azurerm_user_assigned_identity.redis-cache-mgid.id
  redis_configuration             = var.redis_configuration
}

# Add other modules similarly, updating variables and data references as necessary
