pipeline {   
  agent any 
  environment {
       TF_VAR_aws_account_id="${AWS_ACCOUNT_ID}"
       TF_VAR_region="${AWS_REGION}"
    }
  parameters {
        text(name: 'AWS_REGION', defaultValue: 'us-east-2', description: 'Enter region')
        text(name: 'AWS_ACCOUNT_ID', defaultValue: '366047659530', description: 'Enter id')
    }
  stages {
    stage('Checkout external proj') {
        steps {
            git branch: 'main',
                credentialsId: 'github-credentials',
                url: 'https://github.com/akhalif121/jenkins_pipeline.git'
        }
    }

        stage('Terraform init') {
            steps {
                script {
                    sh 'terraform init'
                }
        }        
    }

        stage('Terraform deployment stage') {
            steps {
                script {
                    sh 'terraform apply -var-file=./config/dev/dev.tfvars --auto-approve'
                }
        }        
    }     
  }
}
