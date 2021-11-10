# Jenkins Pipeline to Automate ECS Task Deployment

This pipeline deployes and AWS ECS cluster with complete needed resources scripted with terraform.

## Steps Involved

To achieve this goal by Jenkins Pipeline, one can follow several approaches but the one followed here involves below mentioned steps:

- Getting Code From Git Repo
- Initializing the Terraform
- Applying Terraform Script
- Auto-approval given to deploy

## Breif Explanation of Procedure

We have written a terraform code for automating our infrastructure. This consists of AWS ECS service completed provisioned by terraform script. This script will spin up a docker container managed on ECS.
Following multiple resources would be deployed automatically once jenkins pipeline is triggered:

1. ECSCluster                           4. ECS Auto Scaling             7. Security Group  
2. ECS service                          5. IAM Roles 
3. ECS Task with defintion              6. Load Balancer   

There are multiple resources which will be created once we deploy the terraform through jenkins job. Jenkins job will get the code from this repo on GitHub. It will initialize the code and will be building the dependencies. Once building the dependencies is done, it will apply the terraform script with command in next step and our infra would be up and running. 
### Recomendations

This goal can be acheived by several methods like building docker images and using it to deploy task with pipeline and other different approaches. We will have a jenkins job which will build docker image and push it to a repo and build a task from it and upload it to ECS service.

Remember,we are not creating a new cluster because for a production environment, you do not want to create a new cluster everytime jenkins job is triggered. Also, we have the service created with the name app present in ECS. Once the pipeline is triggered, a new task will spin up and new deployment would be made in ECS
