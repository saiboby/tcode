provider "aws" {
    region   = "us-east-2"
    access_key = "xxxx"
    secret_key = "xxxx"
    
}

locals {
  env = "ECS_Optimized"
}

data "aws_ami" "example" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "tag:${local.env}"
    values = ["true"]  
 }

}

output "new_ami" {
  value = data.aws_ami.example.id
}


resource "aws_launch_template" "foo" {
  name = "foo"

  image_id = data.aws_ami.example.id

  instance_initiated_shutdown_behavior = "terminate"

  instance_market_options {
    market_type = "spot"
  }

  instance_type = "t2.micro"

  key_name = "myhapro"


  monitoring {
    enabled = true
  }


  placement {
    availability_zone = "us-east-2a"
  }



  vpc_security_group_ids = ["sg-041fe2882ab97ed42"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

}

resource "aws_autoscaling_group" "jenkins-slave" {
  availability_zones = ["us-east-2a"]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2

  health_check_grace_period = 30

  launch_template {
    id      = aws_launch_template.foo.id
    version = aws_launch_template.foo.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }
}
