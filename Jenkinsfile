pipeline {
         agent any
          environment {
               ARM_CLIENT_ID     = credentials('jenkins-arm-client-id')
               ARM_CLIENT_SECRET = credentials('jenkins-arm-client-secret')
               ARM_SUBSCRIPTION_ID = credentials('jenkins-arm-subscription-id')
               ARM_TENANT_ID = credentials('jenkins-arm-tenant-id')
         }
         stages {
                 stage('Build terraform') {
                 steps {

                             dir("${env.WORKSPACE}/src"){
                              sh "terraform init"
                           }

                        withCredentials([file(credentialsId: 'tfvars', variable: 'tfvars')]) {
                            dir("${env.WORKSPACE}/src"){
                              sh 'cat $tfvars'

                              sh'terraform plan -var-file=$tfvars'
                           }
                        }
                 }
                 }
                 stage('Test') {
                 steps {
                    input('Do you want to proceed?')
                 }
                 }
                 stage('Prod') {
                     steps {
                                echo "App is Prod Ready"
                              }
                 }
                }
          }
