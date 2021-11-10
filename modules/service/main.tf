

resource "aws_ecs_service" "techops" {
  count               = var.Name == "techops" ? 1 : 0
  name                = var.Name
  cluster             = var.ECSClusterName
  task_definition     = var.TaskDefinition
  desired_count       = var.Settings.Services.techops.DesiredCount
  scheduling_strategy = var.Settings.Services.techops.SchedulongStrategy

  load_balancer {
    target_group_arn = var.TargetGroupArntechops
    container_name   = "techops"
    container_port   = 80
  }
  deployment_controller {
    type = "ECS"
  }
}

