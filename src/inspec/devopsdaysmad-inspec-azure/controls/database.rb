title "Check database pasionporlosbits"

#Read data from terraform output
terraformContent = inspec.profile.file('terraform.json')
terraformsParams = JSON.parse(terraformContent)

resource_group = terraformsParams['resource_group_name']['value']
sql_server_name = terraformsParams['database_server_name']['value']
sql_database_name = terraformsParams['sql_database_name']['value']

control 'azure_sql_database_pasionporlosbits' do
    describe azurerm_sql_database(resource_group: resource_group, server_name: sql_server_name, database_name: sql_database_name) do
        it            { should exist }
        its('name')   { should eq sql_database_name}
        its('location') { should eq "westeurope" }
        its('sku.name') { should eq "Standard" }
        its('properties.collation') { should eq "SQL_Latin1_General_CP1_CI_AS"}
        its('auditing_settings') { should have_attributes(retentionDays: 0)}
        its('encryption_protector') { should cmp 'aa'  }
      end
end