resource "azurerm_app_service" "siHostingPlanNameTidy" {
  name                = "siHostingPlanNameTidy"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.siHostingPlan.id

  # Site Configuration
  site_config {
    use_32_bit_worker_process = var.use_32_bit_worker_process
    always_on                 = var.always_on
    php_version               = var.php_version
    default_documents         = var.default_documents
  }

  # App Settings
  app_settings = {
    "Database Server Name"             = var.sql_server_fqdn_tidy
    "Collection Database Server Name"  = var.sql_server_fqdn_tidy
    "Collection Shard Map Manager DB"  = var.shard_map_manager_sql_database_name_tidy
    "Processing Pools DB Name"         = var.pools_sql_database_name_tidy
    "Marketing Automation DB Name"     = var.ma_sql_database_name_tidy
    "Reference Data DB Name"           = var.ref_data_sql_database_name_tidy
    "Messaging Connection String"      = azurerm_servicebus_namespace_authorization_rule.siServiceBusPrimaryConnectionString.primary_connection_string
    "Collection DB App User Name"      = var.xc_shard_map_manager_sql_database_user_name
    "Collection DB App User Password"  = var.xc_shard_map_manager_sql_database_password
    "Processing Pool DB App User Name" = var.pools_sql_database_user_name
    "Processing Pool DB App User Password" = var.pools_sql_database_password
    "Marketing Automation DB App User Name" = var.xc_ma_sql_database_user_name
    "Marketing Automation DB App User Password" = var.xc_ma_sql_database_password
    "Reference Data DB App User Name"  = var.xc_ref_data_sql_database_user_name
    "Reference Data DB App User Password" = var.xc_ref_data_sql_database_password
    "XConnect Server Configuration Env" = var.xc_server_configuration_environment
    "XConnect Server Certificate Thumbprint" = var.auth_certificate_thumbprint
    "Allow Invalid Client Certificates" = var.allow_invalid_client_certificates
    "XConnect Server App Insights Key" = var.use_application_insights ? azurerm_application_insights.siAppInsights.instrumentation_key : ""
    "XP Performance Counters Type"      = var.use_application_insights ? "Sitecore:XConnect:Diagnostics:PerformanceCounters:${var.xp_performance_counters_type}" : "Sitecore:XConnect:Diagnostics:PerformanceCounters:Disable"
    "XConnect Server Instance Name"     = "CollectionSearch"
    "License Xml"                       = var.license_xml
    "Search SOLR Core Connection String" = var.xc_solr_connection_string
    "minTlsVersion"                     = var.min_tls_version
    "WEBSITE_DYNAMIC_CACHE"             = "0"
    "SITECORE_ENVIRONMENT_TYPE"         = var.environment_type
  }

  # Connection Strings
  connection_strings {
    name  = "MessagingConnectionString"
    value = azurerm_servicebus_namespace_authorization_rule.siServiceBusPrimaryConnectionString.primary_connection_string
    type  = "Custom"
  }

  depends_on = [
    azurerm_app_service_plan.siHostingPlan,
    azurerm_servicebus_namespace_authorization_rule.siServiceBusPrimaryConnectionString
  ]
}
