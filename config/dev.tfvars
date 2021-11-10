Vpc = {
  VpcId          = "vpc-04c4e91a04c374865"
  PublicSubnetId = ["subnet-0010554f040227d76", "subnet-03e586a2477de9644"]
}
AutoScalingGroup = {
  techops = {
    InstanceType           = "t3.small"
    MinSize                = "1"
    MaxSize                = "2"
    DesiredCapacity        = "1"
    InstanceVolumeSize     = "30"
    HealthCheckGracePeriod = 300
    HealthCheckType        = "EC2"
    DefaultCooldown        = 300
  }
}


LoadBalancer = {

  TargetGroups = {
    techops = {
      HealthyThreshold   = 3
      UnhealthyThreshold = 10
      Timeout            = 10
      Interval           = 20
      HealthCheckPath    = "/"
      HealthCheckPort    = "80"
    }
  }
}


Ecs = {
  TaskDefinitions = {
    techops = {
      Cpu    = 1000
      Memory = 900
    }
  },
  Services = {
    techops = {
      DesiredCount       = 1
      SchedulongStrategy = "REPLICA"
    }
  }
}

AwsRegion  = "us-east-2"
EnvName    = "ECS"
AMI        = "ami-0629230e074c580f2"
KeyPair    = "jenkinskey"




