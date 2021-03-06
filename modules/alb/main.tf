resource "aws_lb" "alb" {
  name                       = "${terraform.workspace}-${var.EnvName}-ALB"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.LoadBalancerSecurityGroupId]
  subnets                    = var.Vpc.PublicSubnetId
  enable_deletion_protection = false
}

# creating target group for wordpress #
resource "aws_lb_target_group" "alb_target_group_techops" {
  name       = "${terraform.workspace}-${var.EnvName}-TargetGroup"
  port       = "80"
  protocol   = "HTTP"
  vpc_id     = var.Vpc.VpcId
  depends_on = [aws_lb.alb]
  health_check {
    healthy_threshold   = var.Settings.TargetGroups.techops.HealthyThreshold
    unhealthy_threshold = var.Settings.TargetGroups.techops.UnhealthyThreshold
    timeout             = var.Settings.TargetGroups.techops.Timeout
    interval            = var.Settings.TargetGroups.techops.Interval
    path                = var.Settings.TargetGroups.techops.HealthCheckPath
    port                = var.Settings.TargetGroups.techops.HealthCheckPort
    matcher             = "200-400"
  }
}

# Attaching target group to Asg #
resource "aws_autoscaling_attachment" "asg_attachment_techops" {
  autoscaling_group_name = var.AutoScalingGrouptechops
  alb_target_group_arn   = aws_lb_target_group.alb_target_group_techops.arn
}

# create Listner for the TG #
resource "aws_lb_listener" "listener_techops" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group_techops.arn

  }
}



