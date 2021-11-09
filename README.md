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

Moreover,after the 
