pipeline {
         agent any
         stages {
                 stage('Build terraform') {
                 steps {

                             dir("${env.WORKSPACE}/src"){
                              sh "terraform init"
                           }

                        withCredentials([file(credentialsId: 'tfvars', variable: 'tfvars')]) {
                            dir("${env.WORKSPACE}/src"){
                              sh "cp \$tfvars ${env.WORKSPACE}/terraform-simple.auto.tfvars"
                              sh "terraform plan var-file=terraform-simple.auto.tfvars"
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
