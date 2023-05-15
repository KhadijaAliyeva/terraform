pipeline {
  agent any

  parameters {
    string(name: 'instance_name', defaultValue: '', description: 'The name of the EC2 instance to create or destroy')
    string(name: 'aws_access_key_id', defaultValue: '', description: 'The AWS access key ID')
    string(name: 'aws_secret_access_key', defaultValue: '', description: 'The AWS secret access key')
    string(name: 'aws_region', defaultValue: 'us-west-2', description: 'The AWS region')
    string(name: 'action', defaultValue: '', description: 'The action to perform (create or destroy)')
  }

  stages {
    stage('Checkout') {
      steps {
        checkout([$class: 'GitSCM',
                  branches: [[name: '*/main']], // Replace with the desired branch
                  userRemoteConfigs: [[url: 'https://github.com/KhadijaAliyeva/terraform.git']]])
      }
    }

    stage('Terraform Init') {
      steps {
        withCredentials([string(credentialsId: 'aws-credentials', variable: 'AWS_CREDENTIALS')]) {
          sh 'echo "$AWS_CREDENTIALS" > /tmp/aws-credentials'
          withEnv(['AWS_SHARED_CREDENTIALS_FILE=/tmp/aws-credentials']) {
            sh 'terraform init'
          }
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials([string(credentialsId: 'aws-credentials', variable: 'AWS_CREDENTIALS')]) {
          sh 'echo "$AWS_CREDENTIALS" > /tmp/aws-credentials'
          withEnv(['AWS_SHARED_CREDENTIALS_FILE=/tmp/aws-credentials']) {
            sh "terraform apply -auto-approve -var 'region=us-west-2' -var 'instance_name=${params.instance_name}' -var 'ami=${var.ami}' -var 'instance_type=${var.instance_type}' -var 'key_name=${var.key_name}' -var 'subnet_id=${var.subnet_id}'"
          }
        }
      }
    }

    stage('Terraform Destroy') {
      steps {
        withCredentials([string(credentialsId: 'aws-credentials', variable: 'AWS_CREDENTIALS')]) {
          sh 'echo "$AWS_CREDENTIALS" > /tmp/aws-credentials'
          withEnv(['AWS_SHARED_CREDENTIALS_FILE=/tmp/aws-credentials']) {
            sh "terraform destroy -auto-approve -var 'region=us-west-2' -var 'instance_name=${params.instance_name}'"
          }
        }
      }
    }
  }
}
