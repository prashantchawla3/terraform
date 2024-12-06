resource "azurerm_app_service" "xcSearchWebAppNameTidy" {
  name                = "xcSearchWebAppNameTidy"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.xcBasicHostingPlanNameTidy.id

  site_config {
    use_32_bit_worker_process = false
    always_on                 = true
    php_version               = ""
    default_documents         = ["index.html"]
  }

  app_settings = {
    "IIS Web Application Name"                      = "xcSearchWebAppNameTidy"
    "Database Server Name"                           = var.sql_server_fqdn_tidy
    "Collection Database Server Name"                = var.sql_server_fqdn_tidy
    "Collection Shard Map Manager Database Name"     = var.shard_map_manager_sql_database_name_tidy
    "Processing Pools Database Name"                 = var.pools_sql_database_name_tidy
    "Marketing Automation Database Name"             = var.ma_sql_database_name_tidy
    "Reference Data Database Name"                   = var.ref_data_sql_database_name_tidy
    "Messaging Connection String"                    = azurerm_servicebus_namespace_authorization_rule.xcServiceBusPrimaryConnectionString.primary_connection_string
    "Collection Database Application User Name"      = var.xc_shard_map_manager_sql_database_user_name
    "Collection Database Application User Password"  = var.xc_shard_map_manager_sql_database_password
    "Processing Pool Database Application User Name" = var.pools_sql_database_user_name
    "Processing Pool Database Application User Password" = var.pools_sql_database_password
    "Marketing Automation Database Application User Name" = var.xc_ma_sql_database_user_name
    "Marketing Automation Database Application User Password" = var.xc_ma_sql_database_password
    "Reference Data Database Application User Name"  = var.xc_ref_data_sql_database_user_name
    "Reference Data Database Application User Password" = var.xc_ref_data_sql_database_password
    "XConnect Server Configuration Environment"      = var.xc_server_configuration_environment
    "XConnect Server Certificate Validation Thumbprint" = var.auth_certificate_thumbprint
    "Allow Invalid Client Certificates"               = var.allow_invalid_client_certificates
    "XConnect Server Application Insights Key"       = var.use_application_insights ? azurerm_application_insights.xcAppInsights.instrumentation_key : ""
    "XP Performance Counters Type"                    = var.use_application_insights ? "Sitecore:XConnect:Diagnostics:PerformanceCounters:${var.xp_performance_counters_type}" : "Sitecore:XConnect:Diagnostics:PerformanceCounters:Disable"
    "XConnect Server Instance Name"                   = "CollectionSearch"
    "License Xml"                                     = var.license_xml
    "Search SOLR Core Application Connection String"  = var.xc_solr_connection_string
    "minTlsVersion"                                   = var.min_tls_version
    "WEBSITE_DYNAMIC_CACHE"                           = "0"
    "SITECORE_ENVIRONMENT_TYPE"                       = var.environment_type
  }

  connection_strings {
    name  = "MessagingConnectionString"
    value = azurerm_servicebus_namespace_authorization_rule.xcServiceBusPrimaryConnectionString.primary_connection_string
    type  = "Custom"
  }

  depends_on = [
    azurerm_app_service_plan.xcBasicHostingPlanNameTidy,
    azurerm_servicebus_namespace_authorization_rule.xcServiceBusPrimaryConnectionString
  ]
}
