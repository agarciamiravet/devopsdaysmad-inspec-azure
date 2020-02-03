pipeline {
         agent any
         stages {
                 stage('Build terraform') {
                 steps {
                           dir("${env.WORKSPACE}/src"){
                           sh "terraform init"                           
                              withCredentials([file(credentialsId: 'terraform-simple-tfvars', variable: SFILE)]) {
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
