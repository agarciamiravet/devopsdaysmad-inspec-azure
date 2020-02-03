pipeline {
         agent any
         stages {
                 stage('Build terraform') {
                 steps {
                           dir("${env.WORKSPACE}/src"){
                           sh "terraform init"

                           terraform-simple-tfvars
                              withCredentials([file(credentialsId: 'secretFile', variable: SFILE)]) {
                                sh "terraform plan -var-file= ${SFILE}"
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
