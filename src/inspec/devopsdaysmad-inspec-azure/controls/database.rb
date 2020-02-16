title "Check database pasionporlosbits"

resource_group = 'rg-devopsdays-pasion'
sql_server_name = 'pasionporlosbitsdbserver'
sql_database_name = 'pasionporlosbitsdatabase'

control 'azure_sql_database_pasionporlosbits' do
  title 'Check security settings of database'
    desc "Test settings of pasionporlosbits database"
    describe azurerm_sql_database(resource_group: resource_group, server_name: sql_server_name, database_name: sql_database_name) do
        it            { should exist }
        its('name')   { should eq sql_database_name}
        its('location') { should eq "westeurope" }
        its('sku.name') { should eq "Standard" }
        its('properties.collation') { should eq "SQL_Latin1_General_CP1_CI_AS"}
      end
end