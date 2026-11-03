resource "aws_lb" "this" {
  name               = "web-alb"
  internal           = false                          
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this.id]
  subnets            = var.public_subnet_ids

  tags = { Name = "web-alb" }
}

resource "aws_lb_target_group" "this" {
  name        = "instance-tg"
  port        = 80                     
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"            

  health_check {
    path                = "/"         
    matcher             = "200"
    interval            = 15
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = { Name = "instance-tg" }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_security_group" "this" {
  name   = "alb-sg"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "alb_to_instance" {
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = var.asg_sg_id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "alb_http_in" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

