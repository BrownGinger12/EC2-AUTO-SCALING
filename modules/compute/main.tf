resource "aws_launch_template" "this" {
  name_prefix   = "${var.name}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.this.id]

  user_data = base64encode(<<-EOF
      #!/bin/bash
      dnf install -y httpd
      echo "<h1>Hello World from $(hostname)</h1>" > /var/www/html/index.html
      systemctl enable --now httpd
    EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags          = { Name = "${var.name}-web" }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name_prefix         = "${var.name}-asg-"
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [var.target_group_arn]

  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  max_size         = var.max_size

  health_check_type         = "ELB"
  health_check_grace_period = 120              

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.name}-web"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "cpu" {
  name                   = "${var.name}-cpu-target"
  autoscaling_group_name = aws_autoscaling_group.this.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50
  }
}

resource "aws_security_group" "this" {
  name   = "${var.name}-sg"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "instance_all_out" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "instance_from_alb" {
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = var.alb_sg_id 
  from_port                    = 80                        
  to_port                      = 80
  ip_protocol                  = "tcp"
}