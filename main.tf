
data "template_file" "techops" {
  template = file("template/techops.json")
}

data "template_file" "userdata_techops" {
  template = templatefile("template/userdata_techops.sh", {
    AwsRegion      = var.AwsRegion
    EcsClusterName = module.ECSCluster.ECSClusterName
  })
}


module "security_group" {
  source  = "./modules/security_group"
  EnvName = var.EnvName
  Vpc     = var.Vpc
}

module "ecs-role" {
  source  = "./modules/ecs_role"
  EnvName = var.EnvName
}

module "ECSCluster" {
  source  = "./modules/ecs_cluster"
  EnvName = var.EnvName
}


module "TaskDefinitiontechops" {
  source              = "./modules/task_definition"
  EnvName             = var.EnvName
  Name                = "techops"
  ContainerDefinition = data.template_file.techops.rendered
  TaskDefRole         = module.ecs-role.TaskDefRoleArn
  Settings            = var.Ecs.TaskDefinitions.techops
}


module "Servicetechops" {
  source                     = "./modules/service"
  EnvName                    = var.EnvName
  Name                       = "techops"
  TaskDefRole                = module.ecs-role.TaskDefRoleArn
  Settings                   = var.Ecs
  ECSClusterName             = module.ECSCluster.ECSClusterName
  TaskDefinition             = module.TaskDefinitiontechops.TaskDefinitiontechops[0]
  TargetGroupArntechops     = module.alb.TargetGroupArntechops
}


# techops autoscaling module #
module "autoscaling_group_techops" {
  source                  = "./modules/autoscaling_group"
  Settings                = var.AutoScalingGroup.techops
  EnvName                 = var.EnvName
  EC2InstanceProfile      = module.ecs-role.EC2InstanceProfile
  KeyPair                 = var.KeyPair
  AMI                     = var.AMI
  UserData                = data.template_file.userdata_techops.rendered
  PublicSubnetId          = var.Vpc.PublicSubnetId
  InstanceSecurityGroupId = module.security_group.InstanceSecurityGroupId
  Name                    = "techops"
  TargetGroup             = [module.alb.TargetGroupArntechops]
}



module "alb" {
  source                       = "./modules/alb"
  EnvName                      = var.EnvName
  Settings                     = var.LoadBalancer
  Vpc                          = var.Vpc
  LoadBalancerSecurityGroupId = module.security_group.LoadBalancerSecurityGroupId
  AutoScalingGrouptechops    = module.autoscaling_group_techops.AutoScalingGrouptechopsName
}

