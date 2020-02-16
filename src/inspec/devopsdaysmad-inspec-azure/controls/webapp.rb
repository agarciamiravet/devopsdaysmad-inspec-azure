title "Check web app pasionporlosbits"

resource_group = 'rg-devopsdays-pasion'

control "azure_webapp_pasionporlosbits"
title 'Check security settings of webapp'
describe azurerm_webapp(resource_group: resource_group, name: 'pasiondebits') do
  it { should exist }
  its('properties.httpsOnly') { should cmp true }
  its('properties.enabledHostNames') { should include "www.pasionporlosbits.com" }
  its('configuration.properties') { should have_attributes(http20Enabled: true) }
  its('configuration.properties') { should have_attributes(minTlsVersion: "1.2")}
end