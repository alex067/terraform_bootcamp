resource "aws_security_group" "lb_to_ec2" {
  name        = "allow_lb_to_ec2"
  description = "Allow ALB to EC2 inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "ALB to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    self        = true
  }

  tags = merge(local.tags, {
    Name = "allow_lb_to_ec2"
  })
}

resource "aws_lb" "main" {
  name               = "terraform-bootcamp-module-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_to_ec2.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = merge(local.tags, {
    Name = "terraform-bootcamp-module-alb"
  })
}

resource "aws_lb_target_group" "main" {
  name        = "terraform-bootcamp-module-alb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
}

resource "aws_lb_target_group_attachment" "serverA" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.serverA.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "serverB" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.serverB.id
  port             = 80
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}


