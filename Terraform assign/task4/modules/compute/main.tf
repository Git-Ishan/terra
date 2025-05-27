resource "aws_launch_template" "web" {
  name_prefix   = "web-server"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.web_sg]
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      volume_type = "gp2"
    }
  }

  user_data = var.user_data
  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, { Tier = "Web" })
  }
}

resource "aws_launch_template" "app" {
  name_prefix   = "app-server"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.app_sg]
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      volume_type = "gp2"
    }
  }

  user_data = var.user_data

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, { Tier = "App" })
  }
}

resource "aws_lb_target_group" "web" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path = "/"
  }
}

resource "aws_lb_target_group" "app" {
  name     = "app-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path = "/health"
  }
}

resource "aws_autoscaling_group" "web" {
  name_prefix          = "web-asg-"
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  vpc_zone_identifier  = var.web_subnets
  target_group_arns    = [aws_lb_target_group.web.arn]

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "app" {
  name_prefix          = "app-asg-"
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  vpc_zone_identifier  = var.app_subnets
  target_group_arns    = [aws_lb_target_group.app.arn]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}
