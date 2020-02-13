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
         stages 
         {
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
                                 sh'dotnet publish -c release'
                              }
                    }
                 }

                 stage('Azure WebApp deploy') {
                  steps {
                                  azureWebAppPublish azureCredentialsId: 'azure-sp-credentials',
                                  resourceGroup: 'rg-devopsdays-pasion', appName: 'pasiondebits', sourceDirectory: 'src/app/pasionporlosbits/bin/Release/netcoreapp3.1/publish/'          
                         }
                  }

                 stage ('Inspec app tests') {
                   steps {
                           
                            dir("${env.WORKSPACE}/src/inspec/devopsdaysmad-inspec-app"){
                              sh '''
                                  echo '' | openssl s_client -host www.pasionporlosbits.com -port 443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > cert.pem
                                  ls
                                  cat cert.pem                            
                                  inspec exec . --chef-license=accept --reporter cli junit:testresults.xml json:output.json --no-create-lockfile
                              '''
                           }                                             
                   }
                 }

                  stage('Upload tests in Grafana') {
                        steps {
                             dir("${env.WORKSPACE}/src/inspec/devopsdaysmad-inspec-app"){                                   
                                   sh '''
                                        ls
                                        curl -F 'file=@output.json' -F 'platform=azure-pasionporlosbits' https://83d1daeb.ngrok.io/api/InspecResults/Upload
                                   '''                                   
                           }                      
                        }
                    }

                 }
                 post {
                         always {
                                junit '**/src/inspec/devopsdaysmad-inspec-app/*.xml'
                             }
                 }
          }
