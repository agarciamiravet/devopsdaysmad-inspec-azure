pipeline {
         agent any
          environment {
               ARM_CLIENT_ID     = credentials('jenkins-arm-client-id')
               ARM_CLIENT_SECRET = credentials('jenkins-arm-client-secret')
               ARM_SUBSCRIPTION_ID = credentials('jenkins-arm-subscription-id')
               ARM_TENANT_ID = credentials('jenkins-arm-tenant-id')

               DNSIMPLE_TOKEN = credentials('jenkins-dnsimple-token')
               DNSIMPLE_ACCOUNT = credentials('jenkins-dnsimple-account')

               AZURE_SUBSCRIPTION_ID = credentials('jenkins-arm-subscription-id')
               AZURE_CLIENT_ID = credentials('jenkins-arm-client-id')
               AZURE_TENANT_ID = credentials('jenkins-arm-tenant-id')
               AZURE_CLIENT_SECRET = credentials('jenkins-arm-client-secret')
         }
         stages {
                 stage('Terraform plan') {
                  steps {

                              dir("${env.WORKSPACE}/src/terraform"){
                                 sh "terraform init"
                              }

                           withCredentials([file(credentialsId: 'tfvars', variable: 'tfvars')]) {
                              dir("${env.WORKSPACE}/src/terraform"){         
                                 sh'terraform plan -var-file=$tfvars'
                              }
                           }
                  }
                 }
                 stage('Terraform apply') {
                  steps {
                        withCredentials([file(credentialsId: 'tfvars', variable: 'tfvars')]) {
                              dir("${env.WORKSPACE}/src/terraform"){         
                                 sh'terraform apply -var-file=$tfvars -auto-approve'
                              }
                        }
                  }
                 }

                 stage ('Azure WebApp build and publish') {
                    steps {
                        dir("${env.WORKSPACE}/src/app"){         
                                 sh'dotnet publish -c release -o package'
                              }
                    }
                 }

                 stage('Azure WebApp deploy') {
                  steps {
                        withCredentials([file(credentialsId: 'tfvars', variable: 'tfvars')]) {
                              dir("${env.WORKSPACE}/src/app"){
                                  azureWebAppPublish azureCredentialsId: params.azure_cred_id,  
                                  resourceGroup: 'rg-devopsdays-pasion', appName: 'pasiondebits', sourceDirectory: 'package'          
                              }
                        }
                  }
                 }
               }
          }
