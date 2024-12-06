This activity is to convert Below are the ARM template resource block properties, site config, app settings and connection strings for the website "". Convert the ARM template into Terraform and update the provided Terraform Code module block with respective  site config, app settings and connection strings in terraform format only. The App Service TErraform Module is a dynamic block so I can add any settings in the  site config, app settings and connection strings section, but I cannot add new variables into terraform. Give an output with the completed terraform module block that considers all that ARM template is providing.

# xcSearchWebAppNameTidy


ARM Template:
Dependencies
"""clientCertEnabled"": true,
""serverFarmId"": ""[resourceId('Microsoft.Web/serverfarms', variables('xcBasicHostingPlanNameTidy'))]"",
""siteConfig"": {
  ""use32BitWorkerProcess"": false,
  ""alwaysOn"": true,
  ""phpVersion"": """",
  ""defaultDocuments"": [
    ""index.html""
  ]
}
""[resourceId('Microsoft.Web/serverfarms', variables('xcBasicHostingPlanNameTidy'))]"""
"""IIS Web Application Name"": ""[variables('xcSearchWebAppNameTidy')]"",
              ""Database Server Name"": ""[variables('sqlServerFqdnTidy')]"",
              ""Collection Database Server Name"": ""[variables('sqlServerFqdnTidy')]"",
              ""Collection Shard Map Manager Database Name"": ""[variables('shardMapManagerSqlDatabaseNameTidy')]"",
              ""Processing Pools Database Name"": ""[variables('poolsSqlDatabaseNameTidy')]"",
              ""Marketing Automation Database Name"": ""[variables('maSqlDatabaseNameTidy')]"",
              ""Reference Data Database Name"": ""[variables('refDataSqlDatabaseNameTidy')]"",
              ""Messaging Connection String"": ""[listkeys(resourceId(subscription().subscriptionId, resourceGroup().name, 'Microsoft.ServiceBus/namespaces/authorizationRules', variables('azureServiceBusNamespaceNameTidy'), parameters('azureServiceBusAccessKeyName')), variables('azureServiceBusVersion')).primaryConnectionString]"",
              ""Collection Database Application User Name"": ""[parameters('xcShardMapManagerSqlDatabaseUserName')]"",
              ""Collection Database Application User Password"": ""[parameters('xcShardMapManagerSqlDatabasePassword')]"",
              ""Processing Pool Database Application User Name"": ""[parameters('poolsSqlDatabaseUserName')]"",
              ""Processing Pool Database Application User Password"": ""[parameters('poolsSqlDatabasePassword')]"",
              ""Marketing Automation Database Application User Name"": ""[parameters('xcMaSqlDatabaseUserName')]"",
              ""Marketing Automation Database Application User Password"": ""[parameters('xcMaSqlDatabasePassword')]"",
              ""Reference Data Database Application User Name"": ""[parameters('xcRefDataSqlDatabaseUserName')]"",
              ""Reference Data Database Application User Password"": ""[parameters('xcRefDataSqlDatabasePassword')]"",
              ""XConnect Server Configuration Environment"": ""[parameters('xcServerConfigurationEnvironment')]"",
              ""XConnect Server Certificate Validation Thumbprint"": ""[parameters('authCertificateThumbprint')]"",
              ""Allow Invalid Client Certificates"": ""[parameters('allowInvalidClientCertificates')]"",
              ""XConnect Server Application Insights Key"": ""[if(parameters('useApplicationInsights'), reference(resourceId('Microsoft.Insights/Components', variables('appInsightsNameTidy')), variables('appInsightsApiVersion')).InstrumentationKey, '')]"",
              ""XP Performance Counters Type"": ""[if(parameters('useApplicationInsights'), concat('Sitecore:XConnect:Diagnostics:PerformanceCounters:', parameters('xpPerformanceCountersType')), 'Sitecore:XConnect:Diagnostics:PerformanceCounters:Disable')]"",
              ""XConnect Server Instance Name"": ""CollectionSearch"",
              ""License Xml"": ""[parameters('licenseXml')]"",
              ""Search SOLR Core Application Connection String"": ""[variables('xcSolrConnectionString')]""
('xcSearchWebAppNameTidy'), 'appsettings'"
"""minTlsVersion"": ""[parameters('minTlsVersion')]"",
        ""WEBSITE_DYNAMIC_CACHE"": 0,
        ""SITECORE_ENVIRONMENT_TYPE"": ""[parameters('environmentType')]"""



Terraform;
sc-app-xcSearchWebAppNameTidy-dev-01 = {
    app_service_name = "sc-app-xcSearchWebAppNameTidy-dev-01"
    public_network_access_enabled = false
    vnet_integration_required = false
    ritm_number = "RITM12345"
    client_affinity_enabled = false
    client_certificate_enabled = false    
    client_certificate_mode = "Required"
    site_config  = {
      always_on                                     = true
      default_documents                             = ["index.html"]
      ftps_state                                    = "FtpsOnly"
      http2_enabled                                 = fals
      load_balancing_mode                           = "LeastRequests"
      managed_pipeline_mode                         = "Integrated"
      scm_use_main_ip_restriction                   = false
      use_32_bit_worker                             = false
      vnet_route_all_enabled                        = true
      worker_count                                  = 1  
      application_stack = {
      phpVersion               = ""
      } 
    },
    app_setting = [
      {
      name = "CURRENT_STACK"
      value = "dotnetcore"
      },
      {
      name = "WEBSITE_RUN_FROM_PACKAGE"
      value = "1"
      },
      {
      name = "WEBSITE_WEBDEPLOY_USE_SCM"
      value = "false"
      }
    ]
    connection_string = {
      connection_string01 = {
      name  = "coreSqlDatabaseNameTidy"
      type  = "Custom"
      value = "123#abc"
      }
      connection_string02 = {
        name  = "POC02"
        type  = "Custom"
        value = "123#abc"
      }
    },
    enable_backup = true
    backup_settings = {
        enabled                  = true
        name                     = "sc-app-poc-dev-03-backup"
        schedule = {
        frequency_interval       = 7
        frequency_unit           = "Day"
        retention_period_days    = 30
        keep_at_least_one_backup = false
        //start_time               =
      }
    }
  },
