pipeline {
  agent any


  stages {
    stage('Checkout') {
      steps {
        checkout([$class: 'GitSCM',
                  branches: [[name: '*/main']], // Replace with the desired branch
                  userRemoteConfigs: [[url: 'https://github.com/KhadijaAliyeva/terraform.git']]]) // Replace with your GitHub repository URL
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
  }

  
}
