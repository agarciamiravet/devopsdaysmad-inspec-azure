pipeline {
         agent any
         stages {
                 stage('Build terraform') {
                 steps {

                             dir("${env.WORKSPACE}/src"){
                              sh "terraform init"
                           }

                        withCredentials([file(credentialsId: 'tfvars', variable: 'tfvars')]) {
                           sh 'ls'
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
