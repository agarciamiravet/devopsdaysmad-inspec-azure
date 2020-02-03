pipeline {
         agent any
         stages {
                 stage('Build terraform') {
                     steps {

                                 withCredentials([file(credentialsId: 'terraform-simple-tfvars', variable: tfvars)]) {
                                    sh "terraform plan -var-file= $tfvars"
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
