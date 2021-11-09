# Jenkins Pipeline to Automate ECS Task Deployment

This pipeline shows the placement of a new task in a Service present in AWS ECS.

## Steps Involved

To achieve this goal, one can follow several approaches but the one followed here involves below mentioned steps:

- Logging into ECR
- Building the Image
- Testing and Pushing the image 
- Writing a Custom Task Definition
- Create a New Task with Task definition
- Updating the Existing Service

## Breif Explanation of Procedure

Firstly, we get into the ECR repo where we have pushed our image. After logg, we will build the image and test whether the image is build succesfully or not. After that we will push the image because the image would be needed in the task definition. The task definition is written in task.json used by the task when being placed in Service in ECS. 

Moreover,after this, a new task will be deployed in the next step. We are not creating a new cluster because for a production environment, you donot want to create a new cluster everytime jenkins job is triggered. Also, we have the service created with the name app present in ECS. Once the pipeline is triggered, a new task will spin up and new deployment would be made in ECS

### Recomendations

This goal can be acheived by several methods like preparing an IAC by terraform and using it in pipeline and other different approaches. You have to look at the scenario and decide best possible approach that suits you.
