resource "aws_launch_configuration" "LaunchConfiguration" {
  name_prefix          = "${terraform.workspace}-${var.EnvName}-${var.Name}"
  iam_instance_profile = var.EC2InstanceProfile
  image_id             = var.AMI
  instance_type        = var.Settings.InstanceType
  key_name             = var.KeyPair
  security_groups      = [var.InstanceSecurityGroupId]
  root_block_device {
    volume_size = var.Settings.InstanceVolumeSize
  }

  lifecycle {
    create_before_destroy = true
  }
  user_data = var.UserData

}

resource "aws_autoscaling_group" "AutoScalingGroup" {
  name                      = "${terraform.workspace}-${var.EnvName}-${var.Name}"
  vpc_zone_identifier       = var.PublicSubnetId
  launch_configuration      = aws_launch_configuration.LaunchConfiguration.name
  protect_from_scale_in     = false
  min_size                  = var.Settings.MinSize
  desired_capacity          = var.Settings.DesiredCapacity
  max_size                  = var.Settings.MaxSize
  health_check_grace_period = var.Settings.HealthCheckGracePeriod
  health_check_type         = var.Settings.HealthCheckType
  default_cooldown          = var.Settings.DefaultCooldown
  target_group_arns         = var.TargetGroup
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "${terraform.workspace}-${var.EnvName}-${var.Name}"
    propagate_at_launch = true
  }
}

