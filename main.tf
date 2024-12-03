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
  app_service_environment_id        = module.app-service-environment-sc-ase-poc-app-ws-dev-05.app_service_environment_id
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

module "app-service-environment-sc-ase-poc-dev-05" {
  source                        = "app.terraform.io/Molina-Cloud/appservices-environment/azurerm"
  version                       = "1.0.0"
  app_service_environment_name  = var.poc_ase_name_01
  resource_group_name           = data.azurerm_resource_group.resource-group-app-service.name
  subnet_id                     = data.azurerm_subnet.subnet-aps-data-sc-ase-poc-dev-05.id
  zone_redundant                = var.poc_ase_zone_redundant_01
  application_name              = var.application_name
  environment                   = var.environment
  ritm_number                   = var.poc_ase_ritm_number_01
  additional_tags               = {
        key1   = "value1"
        key2   = "value2"
  }  

  cluster_settings = {

    # Enable internal encryption
    cluster_setting01 = {
    name  = "DisableTls1.0"
    value = "1"
  }

    # Disable TLS 1.0 and TLS 1.1
    cluster_setting02 = {
    name  = "InternalEncryption"
    value = "true"
  }

    # TLS cipher suite order
    cluster_setting03 = {
    name  = "FrontEndSSLCipherSuiteOrder"
    value = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
  }
}

}

module "Privateendpoint-sc-sa-dns-dev-01" {
  source = "app.terraform.io/Molina-Cloud/privateendpoint/azurerm"
  version = "1.0.5"
  resource_group_name = data.azurerm_resource_group.RG-sc-dns-dev-01.name
  resource_group_location = data.azurerm_resource_group.RG-sc-dns-dev-01.location
  resource_name = data.azurerm_storage_account.dns_storage_account.name
  resource_id = data.azurerm_storage_account.dns_storage_account.id
  subresource_names = ["blob"]
  applicationname = "POC"
  ritm = "RITM00000"
  environment = "Development"
  subnet_id = data.azurerm_subnet.dns-subnet-sc-dev.id
  private_dns_zone_ids = [data.azurerm_private_dns_zone.dns_zone.id]
  private_dns_zone_name = data.azurerm_private_dns_zone.dns_zone.name
}


########## Redis Cache - SKU : Standard ##########

module "Redis_Cache_sc-redis-poc-dev-01" {
    source                          = "app.terraform.io/Molina-Cloud/rediscache/azurerm"
    version                         = "1.0.0"
    application_name        = var.application_name
    ritm_number             = var.ritm_number
    environment             = var.environment
    additional_tags         = var.additional_tags
    resource_group_name     = data.azurerm_resource_group.rg-redis-cache.name
    location                = data.azurerm_resource_group.rg-redis-cache.location
    redis_cache_name        = var.redis_cache_name
    redis_cache_capacity    = var.redis_cache_capacity
    sku_family              = var.sku_family
    sku_name                = var.sku_name
    redis_version           = var.redis_version
    availability_zones      = var.availability_zones
    replicas_per_master     = var.replicas_per_master         // only available when using the Premium SKU.
    replicas_per_primary    = var.replicas_per_primary        // If both replicas_per_primary and replicas_per_master are set, they need to be equal.
    shard_count             = var.shard_count                 // Only available when using the Premium SKU.
    public_network_access_enabled    = var.public_network_access_enabled
    minimum_tls_version              = "1.2"
    customer_managed_key_identity_id = data.azurerm_user_assigned_identity.redis-cache-mgid.id
    redis_configuration              = var.redis_configuration
    // rdb_storage_connection_string    = data.azurerm_storage_account.backup-storage-poc-dev.primary_blob_connection_string 
}

########## Redis Cache - SKU : Premium ##########

module "Redis_Cache-sc-redis-poc-dev-02" {
    source                          = "app.terraform.io/Molina-Cloud/rediscache/azurerm"
    version                         = "1.0.0"
    application_name        = var.application_name
    ritm_number             = var.ritm_number
    environment             = var.environment
    additional_tags         = var.additional_tags
    resource_group_name     = data.azurerm_resource_group.rg-redis-cache.name
    location                = data.azurerm_resource_group.rg-redis-cache.location
    redis_cache_name        = var.redis_cache_name
    redis_cache_capacity    = var.redis_cache_capacity
    sku_family              = var.sku_family
    sku_name                = var.sku_name
    redis_version           = var.redis_version
    availability_zones      = var.availability_zones
    replicas_per_master     = var.replicas_per_master         // only available when using the Premium SKU.
    replicas_per_primary    = var.replicas_per_primary        // If both replicas_per_primary and replicas_per_master are set, they need to be equal.
    shard_count             = var.shard_count                 // Only available when using the Premium SKU.
    public_network_access_enabled    = var.public_network_access_enabled
    minimum_tls_version              = "1.2"
    customer_managed_key_identity_id = data.azurerm_user_assigned_identity.redis-cache-mgid.id
    redis_configuration              = var.redis_configuration
    rdb_storage_connection_string    = data.azurerm_storage_account.backup-storage-poc-dev.primary_blob_connection_string 
}

#SQL server Creation
module "sql-vm-DC10ANPOC6WDW-01" {
  for_each                                           = var.sql-vm-DC10ANPOC6WDW-01
  source                                             = "app.terraform.io/Molina-Cloud/windows-virtualmachine-standalone-azure-disk/azurerm"
  version                                            = "1.0.0"
  subscription_name                                  = var.subscription_name
  vm_name                                            = each.value.vm_name
  server                                             = each.value.server
  Tshirtsize                                         = each.value.Tshirtsize
  exceptionsize                                      = each.value.exceptionsize
  server_type                                        = each.value.server_type
  resource_group_location                            = data.azurerm_resource_group.rg.location
  resource_group_name                                = data.azurerm_resource_group.rg.name
  vm_workload                                        = each.value.vm_workload
  network_interface_ids                              = [module.sql-db-nic-DC10ANPOC6WDW-01.nic_id]
  application_name                                   = var.application_name
  environment                                        = var.environment
  ritm_number                                        = each.value.ritm_number
  admin_username                                     = data.azurerm_key_vault_secret.admin_username.value
  admin_password                                     = data.azurerm_key_vault_secret.admin_password_secret.value
  availability_set_id                                = module.vm_av_set-DC10ANPOC6WDW.availability_set_id
  image_def_name                                     = each.value.image_def_name
  os_disk_storage_type                               = each.value.os_disk_storage_type
  os_disk_size                                       = each.value.os_disk_size
  storage_account_boot_diagnostics                   = data.azurerm_storage_account.storage_account.primary_blob_endpoint
  dataDiskArray                                      = each.value.dataDiskArray
  diskdetails                                        = each.value.diskdetails
  domain_join_password                               = data.azurerm_key_vault_secret.domain_join_password_secret.value
  additional_tags                                    = each.value.additional_tags
  delphixconnector                                   = each.value.delphixconnector
  patching_window                                    = each.value.patching_window
  vm_database_ip                                     = module.sql-db-nic-DC10ANPOC6WDW-01.nic_ip
  sql_year                                           = each.value.sql_year
  sql_Edition                                        = each.value.sql_Edition
  ansible_bearer_token                               = data.azurerm_key_vault_secret.ansible_bearer_token.value
  trigger_ansible                                    = each.value.trigger_ansible

   depends_on = [module.sql-db-nic-DC10ANPOC6WDW-01]

}
